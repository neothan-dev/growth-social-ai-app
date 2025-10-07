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

class AchievementCard extends StatefulWidget {
  final Map<String, dynamic> achievementData;

  const AchievementCard({super.key, required this.achievementData});

  @override
  State<AchievementCard> createState() => _AchievementCardState();
}

class _AchievementCardState extends State<AchievementCard>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _sparkleController;
  late AnimationController _pulseController;

  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _sparkleAnimation;
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

    _sparkleController = AnimationController(
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

    _sparkleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _sparkleController, curve: Curves.easeInOut),
    );

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
      _sparkleController.repeat(reverse: true);
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    _scaleController.dispose();
    _sparkleController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _getAchievements() {
    final steps = widget.achievementData['steps'] ?? 0;
    final sleep = widget.achievementData['sleep'] ?? 0.0;
    final water = widget.achievementData['water'] ?? 0;
    final exercise = widget.achievementData['exercise'] ?? 0;
    final mood = widget.achievementData['mood'] ?? 0;

    List<Map<String, dynamic>> achievements = [];

    if (steps >= 10000) {
      achievements.add({
        'title': "769958682flrtlKcAVS4".tr,
        'description': "91c1cfa148Vnh6YAxTGR".tr,
        'icon': Icons.directions_walk,
        'color': Colors.green,
        'unlocked': true,
        'image': 'assets/images/social_custom/moments/running1.jpg',
        'rarity': 'common',
        'points': 100,
      });
    }

    if (sleep >= 8.0) {
      achievements.add({
        'title': "efece19238EusppxT3se".tr,
        'description': "7ccf43973dR49eXsByxi".tr,
        'icon': Icons.bedtime,
        'color': Colors.blue,
        'unlocked': true,
        'image': 'assets/images/social_custom/moments/yoga1.jpg',
        'rarity': 'common',
        'points': 100,
      });
    }

    if (water >= 2000) {
      achievements.add({
        'title': "f1d9395299DtYnR1sWxv".tr,
        'description': "9f92f6f5aeMg5k9VGV8i".tr,
        'icon': Icons.local_drink,
        'color': Colors.cyan,
        'unlocked': true,
        'image': 'assets/images/social_custom/moments/breakfast.jpg',
        'rarity': 'common',
        'points': 100,
      });
    }

    if (exercise >= 60) {
      achievements.add({
        'title': "c6b0595ecdzCq0dJsgwI".tr,
        'description': "37c3993dccZn1wHeuRZI".tr,
        'icon': Icons.fitness_center,
        'color': Colors.orange,
        'unlocked': true,
        'image': 'assets/images/social_custom/moments/fitness1.jpg',
        'rarity': 'rare',
        'points': 200,
      });
    }

    if (mood >= 9) {
      achievements.add({
        'title': "71711051cfu9eJqplaXz".tr,
        'description': "b2ce48a3a1oOj7RxkXsA".tr,
        'icon': Icons.psychology,
        'color': Colors.purple,
        'unlocked': true,
        'image': 'assets/images/social_custom/moments/yoga2.jpg',
        'rarity': 'rare',
        'points': 200,
      });
    }

    // 添加一些待解锁的成就
    if (achievements.length < 3) {
      achievements.add({
        'title': "c0c4728b0a62Ha3PwAcH".tr,
        'description': "cd85332055Jc4O99TUJh".tr,
        'icon': Icons.directions_run,
        'color': Colors.red,
        'unlocked': false,
        'image': 'assets/images/social_custom/moments/marathon1.jpg',
        'rarity': 'epic',
        'points': 500,
      });
    }

    if (achievements.length < 3) {
      achievements.add({
        'title': "96c7ed554bFI509BY3TG".tr,
        'description': "a9f18c99ec5NV2tCmDR8".tr,
        'icon': Icons.health_and_safety,
        'color': Colors.green,
        'unlocked': false,
        'image': 'assets/images/social_custom/moments/gym.jpg',
        'rarity': 'legendary',
        'points': 1000,
      });
    }

    return achievements.take(3).toList();
  }

  Color _getRarityColor(String rarity) {
    switch (rarity) {
      case 'common':
        return Colors.green;
      case 'rare':
        return Colors.blue;
      case 'epic':
        return Colors.purple;
      case 'legendary':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _getRarityText(String rarity) {
    switch (rarity) {
      case 'common':
        return "de907d10dfpwAdxspJKw".tr;
      case 'rare':
        return "050c11f35aPdCd8xhm6R".tr;
      case 'epic':
        return "a47ff1babcnRl5MkeDE6".tr;
      case 'legendary':
        return "5575627d89HGZMeEsPFy".tr;
      default:
        return "4d8c1c5b42MQL3A0bKhS".tr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final achievements = _getAchievements();
    final hasUnlockedAchievements = achievements.any((a) => a['unlocked']);

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
                            colors: hasUnlockedAchievements
                                ? const [Color(0xFFFFD700), Color(0xFFFFA500)]
                                : const [
                                    Color.fromARGB(255, 240, 213, 10),
                                    Color.fromARGB(255, 169, 133, 1),
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
                                  AnimatedBuilder(
                                    animation: _sparkleAnimation,
                                    builder: (context, child) {
                                      return Transform.scale(
                                        scale: hasUnlockedAchievements
                                            ? 1.0 +
                                                  (_sparkleAnimation.value *
                                                      0.1)
                                            : 1.0,
                                        child: Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withValues(
                                              alpha: 0.2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.emoji_events,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      "82a68c627eLZcWXvy9NA".tr,
                                      style: AppTheme.h4.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  if (hasUnlockedAchievements)
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
                                        '${achievements.where((a) => a['unlocked']).length}/${achievements.length}',
                                        style: AppTheme.caption.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              // 成就列表 - 增强版
                              Expanded(
                                child: Row(
                                  children: achievements.map((achievement) {
                                    return Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 5,
                                        ),
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(
                                            alpha: 0.15,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          border: Border.all(
                                            color: achievement['unlocked']
                                                ? achievement['color']
                                                      .withValues(alpha: 0.5)
                                                : Colors.white.withValues(
                                                    alpha: 0.2,
                                                  ),
                                            width: 1,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // 成就图片
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
                                                  achievement['image'],
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            achievement['unlocked']
                                                            ? achievement['color']
                                                                  .withValues(
                                                                    alpha: 0.3,
                                                                  )
                                                            : Colors.grey
                                                                  .withValues(
                                                                    alpha: 0.3,
                                                                  ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              8,
                                                            ),
                                                      ),
                                                      child: Icon(
                                                        achievement['icon'],
                                                        color: Colors.white,
                                                        size: 16,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              achievement['title'],
                                              style: AppTheme.caption.copyWith(
                                                color: achievement['unlocked']
                                                    ? Colors.white
                                                    : Colors.white.withValues(
                                                        alpha: 0.7,
                                                      ),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 9,
                                              ),
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 2),
                                            // 稀有度标签
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 4,
                                                    vertical: 1,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: _getRarityColor(
                                                  achievement['rarity'],
                                                ).withValues(alpha: 0.8),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                _getRarityText(
                                                  achievement['rarity'],
                                                ),
                                                style: AppTheme.caption
                                                    .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 7,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            // 积分
                                            Text(
                                              '${achievement['points']}' +
                                                  "b6a993c256EVY1wNhu3j".tr,
                                              style: AppTheme.caption.copyWith(
                                                color: achievement['unlocked']
                                                    ? Colors.white.withValues(
                                                        alpha: 0.8,
                                                      )
                                                    : Colors.white.withValues(
                                                        alpha: 0.5,
                                                      ),
                                                fontSize: 8,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
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
