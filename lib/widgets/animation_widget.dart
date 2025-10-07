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
import 'package:lottie/lottie.dart';
import '../utils/asset_manager.dart';

class CustomAnimationWidget extends StatelessWidget {
  final String animationName;
  final double? width;
  final double? height;
  final bool repeat;
  final bool animate;
  final VoidCallback? onLoaded;

  const CustomAnimationWidget({
    super.key,
    required this.animationName,
    this.width,
    this.height,
    this.repeat = true,
    this.animate = true,
    this.onLoaded,
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      AssetManager.getAnimationPath(animationName),
      width: width,
      height: height,
      repeat: repeat,
      animate: animate,
      onLoaded: (composition) {
        if (onLoaded != null) {
          onLoaded!();
        }
      },
    );
  }
}

class LoadingAnimation extends StatelessWidget {
  final double size;
  final String? animationName;

  const LoadingAnimation({super.key, this.size = 100, this.animationName});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomAnimationWidget(
        animationName: animationName ?? AppAnimations.loading,
        repeat: true,
        animate: true,
      ),
    );
  }
}

class SuccessAnimation extends StatelessWidget {
  final double size;
  final VoidCallback? onComplete;

  const SuccessAnimation({super.key, this.size = 100, this.onComplete});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomAnimationWidget(
        animationName: AppAnimations.success,
        repeat: false,
        animate: true,
        onLoaded: onComplete,
      ),
    );
  }
}

class ErrorAnimation extends StatelessWidget {
  final double size;
  final VoidCallback? onComplete;

  const ErrorAnimation({super.key, this.size = 100, this.onComplete});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomAnimationWidget(
        animationName: AppAnimations.error,
        repeat: false,
        animate: true,
        onLoaded: onComplete,
      ),
    );
  }
}

class VoiceWaveAnimation extends StatelessWidget {
  final double size;
  final bool isActive;

  const VoiceWaveAnimation({super.key, this.size = 60, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomAnimationWidget(
        animationName: AppAnimations.voiceWave,
        repeat: isActive,
        animate: isActive,
      ),
    );
  }
}
