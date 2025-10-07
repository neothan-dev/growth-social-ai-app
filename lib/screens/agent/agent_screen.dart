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
import 'package:provider/provider.dart';
import 'package:vital_ai/widgets/background_container.dart';
import '../../models/message.dart';
import '../../widgets/agent/agent_message_bubble.dart';
import '../../widgets/agent/agent_input_field.dart';
import '../../services/ai_service.dart';
import '../../services/chat_storage_sqlite_service.dart';
import '../../services/user_manager.dart';
import '../../utils/database_manager.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import '../../services/speech_service.dart';
import 'dart:io';
import 'dart:convert';
import '../../localization/app_localizations.dart';

class AgentScreen extends StatefulWidget {
  const AgentScreen({super.key});

  @override
  State<AgentScreen> createState() => _AgentScreenState();
}

class _AgentScreenState extends State<AgentScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Message> _messages = [];
  final AIService _aiService = AIService();
  final SpeechService _speechService = SpeechService();
  final ChatStorageSQLiteService _chatStorage = ChatStorageSQLiteService();

  bool _isLoading = false;
  bool _isListening = false;
  bool _showVoiceTip = false;

  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _recorderOpened = false;
  String? _recordFilePath;

  @override
  void initState() {
    super.initState();
    _loadChatHistory();
  }

  Future<void> _loadChatHistory() async {
    final userManager = Provider.of<UserManager>(context, listen: false);
    final userId = userManager.currentUser?.id;

    if (userId == null) {
      _addWelcomeMessage();
      return;
    }

    final savedMessages = await _chatStorage.loadChatHistory(userId);

    if (savedMessages.isEmpty) {
      _addWelcomeMessage();
      setState(() {});
    } else {
      setState(() {
        _messages.addAll(savedMessages);
      });
    }
  }

  void _addWelcomeMessage() {
    String content = "638cb777fcIrueh2QvF2".tr;
    _addMessage(content, false);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    _addMessage(text, true);
    _controller.clear();
    setState(() {});

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _aiService.getAIResponse(text);

      _addMessage(response, false);
    } catch (e) {
      _addMessage("1d9bf7255dLsIymT2ksa".tr, false);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _addMessage(String content, bool isUser) async {
    final userManager = Provider.of<UserManager>(context, listen: false);
    final userId = userManager.currentUser?.id;

    if (userId == null) {
      final message = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: content,
        senderId: isUser ? 'user' : 'agent',
        timestamp: DateTime.now(),
        isUser: isUser,
      );
      _messages.add(message);
      return;
    }

    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      senderId: isUser ? 'user' : 'agent',
      timestamp: DateTime.now(),
      isUser: isUser,
    );

    _messages.add(message);

    await _chatStorage.addMessage(message, userId);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _startRecording() async {
    final tempDir = await getTemporaryDirectory();
    _recordFilePath = '${tempDir.path}/chat_voice.wav';
    if (!_recorderOpened) {
      await _recorder.openRecorder();
      _recorderOpened = true;
    }
    await _recorder.startRecorder(
      toFile: _recordFilePath,
      codec: Codec.pcm16WAV,
    );
  }

  void _onVoiceTapDown() async {
    if (_isListening) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("df13f4955cPxtxD4aLir".tr),
          duration: Duration(milliseconds: 500),
        ),
      );
      return;
    }
    setState(() {
      _isListening = true;
      _showVoiceTip = true;
    });
    await _startRecording();
  }

  Future<String> _stopRecordingAndGetBase64() async {
    await _recorder.stopRecorder();
    if (_recorderOpened) {
      await _recorder.closeRecorder();
      _recorderOpened = false;
    }
    if (_recordFilePath == null) return "";
    final file = File(_recordFilePath!);
    if (!await file.exists()) return "";
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }

  void _onVoiceTapUp() async {
    if (!_isListening) return;
    setState(() {
      _showVoiceTip = false;
    });
    String base64Audio = await _stopRecordingAndGetBase64();
    if (base64Audio.isNotEmpty) {
      final result = await _speechService.speechToText(base64Audio);
      if (result.isNotEmpty) {
        _controller.text = result;
        _sendMessage();
      }
      setState(() {
        _isListening = false;
      });
    } else {
      setState(() {
        _isListening = false;
      });
    }
  }

  void _onVoiceTapCancel() {
    setState(() {
      _isListening = false;
      _showVoiceTip = false;
    });
  }

  void _handleMenuAction(String action) async {
    switch (action) {
      case 'clear':
        await _clearChatHistory();
        break;
      case 'backup':
        await _backupChatHistory();
        break;
      case 'restore':
        await _showRestoreDialog();
        break;
      case 'stats':
        await _showChatStatistics();
        break;
      case 'db_info':
        await _showDatabaseInfo();
        break;
    }
  }

  Future<void> _clearChatHistory() async {
    final userManager = Provider.of<UserManager>(context, listen: false);
    final userId = userManager.currentUser?.id;

    if (userId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('请先登录')));
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("3c7a4fb356Qp2RYfLXMm".tr),
        content: Text("68a9d35e6bg83U4vMase".tr),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text("2cd0f3be870kKLiIxylt".tr),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text("fac2a67ad8WJQtUNxgM9".tr),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final success = await _chatStorage.clearChatHistory(userId);
      if (success && mounted) {
        setState(() {
          _messages.clear();
        });
        _addWelcomeMessage();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("c39258448dv2CnpkyyRJ".tr)));
      }
    }
  }

  Future<void> _backupChatHistory() async {
    final userManager = Provider.of<UserManager>(context, listen: false);
    final userId = userManager.currentUser?.id;

    if (userId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("48144f96c1DVKKtXBKKK".tr)));
      return;
    }

    final success = await _chatStorage.backupChatHistory(userId);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success ? "8adf103c62huIuH4iw6l".tr : "f3b4148926Goi3zmNbro".tr,
          ),
        ),
      );
    }
  }

  Future<void> _showRestoreDialog() async {
    final userManager = Provider.of<UserManager>(context, listen: false);
    final userId = userManager.currentUser?.id;

    if (userId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("48144f96c1nDjEmgTkYV".tr)));
      return;
    }

    final backups = await _chatStorage.getBackups(userId);

    if (!mounted) return;

    if (backups.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("df853289ed1NLwLKMoqd".tr)));
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("cf6b808d14aXjx0DrJPE".tr),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: backups.length,
            itemBuilder: (context, index) {
              final backup = backups[index];
              final fileName = backup['filename'] as String;
              final createdAt = DateTime.parse(backup['created_at'] as String);
              return ListTile(
                title: Text(fileName),
                subtitle: Text(
                  "dbe8eb6996F4rYimjH5c".tr +
                      '${createdAt.toString().substring(0, 19)}',
                ),
                onTap: () async {
                  Navigator.of(context).pop();
                  await _restoreChatHistory(backup['id'] as String);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
        ],
      ),
    );
  }

  Future<void> _restoreChatHistory(String backupId) async {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("981afc94eb8dpoEMTGGX".tr)));
  }

  Future<void> _showChatStatistics() async {
    final userManager = Provider.of<UserManager>(context, listen: false);
    final userId = userManager.currentUser?.id;

    if (userId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("48144f96c1qa6BYeUFrW".tr)));
      return;
    }

    final stats = await _chatStorage.getChatStatistics(userId);

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("44522499f41fezqxBJgE".tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("cc5fba7a43hKDsFu1xFc".tr + '${stats['totalMessages'] ?? 0}'),
            Text("068e6a973evejcarede0".tr + '${stats['userMessages'] ?? 0}'),
            Text("5f12315404wgYjBmu17g".tr + '${stats['agentMessages'] ?? 0}'),
            if (stats['databaseSize'] != null)
              Text(
                "efaab2c869DH0Gh9zFDp".tr +
                    '${(stats['databaseSize'] / 1024).toStringAsFixed(2)} KB',
              ),
            if (stats['databasePath'] != null)
              Text("607cc93f14TFgqWQzrIY".tr + '${stats['databasePath']}'),
            if (stats['firstMessageTime'] != null)
              Text(
                "ebfa2f2fffvc888Awwvi".tr +
                    '${DateTime.parse(stats['firstMessageTime']).toString().substring(0, 19)}',
              ),
            if (stats['lastMessageTime'] != null)
              Text(
                "ef11648e68zHce4ily0m".tr +
                    '${DateTime.parse(stats['lastMessageTime']).toString().substring(0, 19)}',
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("fac2a67ad81oVHSO5ZWY".tr),
          ),
        ],
      ),
    );
  }

  Future<void> _showDatabaseInfo() async {
    final dbInfo = await DatabaseManager.getDatabaseInfo();
    final dbReport = await DatabaseManager.exportDatabaseInfo();

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("c5fe355a56eTMKbNAET1".tr),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "ea14ad7f78hbynnIQPG1".tr +
                    '${dbInfo['databaseDirectory'] ?? '未知'}',
              ),
              Text(
                "3f680f7c46bjvQnIvSrX".tr +
                    '${dbInfo['backupDirectory'] ?? '未知'}',
              ),
              Text(
                "91ae14e4486QjNpnguW2".tr +
                    '${dbInfo['databaseFileCount'] ?? 0}',
              ),
              Text(
                "be53206859EYFh9UUgpr".tr + '${dbInfo['backupFileCount'] ?? 0}',
              ),
              Text(
                "0b0a4c2387ux2thlj6sr".tr +
                    '${dbInfo['totalSizeKB'] ?? '0'} KB',
              ),
              const SizedBox(height: 16),
              Text(
                "45e1df52d2kcbTXVAg1B".tr,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  dbReport,
                  style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("fac2a67ad8lzM5JIzJsd".tr),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.support_agent, color: Colors.white, size: 24),
            const SizedBox(width: 8),
            Text(
              "6c0c9ceb4dHU8BOkzS6a".tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue[400],
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: _handleMenuAction,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'clear',
                child: Row(
                  children: [
                    Icon(Icons.delete_sweep),
                    SizedBox(width: 8),
                    Text("4ab794bf9fZoLEUGpr5T".tr),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'backup',
                child: Row(
                  children: [
                    Icon(Icons.backup),
                    SizedBox(width: 8),
                    Text("163562df4esUfxg8QgSQ".tr),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'stats',
                child: Row(
                  children: [
                    Icon(Icons.analytics),
                    SizedBox(width: 8),
                    Text("44522499f4yfZ6okd7bR".tr),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'db_info',
                child: Row(
                  children: [
                    Icon(Icons.storage),
                    SizedBox(width: 8),
                    Text("c5fe355a56fGX8qfTTtA".tr),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: GradientBackgroundContainer(
        colors: [Colors.purple[200]!, Colors.blue[200]!, Colors.purple[200]!],
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final msg = _messages[_messages.length - 1 - index];
                      return AgentMessageBubble(message: msg);
                    },
                  ),
                ),
                if (_isLoading)
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "560984bf03Oxm89rKb21".tr,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                AgentInputField(
                  controller: _controller,
                  onSend: _sendMessage,
                  onVoiceTapDown: _onVoiceTapDown,
                  onVoiceTapUp: _onVoiceTapUp,
                  onVoiceTapCancel: _onVoiceTapCancel,
                  isListening: _isListening,
                  isLoading: _isLoading,
                ),
              ],
            ),
            if (_showVoiceTip)
              Positioned.fill(
                child: Container(
                  color: Colors.black54,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.mic, color: Colors.white, size: 48),
                        SizedBox(height: 16),
                        Text(
                          "7ae1f7906bmxLnOyEBPM".tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "a7bf9dba1910kLnAts17".tr,
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
