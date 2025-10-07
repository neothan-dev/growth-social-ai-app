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

class CustomIconButton extends StatelessWidget {
  final String iconName;
  final VoidCallback? onPressed;
  final double size;
  final Color? backgroundColor;
  final Color? iconColor;
  final EdgeInsetsGeometry? padding;
  final String? tooltip;

  const CustomIconButton({
    super.key,
    required this.iconName,
    this.onPressed,
    this.size = 48,
    this.backgroundColor,
    this.iconColor,
    this.padding,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.blue,
        borderRadius: BorderRadius.circular(size / 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(size / 2),
          onTap: onPressed,
          child: Padding(
            padding: padding ?? EdgeInsets.all(size * 0.2),
            child: Image.asset(
              AssetManager.getIconPath(iconName),
              color: iconColor ?? Colors.white,
              width: size * 0.6,
              height: size * 0.6,
            ),
          ),
        ),
      ),
    );
  }
}
