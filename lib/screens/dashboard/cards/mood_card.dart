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

class MoodCard extends StatefulWidget {
  final DashboardCardModel model;

  MoodCard({Key? key})
    : model = DashboardCardModel(
        type: DashboardCardType.mood,
        title: "6b68f6aa18uuS1D3kW5w".tr,
        width: 2,
        height: 2,
        data: {'mood': '开心', 'score': 8, 'note': '今天心情不错'},
      ),
      super(key: key);

  @override
  State<MoodCard> createState() => _MoodCardState();
}

class _MoodCardState extends State<MoodCard> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late AnimationController _scoreController;
  late AnimationController _emojiController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<int> _scoreAnimation;
  late Animation<double> _emojiAnimation;

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

    _emojiController = AnimationController(
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

    final score = widget.model.data['score'] ?? 0;
    _scoreAnimation = IntTween(begin: 0, end: score).animate(
      CurvedAnimation(parent: _scoreController, curve: Curves.easeOutCubic),
    );

    _emojiAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _emojiController, curve: Curves.elasticOut),
    );

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 800));

    if (mounted) {
      _slideController.forward();
      _fadeController.forward();
      _scoreController.forward();
      _emojiController.forward();

      final score = widget.model.data['score'] ?? 0;
      final isGoodMood = score >= 7;

      if (isGoodMood) {
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
    _emojiController.dispose();
    super.dispose();
  }

  String _getMoodEmoji(String mood) {
    if (mood == "6e067999e2bGsR6JC4rC".tr) {
      return '😊';
    } else if (mood == "4eeae343b2msHIYXEvab".tr) {
      return '🤩';
    } else if (mood == "648e6fb8bckyf7TXu64y".tr) {
      return '😌';
    } else if (mood == "91e25f4ddcvD3TMp6jI4".tr) {
      return '😐';
    } else if (mood == "3bcd542b08Q3cLPjTybV".tr) {
      return '😴';
    } else if (mood == "bff0375affmRzvKv37Og".tr) {
      return '😰';
    } else if (mood == "668ce09171XPYzHeDhE6".tr) {
      return '😢';
    } else if (mood == "3b637c63deRwWEWWKR9A".tr) {
      return '😠';
    } else {
      return '😊';
    }
  }

  Color _getMoodColor(String mood, int score) {
    if (score >= 8) return const Color(0xFF4CAF50);
    if (score >= 6) return const Color(0xFFFF9800);
    if (score >= 4) return const Color(0xFFFFC107);
    return const Color(0xFFF44336);
  }

  String _getMoodStatus(int score) {
    if (score >= 9) return "cee28314341B5LoePNam".tr;
    if (score >= 7) return "38e5b024a6ZV6Q23rjVA".tr;
    if (score >= 5) return "91e25f4ddcVg9AnOAqHT".tr;
    if (score >= 3) return "895dcef3f1l5KlNzI96U".tr;
    return "00856ed4d3nlSPYh0LTg".tr;
  }

  @override
  Widget build(BuildContext context) {
    final mood = widget.model.data['mood'] ?? "6e067999e27D4wyr6hS2".tr;
    final score = widget.model.data['score'] ?? 0;
    final note = widget.model.data['note'] ?? '';
    final emoji = _getMoodEmoji(mood);
    final moodColor = _getMoodColor(mood, score);
    final status = _getMoodStatus(score);
    final isGoodMood = score >= 7;

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: isGoodMood ? _pulseAnimation.value : 1.0,
              child: GestureDetector(
                onTap: () {
                  // 为卡片点击提供震动反馈
                  HapticFeedbackHelper.buttonTap();
                  Navigator.of(context).pushNamed('/mood_detail_screen');
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
                              moodColor,
                              moodColor.withValues(alpha: 0.8),
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
                                      Icons.psychology,
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
                                    Row(
                                      children: [
                                        AnimatedBuilder(
                                          animation: _emojiAnimation,
                                          builder: (context, child) {
                                            return Transform.scale(
                                              scale: _emojiAnimation.value,
                                              child: Text(
                                                emoji,
                                                style: const TextStyle(
                                                  fontSize: 30,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(width: 12),
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
                                                    animation: _scoreAnimation,
                                                    builder: (context, child) {
                                                      return Text(
                                                        _scoreAnimation.value
                                                            .toString(),
                                                        style: AppTheme.h2
                                                            .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 28,
                                                            ),
                                                      );
                                                    },
                                                  ),
                                                  const SizedBox(width: 2),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                          bottom: 4,
                                                        ),
                                                    child: Text(
                                                      '/10',
                                                      style: AppTheme.bodyMedium
                                                          .copyWith(
                                                            color: Colors.white
                                                                .withValues(
                                                                  alpha: 0.8,
                                                                ),
                                                            fontSize: 14,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 2),
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
                                        if (note.isNotEmpty)
                                          Expanded(
                                            child: Text(
                                              note,
                                              style: AppTheme.caption.copyWith(
                                                color: Colors.white.withValues(
                                                  alpha: 0.7,
                                                ),
                                                fontSize: 10,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
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
