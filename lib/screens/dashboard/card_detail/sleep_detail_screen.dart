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

class SleepDetailScreen extends StatefulWidget {
  const SleepDetailScreen({Key? key}) : super(key: key);

  @override
  State<SleepDetailScreen> createState() => _SleepDetailScreenState();
}

class _SleepDetailScreenState extends State<SleepDetailScreen>
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
                      _buildSleepOverview(),
                      const SizedBox(height: 24),
                      _buildSleepQuality(),
                      const SizedBox(height: 24),
                      _buildSleepPhases(),
                      const SizedBox(height: 24),
                      _buildWeeklySleep(),
                      const SizedBox(height: 24),
                      _buildSleepTips(),
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
      backgroundColor: const Color(0xFF667eea),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF667eea), Color(0xFF764ba2)],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.bedtime, color: Colors.white, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    "af9cd80778N6kdje6Lx9".tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '7.5 h',
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
          "0a64e67cb81APF8MKJVK".tr,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildSleepOverview() {
    return Card(
      elevation: 8,
      shadowColor: const Color(0xFF667eea).withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSleepStat("a4fcdb5219uhxUGQBg70".tr, '23:30', ''),
                _buildSleepStat("c7860b643bF6Ny2nfX5a".tr, '07:00', ''),
                _buildSleepStat("98439c55d9Ls5rD943Ta".tr, '7.5', '小时'),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSleepStat("ee3d90ef1f7phnw9phlG".tr, '2.1', '小时'),
                _buildSleepStat("7073c4c574aXKx9KM3OJ".tr, '4.2', '小时'),
                _buildSleepStat("ca1a9546e2HjsD9eO1qQ".tr, '1.2', '小时'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSleepStat(String label, String value, String unit) {
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

  Widget _buildSleepQuality() {
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
                Icon(Icons.analytics, color: AppTheme.primary, size: 24),
                const SizedBox(width: 12),
                Text(
                  "7fe72e5d97GRfWl0z7zO".tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildQualityItem(
                    "601dcbbdb4Sg7BT5ti7t".tr,
                    '85',
                    "bd957bc497LvexOtnLUq".tr,
                    Icons.star,
                    Colors.amber,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildQualityItem(
                    "2810c1ae78X48jEwL6J3".tr,
                    '92',
                    '%',
                    Icons.trending_up,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildQualityItem(
                    "413057c085B9d52Os7HG".tr,
                    '78',
                    '%',
                    Icons.schedule,
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

  Widget _buildQualityItem(
    String label,
    String value,
    String unit,
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
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            unit,
            style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
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

  Widget _buildSleepPhases() {
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
                Icon(Icons.pie_chart, color: AppTheme.primary, size: 24),
                const SizedBox(width: 12),
                Text(
                  "cbec10a8d8p6PEbQnRHq".tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildPhaseItem(
                    "ee3d90ef1fW9XpKqpH4I".tr,
                    "c8a8960a9eoLZ0JIpq7O".tr,
                    '28%',
                    Colors.indigo,
                    "3eab5a11d4DnE8EzY88J".tr,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildPhaseItem(
                    "7073c4c574FytIWlgXIp".tr,
                    "b51cd6c166puWh29Ai27".tr,
                    '56%',
                    Colors.blue,
                    "6c1bece990GPlnFC4J2r".tr,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildPhaseItem(
                    'REM',
                    "864c8d8dffoBQDoAlaUp".tr,
                    '16%',
                    Colors.purple,
                    "a3ed2c2250y2XRWkD9vo".tr,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhaseItem(
    String name,
    String duration,
    String percentage,
    Color color,
    String description,
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
          Text(
            name,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            duration,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            percentage,
            style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: 10, color: AppTheme.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklySleep() {
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
                Icon(Icons.show_chart, color: AppTheme.primary, size: 24),
                const SizedBox(width: 12),
                Text(
                  "11e2df5bc45YQyARnT4c".tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildSleepBar("51a75f4634GVqgCjIp6c".tr, 0.7, '7.0'),
                  _buildSleepBar("084b42f6e9UFDiTWodsy".tr, 0.8, '8.0'),
                  _buildSleepBar("a4c3313debt7JiOb8txz".tr, 0.6, '6.5'),
                  _buildSleepBar("754a9d5828HUxYI3KvpV".tr, 0.9, '9.2'),
                  _buildSleepBar("c9b87f516avk3qtQ5AFN".tr, 0.75, '7.8'),
                  _buildSleepBar("de07b538381F8xmIM6f3".tr, 0.8, '8.5'),
                  _buildSleepBar(
                    "85217f7affTSXMnirnHp".tr,
                    0.75,
                    '7.5',
                    isToday: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSleepBar(
    String day,
    double height,
    String hours, {
    bool isToday = false,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          hours,
          style: TextStyle(
            fontSize: 10,
            color: AppTheme.textSecondary,
            fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 30,
          height: 120 * height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: isToday
                  ? [const Color(0xFF667eea), const Color(0xFF764ba2)]
                  : [
                      const Color(0xFF667eea).withValues(alpha: 0.3),
                      const Color(0xFF667eea).withValues(alpha: 0.1),
                    ],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          day,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
            color: isToday ? const Color(0xFF667eea) : AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildSleepTips() {
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
                Icon(
                  Icons.lightbulb_outline,
                  color: AppTheme.warning,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  "8e3a13ff1bX10vRPw57x".tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildTipItem(
              "dc7b05c4d7Tq0NvFLNC1".tr,
              "21beb8614boiKBvymIFS".tr,
              Icons.schedule,
            ),
            const SizedBox(height: 12),
            _buildTipItem(
              "2c505882afJKi1EBsejx".tr,
              "62393d571c1xkHJXXzjp".tr,
              Icons.bedtime,
            ),
            const SizedBox(height: 12),
            _buildTipItem(
              "943d3b7335LWlxdQsoQT".tr,
              "20ccd4e9a2X8imt0fCwt".tr,
              Icons.home,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipItem(String title, String content, IconData icon) {
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
              color: const Color(0xFF667eea).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF667eea), size: 20),
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
