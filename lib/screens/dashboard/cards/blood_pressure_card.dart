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

class BloodPressureCard extends StatefulWidget {
  final DashboardCardModel model;

  BloodPressureCard({Key? key})
    : model = DashboardCardModel(
        type: DashboardCardType.bloodPressure,
        title: "71f5c90e87DNItHUu7gr".tr,
        width: 2,
        height: 2,
        data: {'systolic': 120, 'diastolic': 80, 'pulse': 72},
      ),
      super(key: key);

  @override
  State<BloodPressureCard> createState() => _BloodPressureCardState();
}

class _BloodPressureCardState extends State<BloodPressureCard>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late AnimationController _systolicController;
  late AnimationController _diastolicController;
  late AnimationController _pulseAnimationController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<int> _systolicAnimation;
  late Animation<int> _diastolicAnimation;
  late Animation<double> _pulseAnimationValue;

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

    _systolicController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _diastolicController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _pulseAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
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

    final systolic = widget.model.data['systolic'] ?? 0;
    _systolicAnimation = IntTween(begin: 0, end: systolic).animate(
      CurvedAnimation(parent: _systolicController, curve: Curves.easeOutCubic),
    );

    final diastolic = widget.model.data['diastolic'] ?? 0;
    _diastolicAnimation = IntTween(begin: 0, end: diastolic).animate(
      CurvedAnimation(parent: _diastolicController, curve: Curves.easeOutCubic),
    );

    _pulseAnimationValue = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _pulseAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 400));

    if (mounted) {
      _slideController.forward();
      _fadeController.forward();
      _systolicController.forward();
      _diastolicController.forward();
      _pulseAnimationController.forward();

      final systolic = widget.model.data['systolic'] ?? 0;
      final diastolic = widget.model.data['diastolic'] ?? 0;
      final isNormal =
          systolic >= 90 &&
          systolic <= 140 &&
          diastolic >= 60 &&
          diastolic <= 90;

      if (isNormal) {
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
    _systolicController.dispose();
    _diastolicController.dispose();
    _pulseAnimationController.dispose();
    super.dispose();
  }

  String _getBloodPressureStatus(int systolic, int diastolic) {
    if (systolic < 90 || diastolic < 60) return "fd9b72d8deTBoNe4IfQt".tr;
    if (systolic <= 120 && diastolic <= 80) return "296de0e31folAzDhKyL8".tr;
    if (systolic <= 129 && diastolic <= 84) return "6e2f93a60bgq1BZy32zG".tr;
    if (systolic <= 139 && diastolic <= 89) return "87e867e197iYaIUn2AqB".tr;
    if (systolic <= 159 && diastolic <= 99) return "585e79121ciZ7PYO9ZEC".tr;
    if (systolic <= 179 && diastolic <= 109) return "b24cefe674G7iKT1RSEl".tr;
    return "bd0d611694LEou4sqcst".tr;
  }

  Color _getStatusColor(String status) {
    if (status == "296de0e31fwdzPjXSikh".tr)
      return const Color(0xFF4CAF50);
    else if (status == "6e2f93a60bFRnZZzltvN".tr ||
        status == "87e867e1975jwBOQjK69".tr)
      return const Color(0xFFFF9800);
    else if (status == "fd9b72d8deORDQbS5pqA".tr)
      return const Color(0xFF2196F3);
    else
      return const Color(0xFFF44336);
  }

  @override
  Widget build(BuildContext context) {
    final systolic = widget.model.data['systolic'] ?? 0;
    final diastolic = widget.model.data['diastolic'] ?? 0;
    final pulse = widget.model.data['pulse'] ?? 0;
    final status = _getBloodPressureStatus(systolic, diastolic);
    final statusColor = _getStatusColor(status);
    final isNormal = status == "296de0e31fwpSxrrpaYl".tr;

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: isNormal ? _pulseAnimation.value : 1.0,
              child: GestureDetector(
                onTap: () {
                  // 为卡片点击提供震动反馈
                  HapticFeedbackHelper.buttonTap();
                  Navigator.of(
                    context,
                  ).pushNamed('/blood_pressure_detail_screen');
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
                              statusColor,
                              statusColor.withValues(alpha: 0.8),
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
                                      Icons.favorite,
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
                                        fontSize: 13,
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
                                                    animation:
                                                        _systolicAnimation,
                                                    builder: (context, child) {
                                                      return Text(
                                                        _systolicAnimation.value
                                                            .toString(),
                                                        style: AppTheme.h3
                                                            .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
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
                                                      'mmHg',
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
                                                "cd82de3f4aY5taw7cOfP".tr,
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
                                        Text(
                                          '  ',
                                          style: AppTheme.h3.copyWith(
                                            color: Colors.white.withValues(
                                              alpha: 0.8,
                                            ),
                                            fontSize: 30,
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
                                                    animation:
                                                        _diastolicAnimation,
                                                    builder: (context, child) {
                                                      return Text(
                                                        _diastolicAnimation
                                                            .value
                                                            .toString(),
                                                        style: AppTheme.h3
                                                            .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
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
                                                      'mmHg',
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
                                                "065532444ddElI4VJAVL".tr,
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
                                    const SizedBox(height: 8),
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
                                            status,
                                            style: AppTheme.caption.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            AnimatedBuilder(
                                              animation: _pulseAnimationValue,
                                              builder: (context, child) {
                                                return Transform.scale(
                                                  scale:
                                                      0.8 +
                                                      (_pulseAnimationValue
                                                              .value *
                                                          0.2),
                                                  child: Icon(
                                                    Icons.favorite,
                                                    color: Colors.white
                                                        .withValues(alpha: 0.8),
                                                    size: 12,
                                                  ),
                                                );
                                              },
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '$pulse',
                                              style: AppTheme.caption.copyWith(
                                                color: Colors.white.withValues(
                                                  alpha: 0.8,
                                                ),
                                                fontSize: 10,
                                              ),
                                            ),
                                            Text(
                                              ' bpm',
                                              style: AppTheme.caption.copyWith(
                                                color: Colors.white.withValues(
                                                  alpha: 0.6,
                                                ),
                                                fontSize: 8,
                                              ),
                                            ),
                                          ],
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
