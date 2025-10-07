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

class MotivationCard extends StatefulWidget {
  final Map<String, dynamic> motivationData;

  const MotivationCard({super.key, required this.motivationData});

  @override
  State<MotivationCard> createState() => _MotivationCardState();
}

class _MotivationCardState extends State<MotivationCard>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _imageController;
  late AnimationController _pulseController;

  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _imageAnimation;
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

    _imageController = AnimationController(
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

    _scaleAnimation = Tween<double>(begin: 0.95, end: 0.92).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    _imageAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _imageController, curve: Curves.easeInOut),
    );

    _pulseAnimation = Tween<double>(begin: 1.02, end: 0.98).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 400));

    if (mounted) {
      _slideController.forward();
      _fadeController.forward();
      _imageController.forward();
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    _scaleController.dispose();
    _imageController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Map<String, dynamic> _getMotivationContent() {
    final steps = widget.motivationData['steps'] ?? 0;
    final sleep = widget.motivationData['sleep'] ?? 0.0;
    final water = widget.motivationData['water'] ?? 0;
    final mood = widget.motivationData['mood'] ?? 0;

    // 根据数据选择不同的激励内容
    if (steps >= 10000 && sleep >= 7.0 && water >= 1500 && mood >= 8) {
      return {
        'title': "a86a589046YqJ8ZvjH42".tr,
        'message': "b5e9cc52500mzOLPrTNS".tr,
        'subtitle': "8fb27a952e6BHoKa1nQx".tr,
        'image': 'assets/images/social_custom/moments/fitness1.jpg',
        'backgroundImage': 'assets/images/social_custom/moments/marathon1.jpg',
        'color': const Color(0xFF4CAF50),
        'icon': Icons.star,
        'achievements': [
          "769958682fGvw64Hetx4".tr,
          "efece192384YnAeZoRFl".tr,
          "f1d9395299xBMNf0IKU3".tr,
          "57c8264b47cJtgzPWwhE".tr,
        ],
        'tips': [
          "640ebdcd92Ncm9ANTPQ8".tr,
          "c3551e00a47fyPNLSfAY".tr,
          "affaa4af99tdmWvmo2ML".tr,
        ],
      };
    } else if (steps >= 8000 || sleep >= 7.0 || water >= 1500) {
      return {
        'title': "7eb3955982s33KBOItRj".tr,
        'message': "ce376df4877V1shbYn09".tr,
        'subtitle':
            "7111e110e2aogfaKYOXH".tr +
            (steps >= 8000 ? "79221e0ad01T36aPuEQw".tr : '') +
            (sleep >= 7.0 ? "77bfe7636acBo0DuJtYH".tr : '') +
            (water >= 1500 ? "04d3fcf0c4XbhvQRCVH5".tr : ''),
        'image': 'assets/images/social_custom/moments/running1.jpg',
        'backgroundImage': 'assets/images/social_custom/moments/gym.jpg',
        'color': const Color(0xFF8BC34A),
        'icon': Icons.thumb_up,
        'achievements': steps >= 8000 ? ["79221e0ad0PQu18uN7oM".tr] : [],
        'tips': ["98c312e2963JDTbBPClL".tr, "1e520775a3ESZKuu48aK".tr],
      };
    } else if (mood >= 7) {
      return {
        'title': "421cc2cda5AfMo8Vnqeh".tr,
        'message': "843aab395dYmHtwq4TTT".tr,
        'subtitle': "93146c23fdNO1OMoDFCT".tr,
        'image': 'assets/images/social_custom/moments/yoga1.jpg',
        'backgroundImage': 'assets/images/social_custom/moments/yoga2.jpg',
        'color': const Color(0xFFFF9800),
        'icon': Icons.sentiment_very_satisfied,
        'achievements': ["57c8264b47A3SlpnCl24".tr],
        'tips': [
          "66651f4e30U24GRI8P65".tr,
          "0fecad448fK4FamqLV6F".tr,
          "3461df601bx8VLkjpAPK".tr,
        ],
      };
    } else {
      return {
        'title': "ba80d0c7f1Wu8EBgvuKK".tr,
        'message': "b9fc8ad4e1OnjxUVqNxG".tr,
        'subtitle': "2522889863AOWw4Pq7ST".tr,
        'image': 'assets/images/social_custom/moments/breakfast.jpg',
        'backgroundImage': 'assets/images/social_custom/moments/yoga3.jpg',
        'color': const Color(0xFF2196F3),
        'icon': Icons.favorite,
        'achievements': [],
        'tips': [
          "75db3e83a9wt3C4EMkAi".tr,
          "ef5755f486IqEc8mSKXF".tr,
          "66651f4e30DKMCTHrXMk".tr,
        ],
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = _getMotivationContent();

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
                              content['color'],
                              content['color'].withValues(alpha: 0.8),
                            ],
                          ),
                          borderRadius: AppTheme.borderRadiusLg,
                          boxShadow: AppTheme.shadowMd,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 180,
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
                                      content['icon'],
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      content['title'],
                                      style: AppTheme.h4.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  // 成就徽章
                                  if (content['achievements'].isNotEmpty)
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
                                        '${content['achievements'].length}' +
                                            "e6adb9d9bdGKN5NaLM73".tr,
                                        style: AppTheme.caption.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // 副标题
                              Text(
                                content['subtitle'],
                                style: AppTheme.bodySmall.copyWith(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // 内容区域
                              Expanded(
                                child: Row(
                                  children: [
                                    // 左侧内容
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // 消息
                                          Expanded(
                                            child: Text(
                                              content['message'],
                                              style: AppTheme.bodyMedium
                                                  .copyWith(
                                                    color: Colors.white
                                                        .withValues(alpha: 0.9),
                                                    fontSize: 12,
                                                    height: 1.3,
                                                  ),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          // 小贴士
                                          if (content['tips'].isNotEmpty)
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.white.withValues(
                                                  alpha: 0.1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: Colors.white
                                                      .withValues(alpha: 0.2),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "3fdcde9363WIBwyOIezI".tr,
                                                    style: AppTheme.caption
                                                        .copyWith(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10,
                                                        ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  ...content['tips']
                                                      .take(2)
                                                      .map(
                                                        (tip) => Text(
                                                          '• $tip',
                                                          style: AppTheme
                                                              .caption
                                                              .copyWith(
                                                                color: Colors
                                                                    .white
                                                                    .withValues(
                                                                      alpha:
                                                                          0.8,
                                                                    ),
                                                                fontSize: 9,
                                                              ),
                                                        ),
                                                      ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    // 右侧图片
                                    Expanded(
                                      flex: 1,
                                      child: AnimatedBuilder(
                                        animation: _imageAnimation,
                                        builder: (context, child) {
                                          return Transform.scale(
                                            scale:
                                                0.8 +
                                                (_imageAnimation.value * 0.2),
                                            child: Container(
                                              height: 120,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withValues(alpha: 0.2),
                                                    blurRadius: 8,
                                                    offset: const Offset(0, 4),
                                                  ),
                                                ],
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: Image.asset(
                                                  content['image'],
                                                  fit: BoxFit.cover,
                                                  errorBuilder:
                                                      (
                                                        context,
                                                        error,
                                                        stackTrace,
                                                      ) {
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
                                                          child: Icon(
                                                            content['icon'],
                                                            color: Colors.white,
                                                            size: 40,
                                                          ),
                                                        );
                                                      },
                                                ),
                                              ),
                                            ),
                                          );
                                        },
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
