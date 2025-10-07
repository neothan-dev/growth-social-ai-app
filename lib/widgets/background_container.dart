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
import '../utils/asset_manager.dart';

class BackgroundContainer extends StatelessWidget {
  final String backgroundName;
  final Widget child;
  final BoxFit fit;
  final Color? overlayColor;
  final double? opacity;

  const BackgroundContainer({
    super.key,
    required this.backgroundName,
    required this.child,
    this.fit = BoxFit.cover,
    this.overlayColor,
    this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetManager.getBackgroundPath(backgroundName)),
          fit: fit,
          opacity: opacity ?? 1.0,
        ),
      ),
      child: overlayColor != null
          ? Container(
              width: double.infinity,
              height: double.infinity,
              color: overlayColor,
              child: child,
            )
          : child,
    );
  }
}

class GradientBackgroundContainer extends StatelessWidget {
  final Widget child;
  final List<Color> colors;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final String? backgroundImage;
  final BoxFit fit;

  const GradientBackgroundContainer({
    super.key,
    required this.child,
    this.colors = const [Colors.blue, Colors.purple],
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
    this.backgroundImage,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors, begin: begin, end: end),
        image: backgroundImage != null
            ? DecorationImage(
                image: AssetImage(
                  AssetManager.getBackgroundPath(backgroundImage!),
                ),
                fit: fit,
                colorFilter: ColorFilter.mode(
                  Colors.black.withValues(alpha: 0.3),
                  BlendMode.darken,
                ),
              )
            : null,
      ),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: child,
      ),
    );
  }
}
