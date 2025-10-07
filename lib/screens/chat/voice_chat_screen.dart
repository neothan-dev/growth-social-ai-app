/** Copyright © 2025 Neothan
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *     http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:just_audio/just_audio.dart' as just_audio;
import 'package:audio_session/audio_session.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:provider/provider.dart';
import '../../services/network_service.dart';
import '../../services/navigation_manager.dart';
import '../../services/voice_style_service.dart';
import '../../services/user_manager.dart';
import '../../config/voice_config.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../widgets/background_container.dart';
import '../../utils/asset_manager.dart';
import '../../localization/app_localizations.dart';

class VoiceChatScreen extends StatefulWidget {
  const VoiceChatScreen({Key? key}) : super(key: key);

  @override
  State<VoiceChatScreen> createState() => _VoiceChatScreenState();
}

// 语音状态（仅三种）
enum VoiceStatus { listening, thinking, answering }

class _VoiceChatScreenState extends State<VoiceChatScreen>
    with TickerProviderStateMixin {
  final _recorder = FlutterSoundRecorder();
  final _player = just_audio.AudioPlayer();
  WebSocketManager? _wsManager;
  StreamSubscription? _wsSubscription;
  bool _isRecording = false;
  // 已精简：移除情绪/意图/置信度展示
  String _currentSubtitle = '';
  bool _showSubtitles = true;
  int _totalSegments = 0;
  int _currentSegmentIndex = 0;
  bool _isFirstVoiceChat = false;
  bool _isConfirmedWellcomeMessageInFirstVoiceChat = false;

  final List<Map<String, dynamic>> _audioQueue = [];
  bool _isPlayingQueue = false;
  StreamController<Uint8List>? _audioController;
  Timer? _iosChunkTimer;
  Timer? _androidFrameTimer;
  int _lastSentLength = 0;
  // iOS临时录音路径曾用于增量读取，现不再需要
  // String? _iosRecordPath;

  List<Uint8List> _androidAudioBuffer = [];
  bool _androidFrameProcessing = false;
  // DateTime? _lastAndroidFrameTime; // 未使用
  int _silenceCount = 0;
  int _low_volum_count = 0;
  int _frame_count = 0;
  double _current_volume = 0.0;
  double _volumeThreshold = 0;
  List<double> _volumeHistory = [];
  bool _is_processing = false;
  int _playingAudioCnt = 0;
  StreamSubscription? _playerStateSubscription;

  // 三状态动画控制器
  late final AnimationController _listeningController;
  late final AnimationController _thinkingController;
  late final AnimationController _answeringController;
  // 平滑后的聆听强度 0.0~1.0，用于控制圈大小
  double _smoothedListeningLevel = 0.0;

  static const int _calibrationFrameCount = VoiceConfig.calibrationFrameCount;
  static const int _volumeHistorySize = VoiceConfig.volumeHistorySize;
  static const double _minVolumeThreshold = VoiceConfig.minVolumeThreshold;
  static const double _maxVolumeThreshold = VoiceConfig.maxVolumeThreshold;
  static const double _adaptiveFactor = VoiceConfig.adaptiveFactor;
  static const int _androidFrameInterval = VoiceConfig.androidFrameInterval;
  static const int _iosFrameInterval = VoiceConfig.iosFrameInterval;
  static const int _silenceThreshold = VoiceConfig.silenceThreshold;

  // static const int _androidBufferSize = VoiceConfig.androidBufferSize; // 未使用
  static const int _androidMaxBufferFrames = VoiceConfig.androidMaxBufferFrames;
  static const bool _enableAndroidFrameThrottling =
      VoiceConfig.enableAndroidFrameThrottling;

  bool _isCalibrating = false;
  int _currentCalibrationFrame = 0;

  bool _recorderOpened = false;

  late final NavigationManager _navigationManager;

  final VoiceStyleService _voiceStyleService = VoiceStyleService.instance;
  // 本地路由栈：记录通过语音导航推入的页面
  final List<String> _routeStack = [];

  Future<double> _getCurrentVolume(Uint8List pcmData) async {
    if (pcmData.isEmpty) return 0.0;
    final buffer = pcmData.buffer.asInt16List();
    double sum = 0;
    for (var v in buffer) {
      sum += v.abs();
    }
    return sum / buffer.length / VoiceConfig.volumeNormalizationFactor;
  }

  void _updateVolumeHistory(double volume) {
    _volumeHistory.add(volume);
    if (_volumeHistory.length > _volumeHistorySize) {
      _volumeHistory.removeAt(0);
    }
  }

  double _calculateAmbientVolume() {
    if (_volumeHistory.isEmpty) return 0;

    final sortedVolumes = List<double>.from(_volumeHistory)..sort();
    final medianIndex = sortedVolumes.length ~/ 2;
    double ambientVolume;

    if (sortedVolumes.length % 2 == 0) {
      ambientVolume =
          (sortedVolumes[medianIndex - 1] + sortedVolumes[medianIndex]) / 2;
    } else {
      ambientVolume = sortedVolumes[medianIndex];
    }

    return ambientVolume;
  }

  void _adjustVolumeThreshold() {
    if (_isCalibrating) return;

    final ambientVolume = _calculateAmbientVolume();

    double newThreshold = (ambientVolume * _adaptiveFactor).clamp(
      _minVolumeThreshold,
      _maxVolumeThreshold,
    );

    _volumeThreshold = _volumeThreshold * 0.7 + newThreshold * 0.3;

    print(
      '动态调整音量阈值: 环境音量=${ambientVolume.toStringAsFixed(4)}, '
      '新阈值=${_volumeThreshold.toStringAsFixed(4)}'
      'new=${newThreshold.toStringAsFixed(4)}',
    );

    if (mounted) {
      setState(() {});
    }
  }

  void _initCalibration() {
    _volumeHistory.clear();
    _currentCalibrationFrame = 0;
    _isCalibrating = true;

    print('开始环境音量校准...');
  }

  void _stopCalibration() {
    print('停止环境校准...');
    _isCalibrating = false;
    if (mounted) {
      setState(() {});
    }

    final ambientVolume = _calculateAmbientVolume();
    _volumeThreshold = (ambientVolume * _adaptiveFactor).clamp(
      _minVolumeThreshold,
      _maxVolumeThreshold,
    );

    print(
      '环境校准完成: 环境音量=${ambientVolume.toStringAsFixed(4)}, '
      '设定阈值=${_volumeThreshold.toStringAsFixed(4)}',
    );
  }

  @override
  void initState() {
    super.initState();
    _navigationManager = NavigationManager.instance;
    print('VoiceChatScreen: 初始化完成');

    // 初始化本地路由栈（首帧获取当前路由名）
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final initial =
          ModalRoute.of(context)?.settings.name ?? '/voice_chat_screen';
      if (_routeStack.isEmpty) {
        _routeStack.add(initial);
      }
    });

    // 初始化动画控制器
    _listeningController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
    _thinkingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat();
    _answeringController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final userManager = Provider.of<UserManager>(context, listen: false);
      final hasShownWelcomeMessage = await userManager.HasShownVoiceChatTip();
      if (!hasShownWelcomeMessage) {
        _showWelcomeMessage();
        userManager.ShowVoiceChatTip();
        _isFirstVoiceChat = true;
        while (!_isConfirmedWellcomeMessageInFirstVoiceChat) {
          await Future.delayed(const Duration(milliseconds: 100));
        }
      }
      _autoStartRecording();
    });
  }

  void _showWelcomeMessage() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.waving_hand, color: Colors.orange),
            SizedBox(width: 8),
            Text("c7d17a7029rghM3kYRpS".tr),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("aa62916a19RoRcAwasiE".tr),
            SizedBox(height: 16),
            Text(
              "a6707ba72eBJdQxJS0dU".tr,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("b3844785b1qJZSDqgrOG".tr),
            Text("62aed836fb8xzqh46vCz".tr),
            Text("31619cd20cEw1UsLnqbP".tr),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (mounted) {
                _isConfirmedWellcomeMessageInFirstVoiceChat = true;
                Navigator.of(context).pop();
              }
            },
            child: Text("e07d14e12aP5qsPZ2LOo".tr),
          ),
        ],
      ),
    );
  }

  void _handleBackPress() {
    if (_isFirstVoiceChat) {
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil('/dashboard_screen', (route) => false);
      _routeStack.clear();
      _routeStack.add('/dashboard_screen');
    } else {
      if (mounted) {
        Navigator.of(context).pop();
        if (_routeStack.length > 1) {
          _routeStack.removeLast();
        }
      }
    }
  }

  void _autoStartRecording() async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (mounted && !_isRecording) {
      _startRecording();
    }
  }

  Future<bool> _checkMicPermission() async {
    if (!Platform.isAndroid) return true;
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      status = await Permission.microphone.request();
    }
    return status.isGranted;
  }

  void serverListenCallback(data) async {
    if (!_isRecording) return;
    final info = jsonDecode(data);
    if (info['type'] == 'audio_segment') {
      print("收到单个音频段: ${info['index'] + 1}/${info['total']}");

      _playingAudioCnt++;
      if (mounted) {
        setState(() {});
      }

      _audioQueue.add(info);

      if (!_isPlayingQueue) {
        _playAudioQueue();
      }
    } else if (info['type'] == 'conclution') {
      if (mounted && _isRecording) {
        setState(() {
          _is_processing = false;
        });

        if (info['navigation'] != null) {
          print('VoiceChatScreen: 收到WebSocket导航数据: ${info['navigation']}');
          // 维护本地路由栈
          try {
            final nav = info['navigation'];
            final navType = nav['type'];
            final action = nav['action'];
            final route = nav['route'];
            if (navType == 'page_navigation' &&
                route is String &&
                route.isNotEmpty) {
              _routeStack.add(route);
              print(
                'RouteStack push -> ' +
                    route +
                    ' stack: ' +
                    _routeStack.toString(),
              );
            } else if (navType == 'action' && action is String) {
              if (action == 'back') {
                if (_routeStack.length > 1) {
                  _routeStack.removeLast();
                }
                print('RouteStack pop(back) stack: ' + _routeStack.toString());
              } else if (action == 'home') {
                _routeStack.clear();
                _routeStack.add('/dashboard_screen');
                print(
                  'RouteStack reset(home) stack: ' + _routeStack.toString(),
                );
              }
            }
          } catch (e) {
            print('维护本地路由栈失败: ' + e.toString());
          }
          await _navigationManager.handleVoiceNavigation(
            info['navigation'],
            context,
          );
        } else {
          print('VoiceChatScreen: WebSocket数据中没有导航信息');
        }
      }
    }
  }

  /// 获取当前页面的路由信息
  String _getCurrentRoute() {
    try {
      if (_routeStack.isNotEmpty) {
        return _routeStack.last;
      }
      final route = ModalRoute.of(context)?.settings.name;
      return route ?? 'unknown';
    } catch (e) {
      print('获取当前路由失败: $e');
      return 'unknown';
    }
  }

  /// 获取当前页面的详细信息
  Map<String, dynamic> _getCurrentPageInfo() {
    try {
      final route = _getCurrentRoute();
      final routeData = ModalRoute.of(context)?.settings.arguments;

      return {
        'route': route,
        'route_data': routeData,
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      print('获取当前页面信息失败: $e');
      return {
        'route': 'unknown',
        'route_data': null,
        'timestamp': DateTime.now().toIso8601String(),
      };
    }
  }

  void _clearAudioQueue() {
    _audioQueue.clear();
    _isPlayingQueue = false;
  }

  Future<void> _playAudioQueue() async {
    if (_isPlayingQueue || _audioQueue.isEmpty) return;

    _isPlayingQueue = true;

    try {
      while (_audioQueue.isNotEmpty) {
        final info = _audioQueue.removeAt(0);

        if (mounted) {
          setState(() {
            _currentSubtitle = info['text'] ?? '';
            _currentSegmentIndex = info['index'];
            _totalSegments = info['total'];
          });
        }

        try {
          final audioData = base64Decode(info['base64audio']);
          final tempDir = await getTemporaryDirectory();
          final tempFile = File(
            '${tempDir.path}/ai_audio_segment_${info['index']}.wav',
          );
          await tempFile.writeAsBytes(audioData, flush: true);

          await _player.stop();
          await Future.delayed(const Duration(milliseconds: 5));

          await _player.setFilePath(tempFile.path);
          await _player.seek(Duration.zero);
          await _player.play();

          await _player.playerStateStream.firstWhere(
            (state) =>
                state.processingState == just_audio.ProcessingState.completed,
          );

          if (info['index'] < info['total'] - 1) {
            await Future.delayed(const Duration(milliseconds: 200));
          }
        } catch (e) {
          debugPrint('音频段 ${info['index']} 处理异常: $e');
          continue;
        } finally {
          _playingAudioCnt--;
        }
      }

      if (mounted) {
        setState(() {
          _currentSubtitle = '';
          _currentSegmentIndex = 0;
          _totalSegments = 0;
        });
      }
    } catch (e) {
      debugPrint('音频队列播放异常: $e');
    } finally {
      _isPlayingQueue = false;
    }
  }

  void _iosListenerCallback(filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      final bytes = await file.readAsBytes();
      if (bytes.length > _lastSentLength) {
        final chunk = bytes.sublist(_lastSentLength);
        _lastSentLength = bytes.length;
        _current_volume = await _getCurrentVolume(chunk);
        _updateVolumeHistory(_current_volume);

        if (_isCalibrating) {
          _currentCalibrationFrame++;

          if (mounted) {
            setState(() {});
          }

          if (_currentCalibrationFrame >= _calibrationFrameCount) {
            _stopCalibration();
            print('环境校准完成，开始发送音频数据');
          }
          return;
        }

        _adjustVolumeThreshold();
        // 更新聆听强度（基于当前音量与阈值的相对比例，做平滑）
        final double _baseIos = (_volumeThreshold <= 0)
            ? 0.01
            : _volumeThreshold * 1.2;
        final double _targetLevelIos = (_current_volume / _baseIos).clamp(
          0.0,
          1.0,
        );
        _smoothedListeningLevel =
            _smoothedListeningLevel * 0.75 + _targetLevelIos * 0.25;
        if (mounted) setState(() {});
        print(
          "???${_is_processing}, ${_playingAudioCnt}, ${_isWebSocketConnected()}",
        );

        if (_is_processing) {
          print('iOS: 跳过音频处理，_is_processing = true');
          return;
        }

        if (_playingAudioCnt > 0) {
          print('iOS: 回声消除，跳过音频发送');
          return;
        }

        if (!_isWebSocketConnected()) {
          print('iOS: WebSocket未连接，跳过音频发送');
          _lastSentLength = bytes.length;
          return;
        }

        _sendAudioData(chunk);
        print('iOS: 发送音频数据，帧数: $_frame_count');

        _frame_count++;
        if (_current_volume < _volumeThreshold) {
          _silenceCount++;
          _low_volum_count++;
          if (_silenceCount >= _silenceThreshold) {
            bool ignore_flag = _low_volum_count / _frame_count > 0.9;
            // 获取当前页面信息
            final currentPageInfo = _getCurrentPageInfo();

            _sendAudioData(
              jsonEncode({
                "end_of_utterance": true,
                "ignore_flag": ignore_flag,
                "current_page": currentPageInfo,
              }),
            );
            _silenceCount = 0;
            _low_volum_count = 0;
            _frame_count = 0;
            if (!ignore_flag) {
              _is_processing = true;
            }
            setState(() {});
          }
        } else {
          _silenceCount = 0;
        }
      }
    }
  }

  void _androidListenerCallback(buffer) async {
    if (_enableAndroidFrameThrottling) {
      _androidAudioBuffer.add(buffer);

      if (_androidAudioBuffer.length > _androidMaxBufferFrames) {
        _androidAudioBuffer.removeAt(0);
      }

      if (_androidFrameTimer == null) {
        _startAndroidFrameTimer();
      }
      return;
    }

    await _processAndroidAudioFrame(buffer);
  }

  void _startAndroidFrameTimer() {
    _androidFrameTimer = Timer.periodic(
      Duration(milliseconds: _androidFrameInterval),
      (timer) async {
        await _processAndroidFrameBuffer();
      },
    );
  }

  Future<void> _processAndroidFrameBuffer() async {
    if (_androidAudioBuffer.isEmpty || _androidFrameProcessing) {
      return;
    }

    _androidFrameProcessing = true;

    try {
      Uint8List combinedBuffer = _combineAudioBuffers(_androidAudioBuffer);
      _androidAudioBuffer.clear();

      await _processAndroidAudioFrame(combinedBuffer);
    } finally {
      _androidFrameProcessing = false;
    }
  }

  Uint8List _combineAudioBuffers(List<Uint8List> buffers) {
    if (buffers.isEmpty) return Uint8List(0);
    if (buffers.length == 1) return buffers.first;

    int totalLength = 0;
    for (var buffer in buffers) {
      totalLength += buffer.length;
    }

    Uint8List combined = Uint8List(totalLength);
    int offset = 0;
    for (var buffer in buffers) {
      combined.setRange(offset, offset + buffer.length, buffer);
      offset += buffer.length;
    }

    return combined;
  }

  Future<void> _processAndroidAudioFrame(Uint8List buffer) async {
    _current_volume = await _getCurrentVolume(buffer);
    _updateVolumeHistory(_current_volume);

    if (_isCalibrating) {
      _currentCalibrationFrame++;

      if (mounted) {
        setState(() {});
      }

      if (_currentCalibrationFrame >= _calibrationFrameCount) {
        _stopCalibration();
        print('环境校准完成，开始发送音频数据');
      }
      return;
    }

    _adjustVolumeThreshold();
    // 更新聆听强度（基于当前音量与阈值的相对比例，做平滑）
    final double _baseAndroid = (_volumeThreshold <= 0)
        ? 0.01
        : _volumeThreshold * 1.2;
    final double _targetLevelAndroid = (_current_volume / _baseAndroid).clamp(
      0.0,
      1.0,
    );
    _smoothedListeningLevel =
        _smoothedListeningLevel * 0.75 + _targetLevelAndroid * 0.25;
    if (mounted) setState(() {});

    if (_is_processing) {
      print('Android: 跳过音频处理，_is_processing = true');
      return;
    }

    if (_playingAudioCnt > 0) {
      print('Android: 回声消除，跳过音频发送');
      return;
    }

    if (!_isWebSocketConnected()) {
      print('Android: WebSocket未连接，跳过音频发送');
      return;
    }

    _sendAudioData(buffer);
    print('Android: 发送音频数据，帧数: $_frame_count');

    _frame_count++;
    if (_current_volume < _volumeThreshold) {
      _low_volum_count++;
      _silenceCount++;
      if (_silenceCount >= _silenceThreshold) {
        bool ignore_flag = _low_volum_count / _frame_count > 0.9;
        // 获取当前页面信息
        final currentPageInfo = _getCurrentPageInfo();

        _sendAudioData(
          jsonEncode({
            "end_of_utterance": true,
            "ignore_flag": ignore_flag,
            "current_page": currentPageInfo,
          }),
        );
        _low_volum_count = 0;
        _silenceCount = 0;
        _frame_count = 0;
        if (!ignore_flag) {
          _is_processing = true;
        }
        setState(() {});
      }
    } else {
      _silenceCount = 0;
    }
  }

  Future<void> _startRecording() async {
    final hasPermission = await _checkMicPermission();
    if (!hasPermission) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('请授予麦克风权限')));
      }
      return;
    }

    await _cleanupResources();

    try {
      // 配置音频会话以避免iOS音频优先级冲突
      if (Platform.isIOS) {
        final session = await AudioSession.instance;
        await session.configure(
          AudioSessionConfiguration(
            avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
            avAudioSessionCategoryOptions:
                AVAudioSessionCategoryOptions.defaultToSpeaker,
            avAudioSessionMode: AVAudioSessionMode.defaultMode,
            avAudioSessionRouteSharingPolicy:
                AVAudioSessionRouteSharingPolicy.defaultPolicy,
            avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
            androidAudioAttributes: const AndroidAudioAttributes(
              contentType: AndroidAudioContentType.speech,
              flags: AndroidAudioFlags.none,
              usage: AndroidAudioUsage.media,
            ),
            androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
            androidWillPauseWhenDucked: true,
          ),
        );
      }

      _wsManager = WebSocketManager();
      await _wsManager!.connect('/ai/voice_chat', requireAuth: true);

      final currentVoiceStyle = _voiceStyleService.currentVoiceStyle;
      if (currentVoiceStyle.id.isNotEmpty) {
        _sendAudioData(
          jsonEncode({
            "type": "voice_style",
            "voice_style": currentVoiceStyle.id,
          }),
        );
        print('发送音色信息: ${currentVoiceStyle.id} (${currentVoiceStyle.name})');
      }

      _wsSubscription = _wsManager!.channel?.stream.listen(
        serverListenCallback,
      );

      if (!_recorderOpened) {
        // 配置音频会话以避免优先级冲突
        await _recorder.openRecorder();
        _recorderOpened = true;
      }

      setState(() => _isRecording = true);

      _initCalibration();

      if (Platform.isAndroid) {
        _audioController = StreamController<Uint8List>();
        _audioController!.stream.listen(_androidListenerCallback);
        await _recorder.startRecorder(
          toStream: _audioController!.sink,
          codec: Codec.pcm16WAV,
        );
      } else if (Platform.isIOS || Platform.isMacOS) {
        final tempDir = await getTemporaryDirectory();
        final filePath = '${tempDir.path}/temp_record.wav';
        _lastSentLength = 0;
        _iosChunkTimer = Timer.periodic(
          const Duration(milliseconds: _iosFrameInterval),
          (timer) async {
            _iosListenerCallback(filePath);
          },
        );
        await _recorder.startRecorder(toFile: filePath, codec: Codec.pcm16WAV);
      }
    } catch (e, stack) {
      debugPrint('录音启动异常: $e\n$stack');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('录音启动异常: $e')));
      }
    }
  }

  bool _isWebSocketConnected() {
    return _wsManager?.channel?.sink != null;
  }

  void _sendAudioData(dynamic audioData) {
    try {
      if (_isWebSocketConnected()) {
        _wsManager!.channel!.sink.add(audioData);
        print('发送音频数据成功，帧数: $_frame_count');
      } else {
        print('WebSocket未连接，无法发送音频数据');
      }
    } catch (e) {
      print('发送音频数据异常: $e');
    }
  }

  Future<void> _cleanupResources() async {
    try {
      await _wsSubscription?.cancel();
      _wsSubscription = null;

      _wsManager?.disconnect();
      _wsManager = null;

      await _audioController?.close();
      _audioController = null;

      _iosChunkTimer?.cancel();
      _iosChunkTimer = null;

      _androidFrameTimer?.cancel();
      _androidFrameTimer = null;

      _playerStateSubscription?.cancel();
      _playerStateSubscription = null;

      if (_recorderOpened) {
        await _recorder.stopRecorder();
        await _recorder.closeRecorder();
        _recorderOpened = false;
      }

      _volumeThreshold = 0;
      _isRecording = false;
      _is_processing = false;
      _isCalibrating = false;
      _currentCalibrationFrame = 0;
      _silenceCount = 0;
      _low_volum_count = 0;
      _frame_count = 0;
      _volumeHistory.clear();
      _currentSubtitle = '';
      _currentSegmentIndex = 0;
      _totalSegments = 0;

      _androidAudioBuffer.clear();
      _androidFrameProcessing = false;

      _clearAudioQueue();

      print('资源清理完成');
    } catch (e) {
      debugPrint('资源清理异常: $e');
    }
  }

  // 旧的手动停止录音方法已不再使用

  @override
  void dispose() {
    _listeningController.dispose();
    _thinkingController.dispose();
    _answeringController.dispose();
    _wsSubscription?.cancel();
    _wsManager?.disconnect();
    _audioController?.close();
    _iosChunkTimer?.cancel();
    _androidFrameTimer?.cancel();
    _playerStateSubscription?.cancel();
    _recorder.closeRecorder();
    _player.dispose();

    _clearAudioQueue();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => _handleBackPress(),
        ),
        title: Text(
          "90ab8d60142HKo0uKVAR".tr,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(1, 1),
                blurRadius: 2,
                color: Colors.black54,
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _showSubtitles = !_showSubtitles;
              });
            },
            icon: Icon(
              _showSubtitles ? Icons.subtitles : Icons.subtitles_off,
              color: Colors.white,
            ),
            tooltip: _showSubtitles
                ? "b479f4bb3fDLsoRstd8F".tr
                : "d0a33016f8Pda6dapkJg".tr,
          ),
        ],
      ),
      body: BackgroundContainer(
        backgroundName: AppBackgrounds.chatBackground,
        overlayColor: Colors.black.withValues(alpha: 0.2),
        child: Stack(
          children: [
            Container(),

            if (_isRecording)
              Positioned(
                left: 16,
                right: 16,
                top: 460,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: _isRecording ? 1.0 : 0.0,
                  child: _buildStatusCard(),
                ),
              ),

            if (_showSubtitles && _currentSubtitle.isNotEmpty)
              _buildOverlaySubtitle(),
          ],
        ),
      ),
    );
  }

  // 旧信息卡已移除

  // 旧信息单元已删除

  // 旧音量卡已移除

  Widget _buildOverlaySubtitle() {
    return Positioned(
      left: 16,
      right: 16,
      top: 635,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: _currentSubtitle.isNotEmpty ? 1.0 : 0.0,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.8),
                Colors.black.withValues(alpha: 0.9),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                constraints: const BoxConstraints(maxHeight: 100),
                child: SingleChildScrollView(
                  child: Text(
                    _currentSubtitle,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              if (_totalSegments > 1) ...[
                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < _totalSegments; i++)
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: i == _currentSegmentIndex ? 12 : 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: i == _currentSegmentIndex
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.4),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 6),

                Text(
                  '${_currentSegmentIndex + 1} / $_totalSegments',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

extension on _VoiceChatScreenState {
  VoiceStatus _currentVoiceStatus() {
    if (_playingAudioCnt > 0) return VoiceStatus.answering;
    if (_is_processing) return VoiceStatus.thinking;
    return VoiceStatus.listening;
  }

  Widget _buildStatusCard() {
    final status = _currentVoiceStatus();
    Color borderColor;
    Color textColor;
    IconData icon;
    String textKey;

    if (_isCalibrating) {
      borderColor = Colors.orange;
      textColor = Colors.orange;
      icon = Icons.tune;
      textKey = "874e99c7c1bUlWkLhPBC"; // 适配环境中
    } else {
      switch (status) {
        case VoiceStatus.answering:
          borderColor = const Color.fromARGB(255, 221, 119, 239);
          textColor = Colors.purple;
          icon = Icons.play_arrow;
          textKey = "243240f8e9qh1tdPMPrS"; // 正在回答（播放AI音频）
          break;
        case VoiceStatus.thinking:
          borderColor = Colors.orange;
          textColor = Colors.orange;
          icon = Icons.psychology;
          textKey = "05415c120detlnX34V8S"; // 正在思考
          break;
        case VoiceStatus.listening:
          borderColor = const Color.fromARGB(255, 112, 239, 117);
          textColor = const Color.fromARGB(255, 117, 240, 121);
          icon = Icons.hearing;
          textKey = "d71dcf99e1cTkM3RpwrJ"; // 正在聆听
          break;
      }
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.17),
            Colors.white.withValues(alpha: 0.17),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: borderColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: borderColor, width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 16, color: textColor),
                const SizedBox(width: 8),
                Text(
                  textKey.tr,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: _isCalibrating
                  ? _CalibrationProgress(
                      key: const ValueKey('calibrating'),
                      current: _currentCalibrationFrame,
                      total: _VoiceChatScreenState._calibrationFrameCount,
                      color: textColor,
                    )
                  : switch (status) {
                      VoiceStatus.listening => _ListeningWaves(
                        key: const ValueKey('listening'),
                        controller: _listeningController,
                        level: _smoothedListeningLevel,
                        color: textColor,
                      ),
                      VoiceStatus.thinking => _ThinkingDots(
                        key: const ValueKey('thinking'),
                        controller: _thinkingController,
                        color: textColor,
                      ),
                      VoiceStatus.answering => _AnsweringBars(
                        key: const ValueKey('answering'),
                        controller: _answeringController,
                        color: textColor,
                      ),
                    },
            ),
          ),
        ],
      ),
    );
  }
}

class _ListeningWaves extends StatelessWidget {
  final AnimationController controller;
  final Color color;
  final double level; // 0.0~1.0，决定圈的基础半径
  const _ListeningWaves({
    super.key,
    required this.controller,
    required this.color,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          final t = controller.value; // 0..1 循环相位
          // 使用非线性映射增强低音量可见度
          final nonLinear = math.sqrt(level.clamp(0.0, 1.0));
          // 放大尺寸变化：范围约 50~140
          final double baseOuter = 50 + nonLinear * 90; // 最外圈目标半径
          final double ringGap = 12 + nonLinear * 16; // 圈间距 12~28
          final double centerSize = 14 + nonLinear * 16; // 中心圆 14~30
          return Stack(
            alignment: Alignment.center,
            children: [
              _circle(baseOuter, (1 - t) * 0.5),
              _circle(baseOuter - ringGap, (1 - ((t + 0.33) % 1.0)) * 0.5),
              _circle(baseOuter - 2 * ringGap, (1 - ((t + 0.66) % 1.0)) * 0.5),
              Container(
                width: centerSize,
                height: centerSize,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _circle(double size, double opacity) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: color.withValues(alpha: opacity.clamp(0.1, 0.5)),
          width: 2,
        ),
      ),
    );
  }
}

class _ThinkingDots extends StatelessWidget {
  final AnimationController controller;
  final Color color;
  const _ThinkingDots({
    super.key,
    required this.controller,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          final v = controller.value; // 0..1
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(3, (i) {
              // 改为从左到右依次动画：左侧点相位领先
              final phase = (v + (2 - i) * 0.2) % 1.0;
              final scale = 0.7 + 0.3 * (1 - (phase - 0.5).abs() * 2);
              final dotScale = 0.8 + 0.6 * scale; // 0.8~1.4 更明显
              final translateY = -6 * scale; // 上浮更明显
              return Transform.translate(
                offset: Offset(0, translateY),
                child: Transform.scale(
                  scale: dotScale,
                  child: Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.5 + 0.5 * scale),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

class _AnsweringBars extends StatelessWidget {
  final AnimationController controller;
  final Color color;
  const _AnsweringBars({
    super.key,
    required this.controller,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 60,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          final v = controller.value; // 0..1
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (i) {
              // 改为从左到右：左侧柱先动，右侧柱后动
              final phase = (v + (4 - i) * 0.15) % 1.0;
              final h = 20 + 30 * (0.5 + 0.5 * (1 - (phase - 0.5).abs() * 2));
              return Container(
                width: 10,
                height: h,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

class _CalibrationProgress extends StatelessWidget {
  final int current;
  final int total;
  final Color color;
  const _CalibrationProgress({
    super.key,
    required this.current,
    required this.total,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final double ratio = total > 0 ? (current / total).clamp(0.0, 1.0) : 0.0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.tune, color: color, size: 18),
            const SizedBox(width: 8),
            Text(
              "5e8aeb0946liE3XagexM".tr + '$current/$total',
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 220,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: ratio,
              backgroundColor: color.withValues(alpha: 0.15),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
        ),
      ],
    );
  }
}
