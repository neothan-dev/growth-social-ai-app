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
import '../../theme/app_theme.dart';

class FigmaButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final FigmaButtonType type;
  final FigmaButtonSize size;
  final bool isLoading;
  final IconData? icon;
  final bool fullWidth;

  const FigmaButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = FigmaButtonType.primary,
    this.size = FigmaButtonSize.medium,
    this.isLoading = false,
    this.icon,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonWidget = _buildButtonWidget();

    if (fullWidth) {
      return SizedBox(width: double.infinity, child: buttonWidget);
    }

    return buttonWidget;
  }

  Widget _buildButtonWidget() {
    switch (type) {
      case FigmaButtonType.primary:
        return _buildPrimaryButton();
      case FigmaButtonType.secondary:
        return _buildSecondaryButton();
      case FigmaButtonType.outline:
        return _buildOutlineButton();
      case FigmaButtonType.text:
        return _buildTextButton();
    }
  }

  Widget _buildPrimaryButton() {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        textStyle: _getTextStyle(),
        padding: _getPadding(),
        shape: RoundedRectangleBorder(borderRadius: AppTheme.borderRadiusMd),
        elevation: 0,
      ),
      child: _buildButtonContent(),
    );
  }

  Widget _buildSecondaryButton() {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.secondary,
        foregroundColor: Colors.white,
        textStyle: _getTextStyle(),
        padding: _getPadding(),
        shape: RoundedRectangleBorder(borderRadius: AppTheme.borderRadiusMd),
        elevation: 0,
      ),
      child: _buildButtonContent(),
    );
  }

  Widget _buildOutlineButton() {
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppTheme.primary,
        textStyle: _getTextStyle(),
        padding: _getPadding(),
        shape: RoundedRectangleBorder(borderRadius: AppTheme.borderRadiusMd),
        side: const BorderSide(color: AppTheme.primary),
      ),
      child: _buildButtonContent(),
    );
  }

  Widget _buildTextButton() {
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppTheme.primary,
        textStyle: _getTextStyle(),
        padding: _getPadding(),
      ),
      child: _buildButtonContent(),
    );
  }

  Widget _buildButtonContent() {
    if (isLoading) {
      return SizedBox(
        width: _getLoadingSize(),
        height: _getLoadingSize(),
        child: const CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: _getIconSize()),
          const SizedBox(width: AppTheme.spacingSm),
          Text(text),
        ],
      );
    }

    return Text(text);
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case FigmaButtonSize.small:
        return AppTheme.buttonSmall;
      case FigmaButtonSize.medium:
        return AppTheme.buttonMedium;
      case FigmaButtonSize.large:
        return AppTheme.buttonLarge;
    }
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case FigmaButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingMd,
          vertical: AppTheme.spacingSm,
        );
      case FigmaButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingLg,
          vertical: AppTheme.spacingMd,
        );
      case FigmaButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingXl,
          vertical: AppTheme.spacingLg,
        );
    }
  }

  double _getIconSize() {
    switch (size) {
      case FigmaButtonSize.small:
        return 16;
      case FigmaButtonSize.medium:
        return 18;
      case FigmaButtonSize.large:
        return 20;
    }
  }

  double _getLoadingSize() {
    switch (size) {
      case FigmaButtonSize.small:
        return 16;
      case FigmaButtonSize.medium:
        return 18;
      case FigmaButtonSize.large:
        return 20;
    }
  }
}

enum FigmaButtonType {
  primary,
  secondary,
  outline,
  text,
}

enum FigmaButtonSize {
  small,
  medium,
  large,
}

class FigmaButtons {
  static FigmaButton primary({
    required String text,
    required VoidCallback? onPressed,
    FigmaButtonSize size = FigmaButtonSize.medium,
    bool isLoading = false,
    IconData? icon,
    bool fullWidth = false,
  }) {
    return FigmaButton(
      text: text,
      onPressed: onPressed,
      type: FigmaButtonType.primary,
      size: size,
      isLoading: isLoading,
      icon: icon,
      fullWidth: fullWidth,
    );
  }

  static FigmaButton secondary({
    required String text,
    required VoidCallback? onPressed,
    FigmaButtonSize size = FigmaButtonSize.medium,
    bool isLoading = false,
    IconData? icon,
    bool fullWidth = false,
  }) {
    return FigmaButton(
      text: text,
      onPressed: onPressed,
      type: FigmaButtonType.secondary,
      size: size,
      isLoading: isLoading,
      icon: icon,
      fullWidth: fullWidth,
    );
  }

  static FigmaButton outline({
    required String text,
    required VoidCallback? onPressed,
    FigmaButtonSize size = FigmaButtonSize.medium,
    bool isLoading = false,
    IconData? icon,
    bool fullWidth = false,
  }) {
    return FigmaButton(
      text: text,
      onPressed: onPressed,
      type: FigmaButtonType.outline,
      size: size,
      isLoading: isLoading,
      icon: icon,
      fullWidth: fullWidth,
    );
  }

  static FigmaButton text({
    required String text,
    required VoidCallback? onPressed,
    FigmaButtonSize size = FigmaButtonSize.medium,
    bool isLoading = false,
    IconData? icon,
    bool fullWidth = false,
  }) {
    return FigmaButton(
      text: text,
      onPressed: onPressed,
      type: FigmaButtonType.text,
      size: size,
      isLoading: isLoading,
      icon: icon,
      fullWidth: fullWidth,
    );
  }
}
