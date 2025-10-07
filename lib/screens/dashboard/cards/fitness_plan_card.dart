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
import '../../../theme/app_theme.dart';
import '../../../utils/haptic_feedback_helper.dart';
import '../../../localization/app_localizations.dart';

class FitnessPlanCard extends StatefulWidget {
  final Map<String, dynamic> fitnessData;

  const FitnessPlanCard({super.key, required this.fitnessData});

  @override
  State<FitnessPlanCard> createState() => _FitnessPlanCardState();
}

class _FitnessPlanCardState extends State<FitnessPlanCard>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _progressController;
  late AnimationController _pulseController;

  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _progressAnimation;
  late Animation<double> _pulseAnimation;

  int _currentPlanIndex = 0;

  final List<Map<String, dynamic>> _fitnessPlans = [
    {
      'title': "85f6d52d85JIBPWhdM4z".tr,
      'description': "0ecbc91ddcIR6Zz325yR".tr,
      'image': 'assets/images/social_custom/fitness_video/fitness_core.jpg',
      'duration': "16bdb584a97QfGpXG1d1".tr,
      'difficulty': "c7092c51fdOzBsPCb42q".tr,
      'progress': 0.6,
      'color': const Color(0xFF4CAF50),
    },
    {
      'title': "dcac6e014fpa0HPw5YG8".tr,
      'description': "11deb40d17GnzhXc0a4s".tr,
      'image': 'assets/images/social_custom/fitness_video/fitness_yoga.jpg',
      'duration': "859757ea79xzQQMJxzyF".tr,
      'difficulty': "0180572731PcEZNZ3S4T".tr,
      'progress': 0.8,
      'color': const Color(0xFF9C27B0),
    },
    {
      'title': "2bf8c59055wCTzDlguaH".tr,
      'description': "034b3269d3zJYSAQ5sVi".tr,
      'image': 'assets/images/social_custom/fitness_video/fitness_hiit.jpg',
      'duration': "77124550147qw4ormq7e".tr,
      'difficulty': "4ea02714a17DpRP7hvBX".tr,
      'progress': 0.3,
      'color': const Color(0xFFFF5722),
    },
    {
      'title': "c58e610ccff6WnQeWaHl".tr,
      'description': "e28970f1beVhLNW139Xe".tr,
      'image': 'assets/images/social_custom/fitness_video/fitness_dance.jpg',
      'duration': "0d41e3dcbc39Y0QrxLhS".tr,
      'difficulty': "c7092c51fdIMIa7ZrCTb".tr,
      'progress': 0.9,
      'color': const Color(0xFFE91E63),
    },
  ];

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _progressController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeOutCubic),
    );

    _pulseAnimation = Tween<double>(begin: 0.99, end: 0.95).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (mounted) {
      _slideController.forward();
      _fadeController.forward();
      _progressController.forward();
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    _scaleController.dispose();
    _progressController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _nextPlan() {
    setState(() {
      _currentPlanIndex = (_currentPlanIndex + 1) % _fitnessPlans.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final plan = _fitnessPlans[_currentPlanIndex];

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _pulseAnimation.value,
              child: GestureDetector(
                onTap: () {
                  HapticFeedbackHelper.buttonTap();
                  _nextPlan();
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
                              plan['color'],
                              plan['color'].withValues(alpha: 0.8),
                            ],
                          ),
                          borderRadius: AppTheme.borderRadiusLg,
                          boxShadow: AppTheme.shadowMd,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          padding: AppTheme.paddingMd,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 头部
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
                                      Icons.fitness_center,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      "8efe79c8af7m55lov3Dm".tr,
                                      style: AppTheme.h4.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(
                                        alpha: 0.2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      plan['difficulty'],
                                      style: AppTheme.caption.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              // 内容区域
                              Expanded(
                                child: Row(
                                  children: [
                                    // 左侧图片
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 120,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withValues(
                                                alpha: 0.2,
                                              ),
                                              blurRadius: 8,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          child: Image.asset(
                                            plan['image'],
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withValues(
                                                            alpha: 0.2,
                                                          ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),
                                                    child: const Icon(
                                                      Icons.fitness_center,
                                                      color: Colors.white,
                                                      size: 40,
                                                    ),
                                                  );
                                                },
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    // 右侧信息
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            plan['title'],
                                            style: AppTheme.h4.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            plan['description'],
                                            style: AppTheme.bodySmall.copyWith(
                                              color: Colors.white.withValues(
                                                alpha: 0.9,
                                              ),
                                              fontSize: 12,
                                              height: 1.3,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 8),
                                          // 进度条
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "6e6259673f5PSQiEpESJ".tr,
                                                    style: AppTheme.caption
                                                        .copyWith(
                                                          color: Colors.white
                                                              .withValues(
                                                                alpha: 0.8,
                                                              ),
                                                          fontSize: 10,
                                                        ),
                                                  ),
                                                  Text(
                                                    '${(plan['progress'] * 100).toInt()}%',
                                                    style: AppTheme.caption
                                                        .copyWith(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 4),
                                              AnimatedBuilder(
                                                animation: _progressAnimation,
                                                builder: (context, child) {
                                                  return Container(
                                                    height: 4,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withValues(
                                                            alpha: 0.2,
                                                          ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            2,
                                                          ),
                                                    ),
                                                    child: FractionallySizedBox(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      widthFactor:
                                                          _progressAnimation
                                                              .value *
                                                          plan['progress'],
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
                                            ],
                                          ),
                                          const Spacer(),
                                          // 底部信息
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.access_time,
                                                color: Colors.white.withValues(
                                                  alpha: 0.8,
                                                ),
                                                size: 14,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                plan['duration'],
                                                style: AppTheme.caption
                                                    .copyWith(
                                                      color: Colors.white
                                                          .withValues(
                                                            alpha: 0.8,
                                                          ),
                                                      fontSize: 10,
                                                    ),
                                              ),
                                              const Spacer(),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withValues(alpha: 0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Text(
                                                  "b6b73f94d4bEAJMV2AkD".tr,
                                                  style: AppTheme.caption
                                                      .copyWith(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 10,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
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
