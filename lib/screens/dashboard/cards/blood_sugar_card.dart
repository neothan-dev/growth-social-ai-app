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
import 'dart:math';
import '../../../utils/haptic_feedback_helper.dart';

class BloodSugarCard extends StatefulWidget {
  final DashboardCardModel model;

  BloodSugarCard({Key? key})
    : model = DashboardCardModel(
        type: DashboardCardType.bloodSugar,
        title: "2b3f634878Gs4KVcKPwU".tr,
        width: 2,
        height: 2,
        data: {
          'glucose': 5.8,
          'unit': 'mmol/L',
          'time': "571f6ee9d8O7OfjWubAO".tr,
        },
      ),
      super(key: key);

  @override
  State<BloodSugarCard> createState() => _BloodSugarCardState();
}

class _BloodSugarCardState extends State<BloodSugarCard>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late AnimationController _glucoseController;
  late AnimationController _waveController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _glucoseAnimation;
  late Animation<double> _waveAnimation;

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

    _glucoseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _waveController = AnimationController(
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

    final glucose = widget.model.data['glucose'] ?? 0.0;
    _glucoseAnimation = Tween<double>(begin: 0.0, end: glucose).animate(
      CurvedAnimation(parent: _glucoseController, curve: Curves.easeOutCubic),
    );

    _waveAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _waveController, curve: Curves.easeInOut),
    );

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      _slideController.forward();
      _fadeController.forward();
      _glucoseController.forward();
      _waveController.repeat();

      final glucose = widget.model.data['glucose'] ?? 0.0;
      final isNormal = glucose >= 3.9 && glucose <= 6.1;

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
    _glucoseController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  String _getBloodSugarStatus(double glucose) {
    if (glucose < 3.9) return "fd9b72d8dePOpQRc1vmG".tr;
    if (glucose <= 6.1) return "296de0e31fowHVY6ZEzr".tr;
    if (glucose <= 7.8) return "cde6311d91ti7iwo3hra".tr;
    return "8deeeb5ba8ZbwrF8MtU6".tr;
  }

  Color _getStatusColor(String status) {
    if (status == "296de0e31fF8Jsc6O5wY".tr)
      return const Color(0xFF4CAF50);
    else if (status == "cde6311d91Ye2jKG7Lzs".tr)
      return const Color(0xFFFF9800);
    else if (status == "fd9b72d8deuuLtjku6Fr".tr)
      return const Color(0xFF2196F3);
    else
      return const Color(0xFFF44336);
  }

  @override
  Widget build(BuildContext context) {
    final glucose = widget.model.data['glucose'] ?? 0.0;
    final unit = widget.model.data['unit'] ?? 'mmol/L';
    final time = widget.model.data['time'] ?? '';
    final status = _getBloodSugarStatus(glucose);
    final statusColor = _getStatusColor(status);
    final isNormal = status == "296de0e31f0ffzGDtPQQ".tr;

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
                  Navigator.of(context).pushNamed('/blood_sugar_detail_screen');
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
                                      Icons.water_drop,
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
                                        fontSize: 14,
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
                                          animation: _glucoseAnimation,
                                          builder: (context, child) {
                                            return Text(
                                              _glucoseAnimation.value
                                                  .toStringAsFixed(1),
                                              style: AppTheme.h2.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(width: 8),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 4,
                                          ),
                                          child: Text(
                                            unit,
                                            style: AppTheme.bodyMedium.copyWith(
                                              color: Colors.white.withValues(
                                                alpha: 0.8,
                                              ),
                                              fontSize: 10,
                                            ),
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
                                        if (time.isNotEmpty)
                                          Text(
                                            time,
                                            style: AppTheme.caption.copyWith(
                                              color: Colors.white.withValues(
                                                alpha: 0.7,
                                              ),
                                              fontSize: 10,
                                            ),
                                          ),
                                      ],
                                    ),
                                    AnimatedBuilder(
                                      animation: _waveAnimation,
                                      builder: (context, child) {
                                        return Container(
                                          height: 20,
                                          child: CustomPaint(
                                            painter: WavePainter(
                                              waveAnimation:
                                                  _waveAnimation.value,
                                              color: Colors.white.withValues(
                                                alpha: 0.3,
                                              ),
                                            ),
                                            size: Size.infinite,
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

class WavePainter extends CustomPainter {
  final double waveAnimation;
  final Color color;

  WavePainter({required this.waveAnimation, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final y = size.height * 0.5;

    path.moveTo(0, y);

    for (double x = 0; x <= size.width; x++) {
      final waveY =
          y + sin((x / size.width * 4 * pi) + (waveAnimation * 2 * pi)) * 8;
      path.lineTo(x, waveY);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) {
    return oldDelegate.waveAnimation != waveAnimation ||
        oldDelegate.color != color;
  }
}
