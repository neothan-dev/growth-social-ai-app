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
import '../theme/app_theme.dart';


class FigmaCard extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final double borderRadius;
  final EdgeInsets padding;
  final List<BoxShadow>? boxShadow;
  final VoidCallback? onTap;

  const FigmaCard({
    Key? key,
    required this.child,
    this.backgroundColor = Colors.white,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.all(16.0),
    this.boxShadow,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: boxShadow ?? AppTheme.shadowMd,
      ),
      padding: padding,
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: card);
    }

    return card;
  }
}

class FigmaButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;
  final double height;
  final double borderRadius;
  final EdgeInsets padding;

  const FigmaButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.height = 48.0,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 24.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: _getButtonStyle(),
        child: Padding(
          padding: padding,
          child: Text(text, style: _getTextStyle()),
        ),
      ),
    );
  }

  ButtonStyle _getButtonStyle() {
    switch (type) {
      case ButtonType.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        );
      case ButtonType.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: AppTheme.secondary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        );
      case ButtonType.outline:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: AppTheme.primary),
          ),
          elevation: 0,
        );
    }
  }

  TextStyle _getTextStyle() {
    return AppTheme.buttonMedium.copyWith(fontWeight: FontWeight.w600);
  }
}

enum ButtonType { primary, secondary, outline }

class FigmaInput extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const FigmaInput({
    Key? key,
    this.hintText,
    this.labelText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppTheme.surface,
        border: OutlineInputBorder(
          borderRadius: AppTheme.borderRadiusMd,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppTheme.borderRadiusMd,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppTheme.borderRadiusMd,
          borderSide: BorderSide(color: AppTheme.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppTheme.borderRadiusMd,
          borderSide: BorderSide(color: AppTheme.error),
        ),
        contentPadding: AppTheme.paddingMd,
        hintStyle: AppTheme.bodyMedium.copyWith(color: AppTheme.textDisabled),
      ),
    );
  }
}

class FigmaAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double size;
  final Color backgroundColor;

  const FigmaAvatar({
    Key? key,
    this.imageUrl,
    this.name,
    this.size = 40.0,
    this.backgroundColor = AppTheme.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        image: imageUrl != null
            ? DecorationImage(image: NetworkImage(imageUrl!), fit: BoxFit.cover)
            : null,
      ),
      child: imageUrl == null
          ? Center(
              child: Text(
                _getInitials(),
                style: AppTheme.bodyMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
    );
  }

  String _getInitials() {
    if (name == null || name!.isEmpty) return '?';
    final parts = name!.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name![0].toUpperCase();
  }
}

class FigmaTag extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final EdgeInsets padding;

  const FigmaTag({
    Key? key,
    required this.text,
    this.backgroundColor = AppTheme.primary,
    this.textColor = Colors.white,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Text(
        text,
        style: AppTheme.caption.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class FigmaProgressBar extends StatelessWidget {
  final double progress;
  final double height;
  final Color backgroundColor;
  final Color progressColor;
  final double borderRadius;

  const FigmaProgressBar({
    Key? key,
    required this.progress,
    this.height = 8.0,
    this.backgroundColor = AppTheme.surface,
    this.progressColor = AppTheme.primary,
    this.borderRadius = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: progressColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}

class FigmaIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double size;
  final Color backgroundColor;
  final Color iconColor;
  final double borderRadius;

  const FigmaIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.size = 48.0,
    this.backgroundColor = Colors.transparent,
    this.iconColor = AppTheme.textPrimary,
    this.borderRadius = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Icon(icon, color: iconColor, size: size * 0.5),
        ),
      ),
    );
  }
}

class FigmaDivider extends StatelessWidget {
  final double height;
  final Color color;
  final EdgeInsets margin;

  const FigmaDivider({
    Key? key,
    this.height = 1.0,
    this.color = AppTheme.divider,
    this.margin = const EdgeInsets.symmetric(vertical: 16.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: height, margin: margin, color: color);
  }
}

class FigmaSpacing extends StatelessWidget {
  final double size;
  final bool isHorizontal;

  const FigmaSpacing({Key? key, this.size = 16.0, this.isHorizontal = false})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isHorizontal ? SizedBox(width: size) : SizedBox(height: size);
  }
}

class FigmaSpacingXs extends StatelessWidget {
  final bool isHorizontal;
  const FigmaSpacingXs({Key? key, this.isHorizontal = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FigmaSpacing(size: 4.0, isHorizontal: isHorizontal);
  }
}

class FigmaSpacingSm extends StatelessWidget {
  final bool isHorizontal;
  const FigmaSpacingSm({Key? key, this.isHorizontal = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FigmaSpacing(size: 8.0, isHorizontal: isHorizontal);
  }
}

class FigmaSpacingMd extends StatelessWidget {
  final bool isHorizontal;
  const FigmaSpacingMd({Key? key, this.isHorizontal = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FigmaSpacing(size: 16.0, isHorizontal: isHorizontal);
  }
}

class FigmaSpacingLg extends StatelessWidget {
  final bool isHorizontal;
  const FigmaSpacingLg({Key? key, this.isHorizontal = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FigmaSpacing(size: 24.0, isHorizontal: isHorizontal);
  }
}

class FigmaSpacingXl extends StatelessWidget {
  final bool isHorizontal;
  const FigmaSpacingXl({Key? key, this.isHorizontal = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FigmaSpacing(size: 32.0, isHorizontal: isHorizontal);
  }
}
