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

class HealthTipCard extends StatefulWidget {
  final Map<String, dynamic> healthData;

  const HealthTipCard({super.key, required this.healthData});

  @override
  State<HealthTipCard> createState() => _HealthTipCardState();
}

class _HealthTipCardState extends State<HealthTipCard>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _tipController;
  late AnimationController _pulseController;

  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _tipAnimation;
  late Animation<double> _pulseAnimation;

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

    _tipController = AnimationController(
      duration: const Duration(milliseconds: 1500),
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

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    _tipAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _tipController, curve: Curves.easeInOut));

    _pulseAnimation = Tween<double>(begin: 0.95, end: 0.87).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 400));

    if (mounted) {
      _slideController.forward();
      _fadeController.forward();
      _tipController.forward();
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    _scaleController.dispose();
    _tipController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Map<String, dynamic> _getHealthTip() {
    final steps = widget.healthData['steps'] ?? 0;
    final sleep = widget.healthData['sleep'] ?? 0.0;
    final water = widget.healthData['water'] ?? 0;
    final mood = widget.healthData['mood'] ?? 0;
    final exercise = widget.healthData['exercise'] ?? 0;

    // 根据数据提供个性化建议
    if (steps < 5000) {
      return {
        'title': "c5b6701fa62eSGq5bD8u".tr,
        'tip': "4616f40196SavrLbiBDQ".tr,
        'icon': Icons.directions_walk,
        'color': const Color(0xFF4CAF50),
        'action': "6f264cd5b3XjJuUxPhDu".tr,
      };
    } else if (sleep < 6.0) {
      return {
        'title': "8e3a13ff1bT4IDbmdB6M".tr,
        'tip': "8a5b090f70vN2UW8pMyd".tr,
        'icon': Icons.bedtime,
        'color': const Color(0xFF2196F3),
        'action': "73d7e5970fXGh31uAJUJ".tr,
      };
    } else if (water < 1000) {
      return {
        'title': "52ba0e8b86XBLy0XCLGq".tr,
        'tip': "a61e617ef3BPZmiIRt3T".tr,
        'icon': Icons.local_drink,
        'color': const Color(0xFF00BCD4),
        'action': "b351309164s1FOBGxri5".tr,
      };
    } else if (mood < 6) {
      return {
        'title': "c80d18cdb3myhi2jrVpn".tr,
        'tip': "fd82d11c469urMbQzuvT".tr,
        'icon': Icons.psychology,
        'color': const Color(0xFF9C27B0),
        'action': "927b91b887TEbJeA1Rmh".tr,
      };
    } else if (exercise < 30) {
      return {
        'title': "6d0c215ca3s75asFi1jR".tr,
        'tip': "051dffbcf67JtzldpYux".tr,
        'icon': Icons.fitness_center,
        'color': const Color(0xFFFF9800),
        'action': "44720f217cS3cSWIv9UN".tr,
      };
    } else {
      return {
        'title': "999d579bcb01mfnasN2T".tr,
        'tip': "abc21632dcEnFILznHpC".tr,
        'icon': Icons.check_circle,
        'color': const Color(0xFF4CAF50),
        'action': "a748cc074fkV5Zkj4DPI".tr,
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final tip = _getHealthTip();

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
                              tip['color'],
                              tip['color'].withValues(alpha: 0.8),
                            ],
                          ),
                          borderRadius: AppTheme.borderRadiusLg,
                          boxShadow: AppTheme.shadowMd,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 160,
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
                                    child: Icon(
                                      tip['icon'],
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      tip['title'],
                                      style: AppTheme.h4.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
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
                                      "3fdcde9363pVLeZ2gEzS".tr,
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
                              // 建议内容
                              Expanded(
                                child: AnimatedBuilder(
                                  animation: _tipAnimation,
                                  builder: (context, child) {
                                    return Opacity(
                                      opacity: _tipAnimation.value,
                                      child: Text(
                                        tip['tip'],
                                        style: AppTheme.bodyMedium.copyWith(
                                          color: Colors.white.withValues(
                                            alpha: 0.9,
                                          ),
                                          fontSize: 13,
                                          height: 1.4,
                                        ),
                                      ),
                                    );
                                  },
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
