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

class StaticBackground extends StatelessWidget {
  final Widget child;
  final Color overlayColor;
  final bool showOverlay;
  final List<Color> gradientColors;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;

  const StaticBackground({
    super.key,
    required this.child,
    this.overlayColor = Colors.black54,
    this.showOverlay = true,
    this.gradientColors = const [
      Color(0xFF1976D2),
      Color(0xFF0D47A1),
      Color(0xFF1565C0),
    ],
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: begin,
              end: end,
              colors: gradientColors,
            ),
          ),
        ),

        if (showOverlay) Container(color: overlayColor),

        child,
      ],
    );
  }
}
