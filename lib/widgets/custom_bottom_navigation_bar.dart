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
import 'dart:ui';
import '../utils/asset_manager.dart';
import '../utils/haptic_feedback_helper.dart';
import '../theme/page_theme_manager.dart';
import '../localization/app_localizations.dart';

class GlassmorphismBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final double iconSize;
  final double selectedIconSize;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? backgroundColor;
  final double blurRadius;
  final double opacity;
  final bool useDynamicTheme;

  const GlassmorphismBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.iconSize = 24.0,
    this.selectedIconSize = 28.0,
    this.selectedColor,
    this.unselectedColor,
    this.backgroundColor,
    this.blurRadius = 20.0,
    this.opacity = 0.8,
    this.useDynamicTheme = true,
  });

  @override
  Widget build(BuildContext context) {
    final pageTheme = useDynamicTheme
        ? PageThemeManager.getPageThemeByIndex(currentIndex)
        : null;

    final navBarColor =
        backgroundColor ??
        pageTheme?.backgroundColor ??
        pageTheme?.navigationBarColor ??
        Colors.white;
    final selectedNavColor =
        selectedColor ?? pageTheme?.navigationBarSelectedColor ?? Colors.blue;
    final unselectedNavColor =
        unselectedColor ??
        pageTheme?.navigationBarUnselectedColor ??
        Colors.grey;

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 80 + MediaQuery.of(context).padding.bottom,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      navBarColor.withValues(alpha: 0.0),
                      navBarColor.withValues(alpha: 0.3),
                      navBarColor.withValues(alpha: 0.6),
                      navBarColor.withValues(alpha: 0.8),
                    ],
                    stops: const [0.0, 0.3, 0.7, 1.0],
                  ),
                ),
              ),
            ),
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: blurRadius,
                  sigmaY: blurRadius,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: navBarColor.withValues(alpha: opacity),
                    border: Border(
                      top: BorderSide(
                        color: Colors.white.withValues(alpha: 0.2),
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildNavItem(
                            0,
                            AppIcons.dashboard,
                            AppIcons.dashboardActive,
                            "0072da457asan3mKvj72".tr,
                            selectedNavColor,
                            unselectedNavColor,
                          ),
                          _buildNavItem(
                            1,
                            AppIcons.society,
                            AppIcons.societyActive,
                            "5bcd0ddcddsMtm5HlYku".tr,
                            selectedNavColor,
                            unselectedNavColor,
                          ),
                          _buildNavItem(
                            2,
                            AppIcons.improvement,
                            AppIcons.improvementActive,
                            "3cd4b73afaNaFepVW0YM".tr,
                            selectedNavColor,
                            unselectedNavColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    String normalIcon,
    String activeIcon,
    String label,
    Color selectedColor,
    Color unselectedColor,
  ) {
    final isSelected = currentIndex == index;
    final iconPath = isSelected ? activeIcon : normalIcon;
    final color = isSelected ? selectedColor : unselectedColor;
    final size = isSelected ? selectedIconSize : iconSize;

    return GestureDetector(
      onTap: () {
        // 为导航切换提供专门的震动反馈
        HapticFeedbackHelper.navigationTap();
        onTap(index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? selectedColor.withValues(alpha: 0.15)
              : Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AssetManager.getIconPath(iconPath),
              width: size,
              height: size,
              color: color,
              errorBuilder: (context, error, stackTrace) {
                return Icon(_getDefaultIcon(index), size: size, color: color);
              },
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getDefaultIcon(int index) {
    switch (index) {
      case 0:
        return Icons.dashboard;
      case 1:
        return Icons.groups;
      case 2:
        return Icons.trending_up;
      default:
        return Icons.circle;
    }
  }
}

class AnimatedGlassmorphismBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;
  final double iconSize;
  final double selectedIconSize;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? backgroundColor;
  final Duration animationDuration;
  final double blurRadius;
  final double opacity;
  final bool useDynamicTheme;

  const AnimatedGlassmorphismBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.iconSize = 19.0,
    this.selectedIconSize = 22.0,
    this.selectedColor,
    this.unselectedColor,
    this.backgroundColor,
    this.animationDuration = const Duration(milliseconds: 300),
    this.blurRadius = 20.0,
    this.opacity = 0.8,
    this.useDynamicTheme = true,
  });

  @override
  State<AnimatedGlassmorphismBottomNavigationBar> createState() =>
      _AnimatedGlassmorphismBottomNavigationBarState();
}

class _AnimatedGlassmorphismBottomNavigationBarState
    extends State<AnimatedGlassmorphismBottomNavigationBar>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      3,
      (index) =>
          AnimationController(duration: widget.animationDuration, vsync: this),
    );
    _animations = _controllers
        .map(
          (controller) => Tween<double>(begin: 1.0, end: 1.2).animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInOut),
          ),
        )
        .toList();

    _updateAnimations();
  }

  @override
  void didUpdateWidget(AnimatedGlassmorphismBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _updateAnimations();
    }
  }

  void _updateAnimations() {
    for (int i = 0; i < _controllers.length; i++) {
      if (i == widget.currentIndex) {
        _controllers[i].forward();
      } else {
        _controllers[i].reverse();
      }
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageTheme = widget.useDynamicTheme
        ? PageThemeManager.getPageThemeByIndex(widget.currentIndex)
        : null;

    final navBarColor =
        widget.backgroundColor ??
        pageTheme?.backgroundColor ??
        pageTheme?.navigationBarColor ??
        Colors.white;
    final selectedNavColor =
        widget.selectedColor ??
        pageTheme?.navigationBarSelectedColor ??
        Colors.blue;
    final unselectedNavColor =
        widget.unselectedColor ??
        pageTheme?.navigationBarUnselectedColor ??
        Colors.grey;

    return Container(
      // height: 63 + MediaQuery.of(context).padding.bottom,
      height: 93,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            navBarColor.withValues(alpha: 0.0),
            navBarColor.withValues(alpha: 0.3),
            navBarColor.withValues(alpha: 0.5),
            navBarColor.withValues(alpha: 0.6),
          ],
          stops: const [0.0, 0.3, 0.7, 1.0],
        ),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: widget.blurRadius,
            sigmaY: widget.blurRadius,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: navBarColor.withValues(alpha: widget.opacity),
              border: Border(
                top: BorderSide(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 0.5,
                ),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 0.0,
                  vertical: 0.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildAnimatedNavItem(
                      0,
                      AppIcons.dashboard,
                      AppIcons.dashboardActive,
                      "0072da457aFMuBAX8Kzj".tr,
                      selectedNavColor,
                      unselectedNavColor,
                    ),
                    _buildAnimatedNavItem(
                      1,
                      AppIcons.society,
                      AppIcons.societyActive,
                      "5bcd0ddcddRXZO3yqKDf".tr,
                      selectedNavColor,
                      unselectedNavColor,
                    ),
                    _buildAnimatedNavItem(
                      2,
                      AppIcons.improvement,
                      AppIcons.improvementActive,
                      "3cd4b73afaDCnDEtnCiS".tr,
                      selectedNavColor,
                      unselectedNavColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedNavItem(
    int index,
    String normalIcon,
    String activeIcon,
    String label,
    Color selectedColor,
    Color unselectedColor,
  ) {
    final isSelected = widget.currentIndex == index;
    final iconPath = isSelected ? activeIcon : normalIcon;
    final color = isSelected ? selectedColor : unselectedColor;
    final baseSize = isSelected ? widget.selectedIconSize : widget.iconSize;

    return GestureDetector(
      onTap: () {
        // 为导航切换提供专门的震动反馈
        HapticFeedbackHelper.navigationTap();
        widget.onTap(index);
      },
      child: AnimatedBuilder(
        animation: _animations[index],
        builder: (context, child) {
          final scale = _animations[index].value;
          final size = baseSize * scale;

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isSelected
                  ? selectedColor.withValues(alpha: 0.15)
                  : Colors.transparent,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AssetManager.getIconPath(iconPath),
                  width: size,
                  height: size,
                  color: color,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      _getDefaultIcon(index),
                      size: size,
                      color: color,
                    );
                  },
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 8 * scale,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  IconData _getDefaultIcon(int index) {
    switch (index) {
      case 0:
        return Icons.dashboard;
      case 1:
        return Icons.groups;
      case 2:
        return Icons.trending_up;
      default:
        return Icons.circle;
    }
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final double iconSize;
  final double selectedIconSize;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? backgroundColor;
  final double elevation;
  final bool useDynamicTheme;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.iconSize = 24.0,
    this.selectedIconSize = 28.0,
    this.selectedColor,
    this.unselectedColor,
    this.backgroundColor,
    this.elevation = 8.0,
    this.useDynamicTheme = true,
  });

  @override
  Widget build(BuildContext context) {
    final pageTheme = useDynamicTheme
        ? PageThemeManager.getPageThemeByIndex(currentIndex)
        : null;

    final navBarColor =
        backgroundColor ??
        pageTheme?.backgroundColor ??
        pageTheme?.navigationBarColor ??
        Colors.white;
    final selectedNavColor =
        selectedColor ?? pageTheme?.navigationBarSelectedColor ?? Colors.blue;
    final unselectedNavColor =
        unselectedColor ??
        pageTheme?.navigationBarUnselectedColor ??
        Colors.grey;

    return Container(
      decoration: BoxDecoration(
        color: navBarColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: elevation,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                0,
                AppIcons.dashboard,
                AppIcons.dashboardActive,
                "0072da457atNVj4SDYmf".tr,
                selectedNavColor,
                unselectedNavColor,
              ),
              _buildNavItem(
                1,
                AppIcons.society,
                AppIcons.societyActive,
                "5bcd0ddcddHmYGM3YVrX".tr,
                selectedNavColor,
                unselectedNavColor,
              ),
              _buildNavItem(
                2,
                AppIcons.improvement,
                AppIcons.improvementActive,
                "3cd4b73afaB0Zy5CzpZD".tr,
                selectedNavColor,
                unselectedNavColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    String normalIcon,
    String activeIcon,
    String label,
    Color selectedColor,
    Color unselectedColor,
  ) {
    final isSelected = currentIndex == index;
    final iconPath = isSelected ? activeIcon : normalIcon;
    final color = isSelected ? selectedColor : unselectedColor;
    final size = isSelected ? selectedIconSize : iconSize;

    return GestureDetector(
      onTap: () {
        // 为导航切换提供专门的震动反馈
        HapticFeedbackHelper.navigationTap();
        onTap(index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? selectedColor.withValues(alpha: 0.1)
              : Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AssetManager.getIconPath(iconPath),
              width: size,
              height: size,
              color: color,
              errorBuilder: (context, error, stackTrace) {
                return Icon(_getDefaultIcon(index), size: size, color: color);
              },
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getDefaultIcon(int index) {
    switch (index) {
      case 0:
        return Icons.dashboard;
      case 1:
        return Icons.groups;
      case 2:
        return Icons.trending_up;
      default:
        return Icons.circle;
    }
  }
}

class AnimatedCustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;
  final double iconSize;
  final double selectedIconSize;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? backgroundColor;
  final Duration animationDuration;
  final bool useDynamicTheme;

  const AnimatedCustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.iconSize = 24.0,
    this.selectedIconSize = 28.0,
    this.selectedColor,
    this.unselectedColor,
    this.backgroundColor,
    this.animationDuration = const Duration(milliseconds: 300),
    this.useDynamicTheme = true,
  });

  @override
  State<AnimatedCustomBottomNavigationBar> createState() =>
      _AnimatedCustomBottomNavigationBarState();
}

class _AnimatedCustomBottomNavigationBarState
    extends State<AnimatedCustomBottomNavigationBar>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      3,
      (index) =>
          AnimationController(duration: widget.animationDuration, vsync: this),
    );
    _animations = _controllers
        .map(
          (controller) => Tween<double>(begin: 1.0, end: 1.2).animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInOut),
          ),
        )
        .toList();

    _updateAnimations();
  }

  @override
  void didUpdateWidget(AnimatedCustomBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _updateAnimations();
    }
  }

  void _updateAnimations() {
    for (int i = 0; i < _controllers.length; i++) {
      if (i == widget.currentIndex) {
        _controllers[i].forward();
      } else {
        _controllers[i].reverse();
      }
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageTheme = widget.useDynamicTheme
        ? PageThemeManager.getPageThemeByIndex(widget.currentIndex)
        : null;

    final navBarColor =
        widget.backgroundColor ??
        pageTheme?.backgroundColor ??
        pageTheme?.navigationBarColor ??
        Colors.white;
    final selectedNavColor =
        widget.selectedColor ??
        pageTheme?.navigationBarSelectedColor ??
        Colors.blue;
    final unselectedNavColor =
        widget.unselectedColor ??
        pageTheme?.navigationBarUnselectedColor ??
        Colors.grey;

    return Container(
      decoration: BoxDecoration(
        color: navBarColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildAnimatedNavItem(
                0,
                AppIcons.dashboard,
                AppIcons.dashboardActive,
                "0072da457abv1I0ZyS5c".tr,
                selectedNavColor,
                unselectedNavColor,
              ),
              _buildAnimatedNavItem(
                1,
                AppIcons.society,
                AppIcons.societyActive,
                "5bcd0ddcddPvo2jYesxV".tr,
                selectedNavColor,
                unselectedNavColor,
              ),
              _buildAnimatedNavItem(
                2,
                AppIcons.improvement,
                AppIcons.improvementActive,
                "3cd4b73afasUAXDKOXal".tr,
                selectedNavColor,
                unselectedNavColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedNavItem(
    int index,
    String normalIcon,
    String activeIcon,
    String label,
    Color selectedColor,
    Color unselectedColor,
  ) {
    final isSelected = widget.currentIndex == index;
    final iconPath = isSelected ? activeIcon : normalIcon;
    final color = isSelected ? selectedColor : unselectedColor;
    final baseSize = isSelected ? widget.selectedIconSize : widget.iconSize;

    return GestureDetector(
      onTap: () {
        // 为导航切换提供专门的震动反馈
        HapticFeedbackHelper.navigationTap();
        widget.onTap(index);
      },
      child: AnimatedBuilder(
        animation: _animations[index],
        builder: (context, child) {
          final scale = _animations[index].value;
          final size = baseSize * scale;

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isSelected
                  ? selectedColor.withValues(alpha: 0.1)
                  : Colors.transparent,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AssetManager.getIconPath(iconPath),
                  width: size,
                  height: size,
                  color: color,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      _getDefaultIcon(index),
                      size: size,
                      color: color,
                    );
                  },
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 12 * scale,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  IconData _getDefaultIcon(int index) {
    switch (index) {
      case 0:
        return Icons.dashboard;
      case 1:
        return Icons.groups;
      case 2:
        return Icons.trending_up;
      default:
        return Icons.circle;
    }
  }
}

class ResponsiveBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool useAnimation;

  const ResponsiveBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.useAnimation = true,
  });

  @override
  Widget build(BuildContext context) {
    if (useAnimation) {
      return AnimatedCustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        useDynamicTheme: true,
      );
    } else {
      return CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        useDynamicTheme: true,
      );
    }
  }
}
