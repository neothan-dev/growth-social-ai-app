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
import 'static_background.dart';
import 'safe_video_background.dart';

class AdaptiveBackground extends StatefulWidget {
  final String videoPath;
  final Widget child;
  final Color overlayColor;
  final bool showOverlay;
  final BoxFit fit;
  final bool autoPlay;
  final bool looping;
  final double volume;
  final Widget? fallbackWidget;
  final List<Color> staticGradientColors;
  final AlignmentGeometry gradientBegin;
  final AlignmentGeometry gradientEnd;

  const AdaptiveBackground({
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
    this.staticGradientColors = const [
      Color(0xFF1976D2),
      Color(0xFF0D47A1),
      Color(0xFF1565C0),
    ],
    this.gradientBegin = Alignment.topLeft,
    this.gradientEnd = Alignment.bottomRight,
  });

  @override
  State<AdaptiveBackground> createState() => _AdaptiveBackgroundState();
}

class _AdaptiveBackgroundState extends State<AdaptiveBackground> {
  bool _useVideo = false;
  bool _isChecking = true;

  @override
  void initState() {
    super.initState();
    _checkVideoAvailability();
  }

  Future<void> _checkVideoAvailability() async {
    try {
      if (!Platform.isIOS && !Platform.isAndroid) {
        _setStaticBackground();
        return;
      }

      final controller = VideoPlayerController.asset(widget.videoPath);
      await controller.initialize().timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw Exception('视频初始化超时');
        },
      );

      await controller.dispose();

      if (mounted) {
        setState(() {
          _useVideo = true;
          _isChecking = false;
        });
      }
    } catch (e) {
      debugPrint('视频不可用，使用静态背景: $e');
      _setStaticBackground();
    }
  }

  void _setStaticBackground() {
    if (mounted) {
      setState(() {
        _useVideo = false;
        _isChecking = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isChecking) {
      return Stack(
        children: [
          Container(decoration: const BoxDecoration(color: Colors.transparent)),
          widget.child,
        ],
      );
    }

    if (_useVideo) {
      return SafeVideoBackground(
        videoPath: widget.videoPath,
        overlayColor: widget.overlayColor,
        showOverlay: widget.showOverlay,
        fit: widget.fit,
        autoPlay: widget.autoPlay,
        looping: widget.looping,
        volume: widget.volume,
        fallbackWidget: widget.fallbackWidget,
        enableVideo: true,
        child: widget.child,
      );
    } else {
      return StaticBackground(
        overlayColor: widget.overlayColor,
        showOverlay: widget.showOverlay,
        gradientColors: widget.staticGradientColors,
        begin: widget.gradientBegin,
        end: widget.gradientEnd,
        child: widget.child,
      );
    }
  }
}
