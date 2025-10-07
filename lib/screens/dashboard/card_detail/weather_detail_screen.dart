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

class WeatherDetailScreen extends StatefulWidget {
  const WeatherDetailScreen({Key? key}) : super(key: key);

  @override
  State<WeatherDetailScreen> createState() => _WeatherDetailScreenState();
}

class _WeatherDetailScreenState extends State<WeatherDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildCurrentWeather(),
                      const SizedBox(height: 24),
                      _buildWeatherDetails(),
                      const SizedBox(height: 24),
                      _buildHourlyForecast(),
                      const SizedBox(height: 24),
                      _buildWeeklyForecast(),
                      const SizedBox(height: 24),
                      _buildHealthRecommendations(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      backgroundColor: const Color(0xFF74b9ff),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF74b9ff), Color(0xFF0984e3)],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wb_sunny, color: Colors.white, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    "68c77e1551Sd6hVa4fn6".tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "547dfc16596BgWl7y6gU".tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        title: Text(
          "34659ca690N9E2Cu28Pn".tr,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentWeather() {
    return Card(
      elevation: 8,
      shadowColor: const Color(0xFF74b9ff).withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF74b9ff), Color(0xFF0984e3)],
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildWeatherStat("8672864e90EOfT92JFGU".tr, '28°', ''),
                _buildWeatherStat("8b5f2a61b7i5ZaauD8O8".tr, '18°', ''),
                _buildWeatherStat("82213712d6tkhlzC58Cw".tr, '65', '%'),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildWeatherStat("839ea2afbeFUTM7cLO3n".tr, '12', 'km/h'),
                _buildWeatherStat("bc006debecXiLekDQEuE".tr, '1013', 'hPa'),
                _buildWeatherStat("f812f49907g6aftLtjhb".tr, '10', 'km'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherStat(String label, String value, String unit) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (unit.isNotEmpty) ...[
              const SizedBox(width: 2),
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(
                  unit,
                  style: const TextStyle(color: Colors.white70, fontSize: 10),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildWeatherDetails() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: AppTheme.primary, size: 24),
                const SizedBox(width: 12),
                Text(
                  "34659ca690MY1t4OhmkA".tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    "4c72b07a2dr6O2zvKBV6".tr,
                    "c7092c51fd7zqvpp7SC4".tr,
                    Icons.wb_sunny,
                    Colors.orange,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDetailItem(
                    "0afd5f62bc4OlXB9BR4O".tr,
                    "cfea0dce5cAKaxjZTBRq".tr,
                    Icons.air,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDetailItem(
                    "e57fe8be3fjtKuoj1WkH".tr,
                    '10%',
                    Icons.water_drop,
                    Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyForecast() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.schedule, color: AppTheme.primary, size: 24),
                const SizedBox(width: 12),
                Text(
                  "4225c71ee08ZTdrTwQ5F".tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildHourlyItem(
                    "43584f37c1nRIfaEJoo7".tr,
                    '25°',
                    Icons.wb_sunny,
                    true,
                  ),
                  _buildHourlyItem('14:00', '27°', Icons.wb_sunny),
                  _buildHourlyItem('15:00', '26°', Icons.wb_sunny),
                  _buildHourlyItem('16:00', '25°', Icons.wb_sunny),
                  _buildHourlyItem('17:00', '24°', Icons.wb_sunny),
                  _buildHourlyItem('18:00', '23°', Icons.wb_sunny),
                  _buildHourlyItem('19:00', '22°', Icons.nights_stay),
                  _buildHourlyItem('20:00', '21°', Icons.nights_stay),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHourlyItem(
    String time,
    String temp,
    IconData icon, [
    bool isNow = false,
  ]) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isNow
            ? AppTheme.primary.withValues(alpha: 0.1)
            : AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isNow ? AppTheme.primary : AppTheme.divider),
      ),
      child: Column(
        children: [
          Text(
            time,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isNow ? FontWeight.bold : FontWeight.normal,
              color: isNow ? AppTheme.primary : AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Icon(
            icon,
            color: isNow ? AppTheme.primary : AppTheme.textSecondary,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            temp,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isNow ? FontWeight.bold : FontWeight.normal,
              color: isNow ? AppTheme.primary : AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyForecast() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_today, color: AppTheme.primary, size: 24),
                const SizedBox(width: 12),
                Text(
                  "d4e50b183cCQcJjsORjr".tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                _buildDailyItem(
                  "d5f5a7a010SQtAUfgSGo".tr,
                  '25°',
                  '18°',
                  Icons.wb_sunny,
                  true,
                ),
                _buildDailyItem(
                  "b1d841b978Hv4w1A4x89".tr,
                  '26°',
                  '19°',
                  Icons.wb_sunny,
                ),
                _buildDailyItem(
                  "2961168962N9MMVFAtQu".tr,
                  '24°',
                  '17°',
                  Icons.cloud,
                ),
                _buildDailyItem(
                  "e9d3b01a5alTl3KMPtZv".tr,
                  '23°',
                  '16°',
                  Icons.water_drop,
                ),
                _buildDailyItem(
                  "572388f3b0J3XLx9TIYg".tr,
                  '25°',
                  '18°',
                  Icons.wb_sunny,
                ),
                _buildDailyItem(
                  "f9aa11dbb1j9RtrzCBAS".tr,
                  '27°',
                  '20°',
                  Icons.wb_sunny,
                ),
                _buildDailyItem(
                  "ee239f3943wnGc5E5EsB".tr,
                  '26°',
                  '19°',
                  Icons.wb_sunny,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyItem(
    String day,
    String high,
    String low,
    IconData icon, [
    bool isToday = false,
  ]) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppTheme.divider, width: 0.5)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(
              day,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                color: isToday ? AppTheme.primary : AppTheme.textPrimary,
              ),
            ),
          ),
          Icon(
            icon,
            color: isToday ? AppTheme.primary : AppTheme.textSecondary,
            size: 20,
          ),
          const Spacer(),
          Text(
            high,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isToday ? AppTheme.primary : AppTheme.textPrimary,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            low,
            style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthRecommendations() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.favorite, color: AppTheme.warning, size: 24),
                const SizedBox(width: 12),
                Text(
                  "993f81e464or6IrpsKZm".tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildRecommendationItem(
              "d2929913c1Qv31Y2zhae".tr,
              "b5276879f0tuEMfuGBkQ".tr,
              Icons.directions_walk,
              Colors.green,
            ),
            const SizedBox(height: 12),
            _buildRecommendationItem(
              "7d8993fb21joNy1sXP4N".tr,
              "f3511ac020MP501nvV9n".tr,
              Icons.wb_sunny,
              Colors.orange,
            ),
            const SizedBox(height: 12),
            _buildRecommendationItem(
              "68b90e90786QHeTWP9Ml".tr,
              "d4bad9506aFquvB6joE5".tr,
              Icons.checkroom,
              Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationItem(
    String title,
    String content,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.divider),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
