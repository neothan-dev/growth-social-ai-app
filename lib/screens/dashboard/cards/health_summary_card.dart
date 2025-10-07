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
import '../../../utils/haptic_feedback_helper.dart';
import '../../../localization/app_localizations.dart';

class HealthSummaryCard extends StatefulWidget {
  final DashboardCardModel model;

  HealthSummaryCard({super.key})
    : model = DashboardCardModel(
        type: DashboardCardType.healthSummary,
        title: "4edccb64fauZPkXky8Q1".tr,
        width: 4,
        height: 2,
        data: {
          'steps': 8500,
          'sleep': 7.5,
          'water': 1200,
          'exercise': 45,
          'mood': 8,
          'healthScore': 85,
        },
      );

  @override
  State<HealthSummaryCard> createState() => _HealthSummaryCardState();
}

class _HealthSummaryCardState extends State<HealthSummaryCard>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late AnimationController _scoreController;
  late AnimationController _progressController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<int> _scoreAnimation;
  late Animation<double> _progressAnimation;

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

    _scoreController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _progressController = AnimationController(
      duration: const Duration(milliseconds: 2000),
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

    final healthScore = widget.model.data['healthScore'] ?? 0;
    _scoreAnimation = IntTween(begin: 0, end: healthScore).animate(
      CurvedAnimation(parent: _scoreController, curve: Curves.easeOutCubic),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeOutCubic),
    );

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 900));

    if (mounted) {
      _slideController.forward();
      _fadeController.forward();
      _scoreController.forward();
      _progressController.forward();

      final healthScore = widget.model.data['healthScore'] ?? 0;
      final isGoodHealth = healthScore >= 80;

      if (isGoodHealth) {
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
    _scoreController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  Color _getHealthScoreColor(int score) {
    if (score >= 90) return const Color(0xFF4CAF50);
    if (score >= 80) return const Color(0xFF8BC34A);
    if (score >= 70) return const Color(0xFFFF9800);
    if (score >= 60) return const Color(0xFFFFC107);
    return const Color(0xFFF44336);
  }

  String _getHealthStatus(int score) {
    if (score >= 90) return "2c99de8357OTJ2cVk6wX".tr;
    if (score >= 80) return "cfea0dce5cDR19Hdt5v5".tr;
    if (score >= 70) return "91e25f4ddcSJAFGob5sx".tr;
    if (score >= 60) return "82474ffff0eciXWV0xtE".tr;
    return "f121ab742c9DP6HPfaPp".tr;
  }

  Widget _buildMetricItem(
    String label,
    dynamic value,
    String unit,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final steps = widget.model.data['steps'] ?? 0;
    final sleep = widget.model.data['sleep'] ?? 0.0;
    final water = widget.model.data['water'] ?? 0;
    final exercise = widget.model.data['exercise'] ?? 0;
    final mood = widget.model.data['mood'] ?? 0;
    final healthScore = widget.model.data['healthScore'] ?? 0;
    final healthColor = _getHealthScoreColor(healthScore);
    final healthStatus = _getHealthStatus(healthScore);
    final isGoodHealth = healthScore >= 80;

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: isGoodHealth ? _pulseAnimation.value : 1.0,
              child: GestureDetector(
                onTap: () {
                  // 为卡片点击提供震动反馈
                  HapticFeedbackHelper.buttonTap();
                  Navigator.of(
                    context,
                  ).pushNamed('/health_summary_detail_screen');
                },
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
                            colors: [
                              healthColor,
                              healthColor.withValues(alpha: 0.8),
                            ],
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
                                      Icons.health_and_safety,
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
                                  AnimatedBuilder(
                                    animation: _scoreAnimation,
                                    builder: (context, child) {
                                      return Column(
                                        children: [
                                          Text(
                                            _scoreAnimation.value.toString(),
                                            style: AppTheme.h3.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 3,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withValues(
                                              alpha: 0.2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Text(
                                            healthStatus,
                                            style: AppTheme.caption.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        Expanded(
                                          child: AnimatedBuilder(
                                            animation: _progressAnimation,
                                            builder: (context, child) {
                                              return Container(
                                                height: 4,
                                                decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withValues(alpha: 0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                ),
                                                child: FractionallySizedBox(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  widthFactor:
                                                      _progressAnimation.value *
                                                      (healthScore / 100),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            2,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      children: [
                                        _buildMetricItem(
                                          "2986c7ee97GrnrcHpME7".tr,
                                          steps,
                                          "",
                                          Icons.directions_walk,
                                          Colors.white,
                                        ),
                                        const SizedBox(width: 5),
                                        _buildMetricItem(
                                          "01324e540dqeogNsFzTa".tr,
                                          sleep,
                                          "h",
                                          Icons.bedtime,
                                          Colors.white,
                                        ),
                                        const SizedBox(width: 5),
                                        _buildMetricItem(
                                          "6edae041a3xZXEyPpJ3Q".tr,
                                          water,
                                          "ml",
                                          Icons.local_drink,
                                          Colors.white,
                                        ),
                                        const SizedBox(width: 5),
                                        _buildMetricItem(
                                          "a9d130d795a9QwiRtMx0".tr,
                                          exercise,
                                          "min",
                                          Icons.fitness_center,
                                          Colors.white,
                                        ),
                                        const SizedBox(width: 5),
                                        _buildMetricItem(
                                          "28f5b85888kpXwMrwm6E".tr,
                                          mood,
                                          "/10",
                                          Icons.psychology,
                                          Colors.white,
                                        ),
                                      ],
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
