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

class DashboardSummaryCard extends StatefulWidget {
  final Map<String, dynamic> healthData;

  const DashboardSummaryCard({super.key, required this.healthData});

  @override
  State<DashboardSummaryCard> createState() => _DashboardSummaryCardState();
}

class _DashboardSummaryCardState extends State<DashboardSummaryCard>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late AnimationController _pulseController;
  late AnimationController _scaleController;

  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // 滑动动画控制器
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // 淡入动画控制器
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // 脉冲动画控制器
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // 缩放动画控制器
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    // 滑动动画
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, -0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    // 淡入动画
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _pulseAnimation = Tween<double>(begin: 0.99, end: 0.95).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // 缩放动画
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    // 启动动画
    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 50));

    if (mounted) {
      _slideController.forward();
      _fadeController.forward();
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    _pulseController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 6) return "7196ef2fbdyG9SwGUgxs".tr;
    if (hour < 12) return "3cc2e31eb2CcTCOEAf6B".tr;
    if (hour < 18) return "552594ef80xRsaxXqR7I".tr;
    return "d8e9a7fa20QvfbRlMNq5".tr;
  }

  String _getOverallStatus() {
    final steps = widget.healthData['steps'] ?? 0;
    final sleep = widget.healthData['sleep'] ?? 0.0;
    final water = widget.healthData['water'] ?? 0;
    final mood = widget.healthData['mood'] ?? 0;
    final exercise = widget.healthData['exercise'] ?? 0;

    int goodCount = 0;
    if (steps >= 8000) goodCount++;
    if (sleep >= 7.0) goodCount++;
    if (water >= 1500) goodCount++;
    if (mood >= 7) goodCount++;
    if (exercise >= 30) goodCount++;

    if (goodCount >= 4) return "fc4f71d88flcNRfDPpth".tr;
    if (goodCount >= 3) return "8b0c5dc1634656VvQeKi".tr;
    if (goodCount >= 2) return "38b40048ea6NaGcdZtf4".tr;
    return "6fbd06fa1dTILfRYuOHK".tr;
  }

  Color _getStatusColor() {
    final steps = widget.healthData['steps'] ?? 0;
    final sleep = widget.healthData['sleep'] ?? 0.0;
    final water = widget.healthData['water'] ?? 0;
    final mood = widget.healthData['mood'] ?? 0;
    final exercise = widget.healthData['exercise'] ?? 0;

    int goodCount = 0;
    if (steps >= 8000) goodCount++;
    if (sleep >= 7.0) goodCount++;
    if (water >= 1500) goodCount++;
    if (mood >= 7) goodCount++;
    if (exercise >= 30) goodCount++;

    if (goodCount >= 4) return const Color(0xFF4CAF50);
    if (goodCount >= 3) return const Color(0xFF8BC34A);
    if (goodCount >= 2) return const Color(0xFFFF9800);
    return const Color(0xFFFFC107);
  }

  List<Map<String, dynamic>> _getQuickStats() {
    final steps = widget.healthData['steps'] ?? 0;
    final sleep = widget.healthData['sleep'] ?? 0.0;
    final water = widget.healthData['water'] ?? 0;
    final mood = widget.healthData['mood'] ?? 0;

    return [
      {
        'icon': Icons.directions_walk,
        'value': '${(steps / 1000).toStringAsFixed(1)}k',
        'label': "2986c7ee97mSDsojJAzc".tr,
        'status': steps >= 8000
            ? "09dfac88c7ixn9eg3D0E".tr
            : "5c796003092fgMpzdkpj".tr,
        'color': steps >= 8000 ? Colors.green : Colors.orange,
        'progress': (steps / 10000).clamp(0.0, 1.0),
        'target': '10k',
        'image': 'assets/images/social_custom/moments/running1.jpg',
      },
      {
        'icon': Icons.bedtime,
        'value': '${sleep.toStringAsFixed(1)}h',
        'label': "01324e540dukxu5APpOQ".tr,
        'status': sleep >= 7.0
            ? "d56bfdd5ceiMGYD6XwmV".tr
            : "1a5219a827b4hj6fUatx".tr,
        'color': sleep >= 7.0 ? Colors.green : Colors.red,
        'progress': (sleep / 8.0).clamp(0.0, 1.0),
        'target': '8h',
        'image': 'assets/images/social_custom/moments/yoga1.jpg',
      },
      {
        'icon': Icons.local_drink,
        'value': '${(water / 1000).toStringAsFixed(1)}L',
        'label': "6edae041a3yFZBIQFoPa".tr,
        'status': water >= 1500
            ? "d56bfdd5ceV4sFl8TeEh".tr
            : "1a5219a8270Xv8Ql42MT".tr,
        'color': water >= 1500 ? Colors.green : Colors.blue,
        'progress': (water / 2000).clamp(0.0, 1.0),
        'target': '2L',
        'image': 'assets/images/social_custom/moments/breakfast.jpg',
      },
      {
        'icon': Icons.psychology,
        'value': '$mood/10',
        'label': "28f5b858880AzxaI1CKL".tr,
        'status': mood >= 7
            ? "00d49acac1AplR6MenqG".tr
            : "91e25f4ddcLkxyTGZPYa".tr,
        'color': mood >= 7 ? Colors.green : Colors.purple,
        'progress': (mood / 10.0).clamp(0.0, 1.0),
        'target': '10',
        'image': 'assets/images/social_custom/moments/fitness1.jpg',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final greeting = _getGreeting();
    final status = _getOverallStatus();
    final statusColor = _getStatusColor();
    final quickStats = _getQuickStats();

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
                  // 可以添加点击后的交互
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
                        margin: const EdgeInsets.only(bottom: 16),
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
                          boxShadow: [
                            BoxShadow(
                              color: statusColor.withValues(alpha: 0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 问候语和状态
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(
                                        alpha: 0.2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '$greeting！',
                                          style: AppTheme.h3.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          status,
                                          style: AppTheme.bodyMedium.copyWith(
                                            color: Colors.white.withValues(
                                              alpha: 0.9,
                                            ),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // 添加背景装饰图片
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
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
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        'assets/images/social_custom/moments/fitness1.jpg',
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withValues(alpha: 0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: const Icon(
                                                  Icons.fitness_center,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              );
                                            },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              // 快速统计 - 增强版
                              Row(
                                children: quickStats.map((stat) {
                                  return Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 0.15,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.white.withValues(
                                            alpha: 0.2,
                                          ),
                                          width: 1,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          // 添加小图片背景
                                          Container(
                                            width: 32,
                                            height: 32,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withValues(alpha: 0.1),
                                                  blurRadius: 4,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.asset(
                                                stat['image'],
                                                fit: BoxFit.cover,
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) {
                                                      return Container(
                                                        decoration: BoxDecoration(
                                                          color: stat['color']
                                                              .withValues(
                                                                alpha: 0.3,
                                                              ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                8,
                                                              ),
                                                        ),
                                                        child: Icon(
                                                          stat['icon'],
                                                          color: Colors.white,
                                                          size: 16,
                                                        ),
                                                      );
                                                    },
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            stat['value'],
                                            style: AppTheme.bodyMedium.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            stat['label'],
                                            style: AppTheme.caption.copyWith(
                                              color: Colors.white.withValues(
                                                alpha: 0.8,
                                              ),
                                              fontSize: 10,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          // 添加进度条
                                          Container(
                                            height: 3,
                                            decoration: BoxDecoration(
                                              color: Colors.white.withValues(
                                                alpha: 0.2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                            ),
                                            child: FractionallySizedBox(
                                              alignment: Alignment.centerLeft,
                                              widthFactor: stat['progress'],
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: stat['color'],
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: stat['color'].withValues(
                                                alpha: 0.8,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              stat['status'],
                                              style: AppTheme.caption.copyWith(
                                                color: Colors.white,
                                                fontSize: 8,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
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
