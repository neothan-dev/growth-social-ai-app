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

class CommunityActivityCard extends StatefulWidget {
  const CommunityActivityCard({super.key});

  @override
  State<CommunityActivityCard> createState() => _CommunityActivityCardState();
}

class _CommunityActivityCardState extends State<CommunityActivityCard>
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

  int _currentIndex = 0;

  final List<Map<String, dynamic>> _activities = [
    {
      'title': "22bfa97f3f0ZUamgksLX".tr,
      'description': "43f591791dx5JfKe3mcd".tr,
      'image': 'assets/images/social_custom/events/online_yoga.jpg',
      'participants': 156,
      'time': "70facc0479h7OktYim5g".tr,
      'color': const Color(0xFF9C27B0),
    },
    {
      'title': "344e089a50dAFC6iahQB".tr,
      'description': "86891e6e17gvYaZvyt9f".tr,
      'image': 'assets/images/social_custom/events/healthy_lecture.jpg',
      'participants': 89,
      'time': "a56bb6d0b2Jlim9TK1w4".tr,
      'color': const Color(0xFF4CAF50),
    },
    {
      'title': "68920586aetO1U01sQx6".tr,
      'description': "c776b34c21uHCImCg9Vs".tr,
      'image': 'assets/images/social_custom/events/marathon.jpg',
      'participants': 234,
      'time': "fa5f2ecedfSHVi6dDf13".tr,
      'color': const Color(0xFFFF9800),
    },
    {
      'title': "97120aeae9bbX3a1j0H2".tr,
      'description': "50a1c9fefaQ1amgRTZR5".tr,
      'image': 'assets/images/social_custom/events/fitness_challenge.jpg',
      'participants': 445,
      'time': "6a0ee6281bTwu3DnrT0N".tr,
      'color': const Color(0xFF2196F3),
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

    _imageAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _imageController, curve: Curves.easeInOut),
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

  void _nextActivity() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _activities.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final activity = _activities[_currentIndex];

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
                  _nextActivity();
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
                              activity['color'],
                              activity['color'].withValues(alpha: 0.8),
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
                                    child: const Icon(
                                      Icons.people,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      "d9b9dda6aaWd5yf9QKvm".tr,
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
                                      '${_currentIndex + 1}/${_activities.length}',
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
                                      child: AnimatedBuilder(
                                        animation: _imageAnimation,
                                        builder: (context, child) {
                                          return Transform.scale(
                                            scale:
                                                0.9 +
                                                (_imageAnimation.value * 0.1),
                                            child: Container(
                                              height: 100,
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
                                                  activity['image'],
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
                                                          child: const Icon(
                                                            Icons.image,
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
                                    const SizedBox(width: 12),
                                    // 右侧信息
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            activity['title'],
                                            style: AppTheme.h4.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            activity['description'],
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
                                          const Spacer(),
                                          // 底部信息
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.people_outline,
                                                color: Colors.white.withValues(
                                                  alpha: 0.8,
                                                ),
                                                size: 14,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                '${activity['participants']}' +
                                                    "c182c04c3fdbJQTYCvl0".tr,
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
                                              Icon(
                                                Icons.access_time,
                                                color: Colors.white.withValues(
                                                  alpha: 0.8,
                                                ),
                                                size: 14,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                activity['time'],
                                                style: AppTheme.caption
                                                    .copyWith(
                                                      color: Colors.white
                                                          .withValues(
                                                            alpha: 0.8,
                                                          ),
                                                      fontSize: 10,
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
                              const SizedBox(height: 8),
                              // 底部指示器
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  _activities.length,
                                  (index) => Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 2,
                                    ),
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: index == _currentIndex
                                          ? Colors.white
                                          : Colors.white.withValues(alpha: 0.3),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
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
