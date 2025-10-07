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

class WeatherCard extends StatefulWidget {
  final DashboardCardModel model;

  WeatherCard({Key? key})
    : model = DashboardCardModel(
        type: DashboardCardType.weather,
        title: "e2d89f9d30jTYpWdc6Kw".tr,
        width: 2,
        height: 4,
        data: {'temp': '25°C', 'desc': "6379ede5c2Mh5BJh9ZjM".tr},
      ),
      super(key: key);

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late AnimationController _iconController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _iconAnimation;

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
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _iconController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _iconAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _iconController, curve: Curves.elasticOut),
    );

    _startAnimations();
  }

  void _startAnimations() async {
    if (mounted) {
      _slideController.forward();
      _fadeController.forward();
      _iconController.forward();

      final desc = widget.model.data['desc'] ?? '--';
      final isGoodWeather =
          desc == "6379ede5c25ER4rxZw11".tr ||
          desc == "30c379777enGDLpq2IiA".tr;
      if (isGoodWeather) {
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
    _iconController.dispose();
    super.dispose();
  }

  IconData _getWeatherIcon(String desc) {
    switch (desc) {
      case '晴':
        return Icons.wb_sunny;
      case '多云':
        return Icons.cloud;
      case '雨':
        return Icons.water_drop;
      case '雪':
        return Icons.ac_unit;
      default:
        return Icons.cloud;
    }
  }

  Color _getWeatherGradient(String desc) {
    switch (desc) {
      case '晴':
        return const Color(0xFFFFD700);
      case '多云':
        return const Color(0xFF87CEEB);
      case '雨':
        return const Color(0xFF4682B4);
      case '雪':
        return const Color(0xFFF0F8FF);
      default:
        return const Color(0xFF87CEEB);
    }
  }

  void _onTap(BuildContext context) {
    // 为卡片点击提供震动反馈
    HapticFeedbackHelper.buttonTap();
    Navigator.of(context).pushNamed('/weather_detail_screen');
  }

  @override
  Widget build(BuildContext context) {
    final temp = widget.model.data['temp'] ?? '--';
    final desc = widget.model.data['desc'] ?? '--';
    final weatherIcon = _getWeatherIcon(desc);
    final gradientColor = _getWeatherGradient(desc);
    final isGoodWeather =
        desc == "6379ede5c20ptLb0YFUd".tr || desc == "30c379777e4nihbelYFx".tr;

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: isGoodWeather ? _pulseAnimation.value : 1.0,
              child: GestureDetector(
                onTap: () => _onTap(context),
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
                              gradientColor,
                              gradientColor.withValues(alpha: 0.9),
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
                                    child: AnimatedBuilder(
                                      animation: _iconAnimation,
                                      builder: (context, child) {
                                        return Transform.scale(
                                          scale: _iconAnimation.value,
                                          child: Icon(
                                            weatherIcon,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        );
                                      },
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
                              const SizedBox(height: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      temp,
                                      style: AppTheme.h2.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withValues(
                                              alpha: 0.2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Text(
                                            desc,
                                            style: AppTheme.bodyMedium.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                        // 天气预报图标行
                                        Expanded(
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 60),
                                              _buildWeatherForecastItem(
                                                "14:00",
                                                "27°",
                                                Icons.wb_sunny,
                                                Colors.white,
                                              ),
                                              const SizedBox(width: 30),
                                              _buildWeatherForecastItem(
                                                "15:00",
                                                "26°",
                                                Icons.wb_sunny,
                                                Colors.white,
                                              ),
                                              const SizedBox(width: 30),
                                              _buildWeatherForecastItem(
                                                "16:00",
                                                "25°",
                                                Icons.wb_sunny,
                                                Colors.white,
                                              ),
                                              const SizedBox(width: 30),
                                              _buildWeatherForecastItem(
                                                "17:00",
                                                "24°",
                                                Icons.wb_sunny,
                                                Colors.white,
                                              ),
                                              const SizedBox(width: 30),
                                              _buildWeatherForecastItem(
                                                "18:00",
                                                "23°",
                                                Icons.nights_stay,
                                                Colors.white,
                                              ),
                                            ],
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

  Widget _buildWeatherForecastItem(
    String time,
    String temp,
    IconData icon,
    Color color,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(icon, color: color, size: 14),
        ),
        const SizedBox(height: 1),
        Text(
          time,
          style: AppTheme.caption.copyWith(
            color: color,
            fontSize: 7,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          temp,
          style: AppTheme.caption.copyWith(
            color: color,
            fontSize: 7,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
