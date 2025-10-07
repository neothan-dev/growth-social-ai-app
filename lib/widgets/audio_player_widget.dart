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
import 'package:just_audio/just_audio.dart';
import '../utils/asset_manager.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audioName;
  final double size;
  final Color? backgroundColor;
  final Color? iconColor;
  final bool autoPlay;
  final VoidCallback? onPlay;
  final VoidCallback? onStop;

  const AudioPlayerWidget({
    super.key,
    required this.audioName,
    this.size = 48,
    this.backgroundColor,
    this.iconColor,
    this.autoPlay = false,
    this.onPlay,
    this.onStop,
  });

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudio();
  }

  Future<void> _initAudio() async {
    try {
      await _audioPlayer.setAsset(AssetManager.getAudioPath(widget.audioName));
      if (widget.autoPlay) {
        _playAudio();
      }
    } catch (e) {
      debugPrint('音频初始化失败: $e');
    }
  }

  Future<void> _playAudio() async {
    try {
      await _audioPlayer.play();
      setState(() {
        _isPlaying = true;
      });
      widget.onPlay?.call();
    } catch (e) {
      debugPrint('播放音频失败: $e');
    }
  }

  Future<void> _stopAudio() async {
    try {
      await _audioPlayer.stop();
      setState(() {
        _isPlaying = false;
      });
      widget.onStop?.call();
    } catch (e) {
      debugPrint('停止音频失败: $e');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isPlaying ? _stopAudio : _playAudio,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Colors.blue,
          borderRadius: BorderRadius.circular(widget.size / 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          _isPlaying ? Icons.stop : Icons.play_arrow,
          color: widget.iconColor ?? Colors.white,
          size: widget.size * 0.4,
        ),
      ),
    );
  }
}

class NotificationSound extends StatelessWidget {
  final VoidCallback? onPlay;

  const NotificationSound({super.key, this.onPlay});

  @override
  Widget build(BuildContext context) {
    return AudioPlayerWidget(
      audioName: AppAudio.notification,
      size: 32,
      backgroundColor: Colors.green,
      onPlay: onPlay,
    );
  }
}

class MessageSentSound extends StatelessWidget {
  final VoidCallback? onPlay;

  const MessageSentSound({super.key, this.onPlay});

  @override
  Widget build(BuildContext context) {
    return AudioPlayerWidget(
      audioName: AppAudio.messageSent,
      size: 32,
      backgroundColor: Colors.blue,
      onPlay: onPlay,
    );
  }
}
