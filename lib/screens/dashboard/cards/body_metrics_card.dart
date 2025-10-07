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

import '../../../models/dashboard_card_model.dart';
import '../../../theme/app_theme.dart';
import 'package:flutter/material.dart';
import '../../../localization/app_localizations.dart';
import '../../../utils/haptic_feedback_helper.dart';

class BodyMetricsCard extends StatefulWidget {
  final DashboardCardModel model;

  BodyMetricsCard({Key? key})
    : model = DashboardCardModel(
        type: DashboardCardType.bodyMetrics,
        title: "d50dc87729AbwxErh1vP".tr,
        width: 2,
        height: 2,
        data: {'weight': 65, 'height': 170},
      ),
      super(key: key);

  @override
  State<BodyMetricsCard> createState() => _BodyMetricsCardState();
}

class _BodyMetricsCardState extends State<BodyMetricsCard>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late AnimationController _weightController;
  late AnimationController _heightController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<int> _weightAnimation;
  late Animation<int> _heightAnimation;

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
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _weightController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _heightController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    _pulseAnimation = Tween<double>(begin: 0.95, end: 0.87).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    final weight = widget.model.data['weight'] ?? 0;
    _weightAnimation = IntTween(begin: 0, end: weight).animate(
      CurvedAnimation(parent: _weightController, curve: Curves.easeOutCubic),
    );

    final height = widget.model.data['height'] ?? 0;
    _heightAnimation = IntTween(begin: 0, end: height).animate(
      CurvedAnimation(parent: _heightController, curve: Curves.easeOutCubic),
    );

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (mounted) {
      _slideController.forward();
      _fadeController.forward();
      _weightController.forward();
      _heightController.forward();

      final weight = widget.model.data['weight'] ?? 0;
      final height = widget.model.data['height'] ?? 0;
      final bmi = height > 0 ? weight / ((height / 100) * (height / 100)) : 0;
      final isHealthy = bmi >= 18.5 && bmi <= 24.9;
      if (isHealthy) {
        _pulseController.repeat(reverse: true);
      }
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _pulseController.dispose();
    _slideController.dispose();
    _fadeController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _onTap(BuildContext context) {
    // 为卡片点击提供震动反馈
    HapticFeedbackHelper.buttonTap();
    Navigator.of(context).pushNamed('/body_metrics_detail_screen');
  }

  @override
  Widget build(BuildContext context) {
    final weight = widget.model.data['weight'] ?? 0;
    final height = widget.model.data['height'] ?? 0;
    final bmi = height > 0 ? weight / ((height / 100) * (height / 100)) : 0;
    final isHealthy = bmi >= 18.5 && bmi <= 24.9;

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: isHealthy ? _pulseAnimation.value : 1.0,
              child: GestureDetector(
                onTap: () => _onTap(context),
                onTapDown: (_) => _scaleController.forward(),
                onTapUp: (_) => _scaleController.reverse(),
                onTapCancel: () => _scaleController.reverse(),
                child: AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: isHealthy
                                ? const [Color(0xFF4facfe), Color(0xFF00f2fe)]
                                : const [Color(0xFFfa709a), Color(0xFFfee140)],
                          ),
                          borderRadius: AppTheme.borderRadiusLg,
                          boxShadow: AppTheme.shadowMd,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          padding: AppTheme.paddingMd,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(
                                        alpha: 0.2,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.monitor_weight,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      widget.model.title,
                                      style: AppTheme.h4.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  AnimatedBuilder(
                                                    animation: _weightAnimation,
                                                    builder: (context, child) {
                                                      return Text(
                                                        _weightAnimation.value
                                                            .toString(),
                                                        style: AppTheme.h3
                                                            .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 24,
                                                            ),
                                                      );
                                                    },
                                                  ),
                                                  const SizedBox(width: 2),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                          bottom: 2,
                                                        ),
                                                    child: Text(
                                                      'kg',
                                                      style: AppTheme.bodySmall
                                                          .copyWith(
                                                            color: Colors.white
                                                                .withValues(
                                                                  alpha: 0.8,
                                                                ),
                                                            fontSize: 10,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                "38f7c7e22ftSZ4JZRxDQ".tr,
                                                style: AppTheme.caption
                                                    .copyWith(
                                                      color: Colors.white
                                                          .withValues(
                                                            alpha: 0.7,
                                                          ),
                                                      fontSize: 10,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 1,
                                          height: 30,
                                          color: Colors.white.withValues(
                                            alpha: 0.3,
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  AnimatedBuilder(
                                                    animation: _heightAnimation,
                                                    builder: (context, child) {
                                                      return Text(
                                                        _heightAnimation.value
                                                            .toString(),
                                                        style: AppTheme.h3
                                                            .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 24,
                                                            ),
                                                      );
                                                    },
                                                  ),
                                                  const SizedBox(width: 2),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                          bottom: 2,
                                                        ),
                                                    child: Text(
                                                      'cm',
                                                      style: AppTheme.bodySmall
                                                          .copyWith(
                                                            color: Colors.white
                                                                .withValues(
                                                                  alpha: 0.8,
                                                                ),
                                                            fontSize: 10,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                "2763b73dd1ImDEDYEcqc".tr,
                                                style: AppTheme.caption
                                                    .copyWith(
                                                      color: Colors.white
                                                          .withValues(
                                                            alpha: 0.7,
                                                          ),
                                                      fontSize: 10,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    if (bmi > 0)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(
                                            alpha: 0.2,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Text(
                                          'BMI: ${bmi.toStringAsFixed(1)}',
                                          style: AppTheme.caption.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
