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
import 'dart:ui';
import '../utils/asset_manager.dart';

class BlurBackgroundContainer extends StatelessWidget {
  final String backgroundName;
  final Widget child;
  final BoxFit fit;
  final Color? overlayColor;
  final double? opacity;
  final double blurRadius;
  final double blurSigma;
  final bool enableBlur;

  const BlurBackgroundContainer({
    super.key,
    required this.backgroundName,
    required this.child,
    this.fit = BoxFit.cover,
    this.overlayColor,
    this.opacity,
    this.blurRadius = 20.0,
    this.blurSigma = 10.0,
    this.enableBlur = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetManager.getBackgroundPath(backgroundName)),
              fit: fit,
              opacity: opacity ?? 1.0,
            ),
          ),
        ),

        if (enableBlur)
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ),
          ),

        if (overlayColor != null)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: overlayColor,
          ),

        child,
      ],
    );
  }
}

class AdvancedBlurBackgroundContainer extends StatelessWidget {
  final String backgroundName;
  final Widget child;
  final BoxFit fit;
  final Color? overlayColor;
  final double? opacity;
  final BlurStyle blurStyle;
  final double blurRadius;
  final double blurSigma;
  final bool enableBlur;
  final Color blurTintColor;
  final double blurTintOpacity;

  const AdvancedBlurBackgroundContainer({
    super.key,
    required this.backgroundName,
    required this.child,
    this.fit = BoxFit.cover,
    this.overlayColor,
    this.opacity,
    this.blurStyle = BlurStyle.normal,
    this.blurRadius = 20.0,
    this.blurSigma = 10.0,
    this.enableBlur = true,
    this.blurTintColor = Colors.white,
    this.blurTintOpacity = 0.1,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetManager.getBackgroundPath(backgroundName)),
              fit: fit,
              opacity: opacity ?? 1.0,
            ),
          ),
        ),

        if (enableBlur)
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: blurSigma,
                sigmaY: blurSigma,
                tileMode: TileMode.clamp,
              ),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: blurTintColor.withValues(alpha: blurTintOpacity),
                ),
              ),
            ),
          ),

        if (overlayColor != null)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: overlayColor,
          ),

        child,
      ],
    );
  }
}

class GlassmorphismBackgroundContainer extends StatelessWidget {
  final String backgroundName;
  final Widget child;
  final BoxFit fit;
  final Color? overlayColor;
  final double? opacity;
  final double blurRadius;
  final double blurSigma;
  final Color glassColor;
  final double glassOpacity;
  final BorderRadius? borderRadius;

  const GlassmorphismBackgroundContainer({
    super.key,
    required this.backgroundName,
    required this.child,
    this.fit = BoxFit.cover,
    this.overlayColor,
    this.opacity,
    this.blurRadius = 20.0,
    this.blurSigma = 15.0,
    this.glassColor = Colors.white,
    this.glassOpacity = 0.2,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 背景图片层 - 确保完全覆盖屏幕
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AssetManager.getBackgroundPath(backgroundName),
                ),
                fit: BoxFit.cover,
                alignment: Alignment.center,
                opacity: opacity ?? 1.0,
              ),
            ),
          ),
        ),

        // 毛玻璃效果层 - 移除边框，避免边缘白线
        Positioned.fill(
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: blurSigma,
                sigmaY: blurSigma,
                tileMode: TileMode.clamp,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: glassColor.withValues(alpha: glassOpacity),
                  borderRadius: borderRadius,
                  // 移除白色边框，避免边缘白线
                ),
              ),
            ),
          ),
        ),

        // 遮罩层 - 使用扩展覆盖
        if (overlayColor != null)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: overlayColor,
          ),

        child,
      ],
    );
  }
}

enum BlurStyle { light, normal, heavy, ultra }

class BlurConfig {
  static const Map<BlurStyle, double> blurSigmaValues = {
    BlurStyle.light: 5.0,
    BlurStyle.normal: 10.0,
    BlurStyle.heavy: 15.0,
    BlurStyle.ultra: 25.0,
  };

  static const Map<BlurStyle, double> blurRadiusValues = {
    BlurStyle.light: 10.0,
    BlurStyle.normal: 20.0,
    BlurStyle.heavy: 30.0,
    BlurStyle.ultra: 50.0,
  };

  static double getSigma(BlurStyle style) => blurSigmaValues[style] ?? 10.0;
  static double getRadius(BlurStyle style) => blurRadiusValues[style] ?? 20.0;
}

/// 优化的毛玻璃效果背景容器 - 专门解决边缘白线问题
class OptimizedGlassmorphismContainer extends StatelessWidget {
  final String backgroundName;
  final Widget child;
  final BoxFit fit;
  final Color? overlayColor;
  final double? opacity;
  final double blurSigma;
  final Color glassColor;
  final double glassOpacity;
  final BorderRadius? borderRadius;
  final bool extendEdges; // 是否扩展边缘覆盖

  const OptimizedGlassmorphismContainer({
    super.key,
    required this.backgroundName,
    required this.child,
    this.fit = BoxFit.cover,
    this.overlayColor,
    this.opacity,
    this.blurSigma = 15.0,
    this.glassColor = Colors.white,
    this.glassOpacity = 0.2,
    this.borderRadius,
    this.extendEdges = true, // 默认启用边缘扩展
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 背景图片层 - 使用扩展覆盖，确保完全覆盖屏幕边缘
        Positioned.fill(
          child: Transform.scale(
            scale: extendEdges ? 1.1 : 1.0, // 稍微放大背景以覆盖边缘
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AssetManager.getBackgroundPath(backgroundName),
                  ),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  opacity: opacity ?? 1.0,
                ),
              ),
            ),
          ),
        ),

        // 毛玻璃效果层 - 移除边框，使用更大的模糊范围
        Positioned.fill(
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: blurSigma,
                sigmaY: blurSigma,
                tileMode: TileMode.clamp,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: glassColor.withValues(alpha: glassOpacity),
                  borderRadius: borderRadius,
                  // 完全移除边框，避免边缘白线
                ),
              ),
            ),
          ),
        ),

        // 遮罩层 - 使用扩展覆盖
        if (overlayColor != null)
          Positioned.fill(child: Container(color: overlayColor)),

        // 内容层
        child,
      ],
    );
  }
}
