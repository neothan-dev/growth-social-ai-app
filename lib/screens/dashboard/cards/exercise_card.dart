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

class ExerciseCard extends StatefulWidget {
  final DashboardCardModel model;

  ExerciseCard({Key? key})
    : model = DashboardCardModel(
        type: DashboardCardType.exercise,
        title: "ae4d58abf9b9cKhEGzWq".tr,
        width: 2,
        height: 2,
        data: {
          'duration': 45,
          'calories': 320,
          'type': "591052c733nRVCCV8txj".tr,
        },
      ),
      super(key: key);

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late AnimationController _durationController;
  late AnimationController _caloriesController;
  late AnimationController _progressController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<int> _durationAnimation;
  late Animation<int> _caloriesAnimation;
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

    _durationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _caloriesController = AnimationController(
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

    final duration = widget.model.data['duration'] ?? 0;
    _durationAnimation = IntTween(begin: 0, end: duration).animate(
      CurvedAnimation(parent: _durationController, curve: Curves.easeOutCubic),
    );

    final calories = widget.model.data['calories'] ?? 0;
    _caloriesAnimation = IntTween(begin: 0, end: calories).animate(
      CurvedAnimation(parent: _caloriesController, curve: Curves.easeOutCubic),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeOutCubic),
    );

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 600));

    if (mounted) {
      _slideController.forward();
      _fadeController.forward();
      _durationController.forward();
      _caloriesController.forward();
      _progressController.forward();

      final duration = widget.model.data['duration'] ?? 0;
      final isGoodExercise = duration >= 30;

      if (isGoodExercise) {
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
    _durationController.dispose();
    _caloriesController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  IconData _getExerciseIcon(String type) {
    if (type == "591052c73359IWgsNQBT".tr) {
      return Icons.directions_run;
    } else if (type == "3a8b5cef57Rz1pDL3lAW".tr) {
      return Icons.directions_walk;
    } else if (type == "e81f910c0fWrNzOGgc35".tr) {
      return Icons.directions_bike;
    } else if (type == "f864303afbdR0LX6NSRi".tr) {
      return Icons.pool;
    } else if (type == "5d925cc69dAeVOQWGuv1".tr) {
      return Icons.fitness_center;
    } else {
      return Icons.sports_soccer;
    }
  }

  Color _getExerciseColor(String type) {
    if (type == "591052c733oTNCINS9OB".tr) {
      return const Color(0xFFE91E63);
    } else if (type == "3a8b5cef57wOmcUMeOCw".tr) {
      return const Color(0xFF4CAF50);
    } else if (type == "e81f910c0fQWkJmdPz0f".tr) {
      return const Color(0xFF2196F3);
    } else if (type == "f864303afb78Dx3gSSOl".tr) {
      return const Color(0xFF00BCD4);
    } else if (type == "5d925cc69d3ij36ECnXN".tr) {
      return const Color(0xFFFF9800);
    } else {
      return const Color(0xFF9C27B0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final duration = widget.model.data['duration'] ?? 0;
    final calories = widget.model.data['calories'] ?? 0;
    final type = widget.model.data['type'] ?? "a9d130d795wcbSJ9hAmn".tr;
    final exerciseIcon = _getExerciseIcon(type);
    final exerciseColor = _getExerciseColor(type);
    final isGoodExercise = duration >= 30;

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: isGoodExercise ? _pulseAnimation.value : 1.0,
              child: GestureDetector(
                onTap: () {
                  // 为卡片点击提供震动反馈
                  HapticFeedbackHelper.buttonTap();
                  Navigator.of(context).pushNamed('/exercise_detail_screen');
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
                              exerciseColor,
                              exerciseColor.withValues(alpha: 0.8),
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
                                    child: Icon(
                                      exerciseIcon,
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
                                        fontSize: 16,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      type,
                                      style: AppTheme.bodyMedium.copyWith(
                                        color: Colors.white.withValues(
                                          alpha: 0.9,
                                        ),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
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
                                                        _durationAnimation,
                                                    builder: (context, child) {
                                                      return Text(
                                                        _durationAnimation.value
                                                            .toString(),
                                                        style: AppTheme.h3
                                                            .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20,
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
                                                      "bd957bc497wwShZ3zlDT".tr,
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
                                                "0c585c8258pd0JJ5fakC".tr,
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
                                                        _caloriesAnimation,
                                                    builder: (context, child) {
                                                      return Text(
                                                        _caloriesAnimation.value
                                                            .toString(),
                                                        style: AppTheme.h3
                                                            .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20,
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
                                                      'kcal',
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
                                                "93ddcd048fTNQ5XR8hzB".tr,
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
                                    AnimatedBuilder(
                                      animation: _progressAnimation,
                                      builder: (context, child) {
                                        return Container(
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withValues(
                                              alpha: 0.2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              2,
                                            ),
                                          ),
                                          child: FractionallySizedBox(
                                            alignment: Alignment.centerLeft,
                                            widthFactor:
                                                _progressAnimation.value,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
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
