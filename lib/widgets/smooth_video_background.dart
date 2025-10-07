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

class SmoothVideoBackground extends StatefulWidget {
  final String videoPath;
  final Widget child;
  final Color overlayColor;
  final bool showOverlay;
  final BoxFit fit;
  final bool autoPlay;
  final bool looping;
  final double volume;
  final Widget? fallbackWidget;
  final Duration fadeInDuration;
  final Duration checkTimeout;

  const SmoothVideoBackground({
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
    this.fadeInDuration = const Duration(milliseconds: 500),
    this.checkTimeout = const Duration(seconds: 3),
  });

  @override
  State<SmoothVideoBackground> createState() => _SmoothVideoBackgroundState();
}

class _SmoothVideoBackgroundState extends State<SmoothVideoBackground>
    with TickerProviderStateMixin {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _hasError = false;
  bool _isVideoAvailable = false;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: widget.fadeInDuration,
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      if (!Platform.isIOS && !Platform.isAndroid) {
        _setErrorState();
        return;
      }

      _controller = VideoPlayerController.asset(widget.videoPath);

      await _controller!.initialize().timeout(
        widget.checkTimeout,
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

      if (mounted) {
        setState(() {
          _isVideoAvailable = true;
          _isInitialized = true;
        });

        _fadeController.forward();

        if (widget.autoPlay) {
          await _controller!.play();
        }
      }
    } on PlatformException catch (e) {
      debugPrint('平台异常: ${e.code} - ${e.message}');
      _setErrorState();
    } catch (e) {
      debugPrint('视频初始化失败: $e');
      _setErrorState();
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
    _fadeController.dispose();
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
        if (!_isInitialized)
          Container(color: Colors.transparent)
        else if (_isVideoAvailable && _controller?.value.isInitialized == true)
          FadeTransition(
            opacity: _fadeAnimation,
            child: SizedBox.expand(
              child: FittedBox(
                fit: widget.fit,
                child: SizedBox(
                  width: _controller!.value.size.width,
                  height: _controller!.value.size.height,
                  child: VideoPlayer(_controller!),
                ),
              ),
            ),
          )
        else
          _buildFallbackBackground(),

        if (widget.showOverlay && _isInitialized)
          Container(color: widget.overlayColor),

        widget.child,
      ],
    );
  }
}
