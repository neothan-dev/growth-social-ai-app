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
import 'package:video_player/video_player.dart';
import 'dart:io' show Platform;

class VideoBackground extends StatefulWidget {
  final String videoPath;
  final Widget child;
  final Color overlayColor;
  final bool showOverlay;
  final BoxFit fit;
  final bool autoPlay;
  final bool looping;
  final double volume;
  final Widget? fallbackWidget;

  const VideoBackground({
    super.key,
    required this.videoPath,
    required this.child,
    this.overlayColor = Colors.black54,
    this.showOverlay = true,
    this.fit = BoxFit.cover,
    this.autoPlay = true,
    this.looping = true,
    this.volume = 0.0,
    this.fallbackWidget,
  });

  @override
  State<VideoBackground> createState() => _VideoBackgroundState();
}

class _VideoBackgroundState extends State<VideoBackground> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      if (!_isPlatformSupported()) {
        debugPrint('当前平台不支持视频播放');
        _setErrorState();
        return;
      }

      _controller = VideoPlayerController.asset(widget.videoPath);

      await _controller!.initialize().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('视频初始化超时');
        },
      );

      if (widget.looping) {
        await _controller!.setLooping(true);
      }

      if (widget.volume != 1.0) {
        await _controller!.setVolume(widget.volume);
      }

      if (widget.autoPlay) {
        await _controller!.play();
      }

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } on PlatformException catch (e) {
      debugPrint('平台异常: ${e.code} - ${e.message}');
      _setErrorState();
    } catch (e) {
      debugPrint('视频初始化失败: $e');
      _setErrorState();
    }
  }

  bool _isPlatformSupported() {
    try {
      if (Platform.isIOS) {
        return true;
      } else if (Platform.isAndroid) {
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('平台检查失败: $e');
      return false;
    }
  }

  void _setErrorState() {
    if (mounted) {
      setState(() {
        _hasError = true;
        _isInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Widget _buildFallbackBackground() {
    if (widget.fallbackWidget != null) {
      return widget.fallbackWidget!;
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1976D2), Color(0xFF0D47A1), Color(0xFF1565C0)],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_isInitialized &&
            !_hasError &&
            _controller?.value.isInitialized == true)
          SizedBox.expand(
            child: FittedBox(
              fit: widget.fit,
              child: SizedBox(
                width: _controller!.value.size.width,
                height: _controller!.value.size.height,
                child: VideoPlayer(_controller!),
              ),
            ),
          )
        else
          _buildFallbackBackground(),

        if (widget.showOverlay) Container(color: widget.overlayColor),

        widget.child,
      ],
    );
  }
}
