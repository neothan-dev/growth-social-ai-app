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
import '../../../localization/app_localizations.dart';
import '../../../utils/haptic_feedback_helper.dart';

class HorizontalScrollCards extends StatefulWidget {
  const HorizontalScrollCards({super.key});

  @override
  State<HorizontalScrollCards> createState() => _HorizontalScrollCardsState();
}

class _HorizontalScrollCardsState extends State<HorizontalScrollCards>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _pulseController;
  late AnimationController _scaleController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _scaleAnimation;

  late PageController _pageController;
  int _currentPage = 0;
  bool _isScrolling = false;

  final List<ScrollCardData> _originalCards = [
    ScrollCardData(
      title: "476f594017eWppaVaLNK".tr,
      subtitle: "0c585c8258jcz0HJKDR7".tr,
      value: '45',
      unit: "bd957bc4970iL0S9bIZB".tr,
      icon: Icons.fitness_center,
      color: const Color(0xFF4CAF50),
      gradient: const [Color(0xFF4CAF50), Color(0xFF81C784)],
      trend: 0.8,
      trendData: [30, 35, 40, 38, 45],
    ),
    ScrollCardData(
      title: "9be0ae5dfaGJLRdEtrQp".tr,
      subtitle: "9de6cb318da2rIMJ5wSf".tr,
      value: '320',
      unit: 'kcal',
      icon: Icons.local_fire_department,
      color: const Color(0xFFFF9800),
      gradient: const [Color(0xFFFF9800), Color(0xFFFFB74D)],
      trend: 0.6,
      trendData: [280, 290, 310, 295, 320],
    ),
    ScrollCardData(
      title: "80257497b99JPBcVpcrd".tr,
      subtitle: "03601ee046eD5tSw3C29".tr,
      value: '72',
      unit: 'bpm',
      icon: Icons.favorite,
      color: const Color(0xFFE91E63),
      gradient: const [Color(0xFFE91E63), Color(0xFFF48FB1)],
      trend: -0.2,
      trendData: [75, 73, 74, 71, 72],
    ),
    ScrollCardData(
      title: "7fe72e5d97SrKLnf4mvd".tr,
      subtitle: "af9cd80778mbwvB8r71H".tr,
      value: '7.5',
      unit: "3b6fefc50fEyjGWRwKhz".tr,
      icon: Icons.bedtime,
      color: const Color(0xFF9C27B0),
      gradient: const [Color(0xFF9C27B0), Color(0xFFCE93D8)],
      trend: 0.4,
      trendData: [6.5, 7.0, 6.8, 7.2, 7.5],
    ),
    ScrollCardData(
      title: "6b4a3ab9a0uvIeYRdCIm".tr,
      subtitle: "c4ef272a9adwv7Wy1cS4".tr,
      value: '1.8',
      unit: 'L',
      icon: Icons.water_drop,
      color: const Color(0xFF2196F3),
      gradient: const [Color(0xFF2196F3), Color(0xFF90CAF9)],
      trend: 0.9,
      trendData: [1.2, 1.5, 1.6, 1.7, 1.8],
    ),
  ];

  late List<ScrollCardData> _cards;

  @override
  void initState() {
    super.initState();
    _cards = [..._originalCards, ..._originalCards, ..._originalCards];

    _scrollController = ScrollController();
    _pageController = PageController(
      viewportFraction: 0.7,
      initialPage: _originalCards.length,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _pulseAnimation = Tween<double>(begin: 1.02, end: 0.98).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    // 启动动画
    _startAnimations();

    _pageController.addListener(() {
      if (!_isScrolling) {
        final page = _pageController.page?.round() ?? _originalCards.length;
        final actualPage = page % _originalCards.length;
        setState(() {
          _currentPage = actualPage;
        });
      }
    });
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 200));

    if (mounted) {
      _slideController.forward();
      _fadeController.forward();
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    _pulseController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _handlePageChange(int page) {
    setState(() {
      _isScrolling = true;
    });

    if (page < _originalCards.length) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          _pageController.jumpToPage(page + _originalCards.length);
        }
      });
    } else if (page >= _originalCards.length * 2) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          _pageController.jumpToPage(page - _originalCards.length);
        }
      });
    }

    final actualPage = page % _originalCards.length;
    setState(() {
      _currentPage = actualPage;
      _isScrolling = false;
    });
  }

  void _onCardTap(BuildContext context, ScrollCardData card) {
    // 为卡片点击提供震动反馈
    HapticFeedbackHelper.buttonTap();
    // 导航到详细信息页面
    Navigator.of(context).pushNamed(
      '/scroll_card_detail_screen',
      arguments: {
        'title': card.title,
        'subtitle': card.subtitle,
        'value': card.value,
        'unit': card.unit,
        'icon': card.icon,
        'color': card.color,
        'gradient': card.gradient,
        'trend': card.trend,
        'trendData': card.trendData,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                onTapDown: (_) => _scaleController.forward(),
                onTapUp: (_) => _scaleController.reverse(),
                onTapCancel: () => _scaleController.reverse(),
                child: AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Container(
                        height: 160,
                        child: Column(
                          children: [
                            // 现代化滑动窗口容器
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ), // 恢复容器边距
                                child: Stack(
                                  children: [
                                    // 背景发光效果
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.white.withOpacity(0.1),
                                            Colors.white.withOpacity(0.05),
                                            Colors.transparent,
                                          ],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.white.withOpacity(
                                              0.1,
                                            ),
                                            blurRadius: 30,
                                            spreadRadius: 2,
                                            offset: const Offset(0, 0),
                                          ),
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.2,
                                            ),
                                            blurRadius: 40,
                                            spreadRadius: -5,
                                            offset: const Offset(0, 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // 主边框容器
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.3),
                                          width: 1,
                                        ),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.white.withOpacity(0.2),
                                            Colors.white.withOpacity(0.1),
                                            Colors.white.withOpacity(0.05),
                                            Colors.transparent,
                                          ],
                                          stops: const [0.0, 0.3, 0.7, 1.0],
                                        ),
                                      ),
                                    ),
                                    // 内层高光边框
                                    Container(
                                      margin: const EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(23),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.4),
                                          width: 0.5,
                                        ),
                                      ),
                                    ),
                                    // 装饰性光点
                                    Positioned(
                                      top: 10,
                                      left: 20,
                                      child: Container(
                                        width: 4,
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.6),
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.white.withOpacity(
                                                0.3,
                                              ),
                                              blurRadius: 8,
                                              spreadRadius: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 15,
                                      right: 25,
                                      child: Container(
                                        width: 3,
                                        height: 3,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.4),
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.white.withOpacity(
                                                0.2,
                                              ),
                                              blurRadius: 6,
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 12,
                                      left: 30,
                                      child: Container(
                                        width: 2,
                                        height: 2,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.5),
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.white.withOpacity(
                                                0.2,
                                              ),
                                              blurRadius: 4,
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // 内容区域
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(24),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.white.withOpacity(0.05),
                                              Colors.transparent,
                                              Colors.black.withOpacity(0.1),
                                            ],
                                          ),
                                        ),
                                        child: PageView.builder(
                                          controller: _pageController,
                                          itemCount: _cards.length,
                                          onPageChanged: _handlePageChange,
                                          itemBuilder: (context, index) {
                                            final card = _cards[index];
                                            // 计算相对于中间组的距离
                                            final middleIndex =
                                                index % _originalCards.length;
                                            final isCurrentPage =
                                                middleIndex == _currentPage;
                                            final distance =
                                                (middleIndex - _currentPage)
                                                    .abs();

                                            return AnimatedContainer(
                                              duration: const Duration(
                                                milliseconds: 300,
                                              ),
                                              margin: EdgeInsets.symmetric(
                                                horizontal: distance == 0
                                                    ? 0
                                                    : 6, // 调整边距以平衡前后距离
                                                vertical: distance == 0 ? 0 : 6,
                                              ),
                                              transform: Matrix4.identity()
                                                ..setEntry(3, 2, 0.001)
                                                ..rotateY(
                                                  distance == 0
                                                      ? 0
                                                      : (distance * 0.08),
                                                ) // 减少旋转角度
                                                ..scale(
                                                  distance == 0
                                                      ? 1.0
                                                      : (1.0 -
                                                            distance *
                                                                0.03), // 减少缩放差异
                                                ),
                                              child: _buildScrollCard(
                                                context,
                                                card,
                                                isCurrentPage,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // 现代化页面指示器
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                _originalCards.length,
                                (index) => AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  width: index == _currentPage ? 24 : 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    gradient: index == _currentPage
                                        ? LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Colors.white.withOpacity(0.9),
                                              Colors.white.withOpacity(0.7),
                                              Colors.white.withOpacity(0.9),
                                            ],
                                          )
                                        : null,
                                    color: index == _currentPage
                                        ? null
                                        : Colors.white.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(3),
                                    boxShadow: index == _currentPage
                                        ? [
                                            BoxShadow(
                                              color: Colors.white.withOpacity(
                                                0.4,
                                              ),
                                              blurRadius: 8,
                                              spreadRadius: 1,
                                            ),
                                          ]
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                          ],
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

  Widget _buildScrollCard(
    BuildContext context,
    ScrollCardData card,
    bool isCurrentPage,
  ) {
    return GestureDetector(
      onTap: () => _onCardTap(context, card),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: card.gradient,
          ),
          borderRadius: AppTheme.borderRadiusLg,
          boxShadow: [
            BoxShadow(
              color: card.color.withOpacity(0.3),
              blurRadius: isCurrentPage ? 15 : 8,
              offset: Offset(0, isCurrentPage ? 8 : 4),
            ),
          ],
        ),
        child: Container(
          padding: AppTheme.paddingMd,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(card.icon, color: Colors.white, size: 16),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      card.title,
                      style: AppTheme.bodyMedium.copyWith(
                        color: Colors.white.withOpacity(0.95),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      card.value,
                      style: AppTheme.h2.copyWith(
                        color: Colors.white.withOpacity(0.95),
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      card.unit,
                      style: AppTheme.bodySmall.copyWith(
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                card.subtitle,
                style: AppTheme.caption.copyWith(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScrollCardData {
  final String title;
  final String subtitle;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;
  final List<Color> gradient;
  final double trend;
  final List<double> trendData;

  ScrollCardData({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
    required this.gradient,
    required this.trend,
    required this.trendData,
  });
}
