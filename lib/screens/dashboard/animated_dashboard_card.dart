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
import '../../models/dashboard_card_model.dart';
import '../../theme/app_theme.dart';
import '../../utils/haptic_feedback_helper.dart';

abstract class AnimatedDashboardCard extends StatefulWidget {
  final DashboardCardModel model;
  final int animationDelay;

  const AnimatedDashboardCard({
    required this.model,
    this.animationDelay = 0,
    Key? key,
  }) : super(key: key);

  @protected
  void onTap(BuildContext context) {
    // 为卡片点击提供震动反馈
    HapticFeedbackHelper.buttonTap();
    // 可在基类做通用处理，如埋点、动画等
  }

  @override
  State<AnimatedDashboardCard> createState() => _AnimatedDashboardCardState();
}

class _AnimatedDashboardCardState extends State<AnimatedDashboardCard>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late AnimationController _fadeController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(Duration(milliseconds: widget.animationDelay));

    if (mounted) {
      _slideController.forward();
      _fadeController.forward();
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _pulseController.dispose();
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError('子类必须实现build方法');
  }

  Widget buildAnimatedCardContainer({
    required BuildContext context,
    required Widget child,
    required List<Color> gradientColors,
    double height = 150,
    EdgeInsets? padding,
    bool enablePulse = false,
    bool enableHover = true,
  }) {
    Widget cardWidget = Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        borderRadius: AppTheme.borderRadiusLg,
        boxShadow: AppTheme.shadowMd,
      ),
      child: Container(
        width: double.infinity,
        height: height,
        padding: padding ?? AppTheme.paddingMd,
        child: child,
      ),
    );

    if (enablePulse) {
      cardWidget = AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _pulseAnimation.value,
            child: cardWidget,
          );
        },
      );
    }

    if (enableHover) {
      cardWidget = MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => widget.onTap(context),
          onTapDown: (_) => _scaleController.forward(),
          onTapUp: (_) => _scaleController.reverse(),
          onTapCancel: () => _scaleController.reverse(),
          child: AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: cardWidget,
              );
            },
          ),
        ),
      );
    } else {
      cardWidget = GestureDetector(
        onTap: () => widget.onTap(context),
        child: cardWidget,
      );
    }

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(opacity: _fadeAnimation, child: cardWidget),
    );
  }

  Widget buildAnimatedProgressBar({
    required double progress,
    required Color backgroundColor,
    required Color progressColor,
    double height = 6,
    Duration duration = const Duration(milliseconds: 1500),
  }) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      tween: Tween(begin: 0.0, end: progress),
      builder: (context, value, child) {
        return Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(height / 2),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: value.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: progressColor,
                borderRadius: BorderRadius.circular(height / 2),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildAnimatedNumber({
    required int number,
    required TextStyle style,
    Duration duration = const Duration(milliseconds: 1500),
  }) {
    return TweenAnimationBuilder<int>(
      duration: duration,
      tween: Tween(begin: 0, end: number),
      builder: (context, value, child) {
        return Text(value.toString(), style: style);
      },
    );
  }

  Widget buildAnimatedIcon({
    required IconData icon,
    required Color color,
    double size = 24,
    Duration duration = const Duration(milliseconds: 800),
  }) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Icon(icon, color: color, size: size),
        );
      },
    );
  }

  Widget buildAnimatedTag({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    Duration duration = const Duration(milliseconds: 600),
  }) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              text,
              style: AppTheme.caption.copyWith(
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildAnimatedCardHeader({
    required IconData icon,
    String? badgeText,
    Color iconColor = Colors.white,
    Color badgeColor = Colors.white,
  }) {
    return Row(
      children: [
        buildAnimatedIcon(icon: icon, color: iconColor, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            widget.model.title,
            style: AppTheme.h4.copyWith(
              color: iconColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (badgeText != null)
          buildAnimatedTag(
            text: badgeText,
            backgroundColor: badgeColor.withValues(alpha: 0.2),
            textColor: badgeColor,
          ),
      ],
    );
  }
}
