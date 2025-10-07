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

class WaterIntakeCard extends StatefulWidget {
  final DashboardCardModel model;

  WaterIntakeCard({Key? key})
    : model = DashboardCardModel(
        type: DashboardCardType.waterIntake,
        title: "218ec3a501ymYfqBlqPc".tr,
        width: 2,
        height: 2,
        data: {'current': 1200, 'target': 2000, 'unit': 'ml'},
      ),
      super(key: key);

  @override
  State<WaterIntakeCard> createState() => _WaterIntakeCardState();
}

class _WaterIntakeCardState extends State<WaterIntakeCard>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late AnimationController _waterController;
  late AnimationController _bubbleController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<int> _waterAnimation;
  late Animation<double> _bubbleAnimation;

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

    _waterController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _bubbleController = AnimationController(
      duration: const Duration(milliseconds: 3000),
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

    final current = widget.model.data['current'] ?? 0;
    _waterAnimation = IntTween(begin: 0, end: current).animate(
      CurvedAnimation(parent: _waterController, curve: Curves.easeOutCubic),
    );

    _bubbleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _bubbleController, curve: Curves.easeInOut),
    );

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 700));

    if (mounted) {
      _slideController.forward();
      _fadeController.forward();
      _waterController.forward();
      _bubbleController.repeat();

      final current = widget.model.data['current'] ?? 0;
      final target = widget.model.data['target'] ?? 2000;
      final progress = current / target;
      final isGoodHydration = progress >= 0.6;

      if (isGoodHydration) {
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
    _waterController.dispose();
    _bubbleController.dispose();
    super.dispose();
  }

  String _getHydrationStatus(int current, int target) {
    final progress = current / target;
    if (progress >= 1.0) return "f28461bb49UOTUf7OLpp".tr;
    if (progress >= 0.8) return "38e5b024a6WhiABvHql4".tr;
    if (progress >= 0.6) return "cfea0dce5chGFsdsOinc".tr;
    if (progress >= 0.4) return "91e25f4ddcGsxCkk8tFZ".tr;
    return "bd11471f3fJ8afKyawSn".tr;
  }

  Color _getStatusColor(String status) {
    if (status == "f28461bb49FHslmmMTiO".tr ||
        status == "38e5b024a6QMECA06fEf".tr) {
      return const Color(0xFF4CAF50);
    } else if (status == "cfea0dce5c3Lb5IW1wDe".tr) {
      return const Color(0xFF2196F3);
    } else if (status == "91e25f4ddcswS2uQNIFv".tr) {
      return const Color(0xFFFF9800);
    } else {
      return const Color(0xFFF44336);
    }
  }

  @override
  Widget build(BuildContext context) {
    final current = widget.model.data['current'] ?? 0;
    final target = widget.model.data['target'] ?? 2000;
    final unit = widget.model.data['unit'] ?? 'ml';
    final progress = current / target;
    final status = _getHydrationStatus(current, target);
    final statusColor = _getStatusColor(status);
    final isGoodHydration = progress >= 0.6;

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: isGoodHydration ? _pulseAnimation.value : 1.0,
              child: GestureDetector(
                onTap: () {
                  // 为卡片点击提供震动反馈
                  HapticFeedbackHelper.buttonTap();
                  Navigator.of(
                    context,
                  ).pushNamed('/water_intake_detail_screen');
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
                                      Icons.local_drink,
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
                              const SizedBox(height: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        AnimatedBuilder(
                                          animation: _waterAnimation,
                                          builder: (context, child) {
                                            return Text(
                                              _waterAnimation.value.toString(),
                                              style: AppTheme.h2.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(width: 4),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 4,
                                          ),
                                          child: Text(
                                            '/ $target $unit',
                                            style: AppTheme.bodyMedium.copyWith(
                                              color: Colors.white.withValues(
                                                alpha: 0.8,
                                              ),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 0.2,
                                        ),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: FractionallySizedBox(
                                        alignment: Alignment.centerLeft,
                                        widthFactor: progress.clamp(0.0, 1.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              3,
                                            ),
                                          ),
                                        ),
                                      ),
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
                                        AnimatedBuilder(
                                          animation: _bubbleAnimation,
                                          builder: (context, child) {
                                            return Transform.translate(
                                              offset: Offset(
                                                0,
                                                -_bubbleAnimation.value * 10,
                                              ),
                                              child: Opacity(
                                                opacity:
                                                    0.6 +
                                                    (_bubbleAnimation.value *
                                                        0.4),
                                                child: Icon(
                                                  Icons.water_drop,
                                                  color: Colors.white
                                                      .withValues(alpha: 0.8),
                                                  size: 16,
                                                ),
                                              ),
                                            );
                                          },
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
