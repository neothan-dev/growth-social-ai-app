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

class BodyMetricsDetailScreen extends StatefulWidget {
  const BodyMetricsDetailScreen({Key? key}) : super(key: key);

  @override
  State<BodyMetricsDetailScreen> createState() =>
      _BodyMetricsDetailScreenState();
}

class _BodyMetricsDetailScreenState extends State<BodyMetricsDetailScreen>
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
                      _buildBodyOverview(),
                      const SizedBox(height: 24),
                      _buildBMIAnalysis(),
                      const SizedBox(height: 24),
                      _buildBodyComposition(),
                      const SizedBox(height: 24),
                      _buildTrendChart(),
                      const SizedBox(height: 24),
                      _buildHealthTips(),
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
      backgroundColor: const Color(0xFF4facfe),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.monitor_weight,
                    color: Colors.white,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "836dc12e2283WLS1ta1r".tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "65.0 kg | 170 cm",
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
          "12c4681a157ORVHl4zWn".tr,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildBodyOverview() {
    return Card(
      elevation: 8,
      shadowColor: const Color(0xFF4facfe).withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBodyStat("38f7c7e22fHRAAF8nsBk".tr, '65.0', 'kg'),
                _buildBodyStat("2763b73dd1xxDEVY5C1k".tr, '170', 'cm'),
                _buildBodyStat('BMI', '22.5', ''),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBodyStat("f170ff1192V9ecBNX33N".tr, '18.5', '%'),
                _buildBodyStat("1731a8949eNB0iFSPxby".tr, '45.2', 'kg'),
                _buildBodyStat("43e16a8592DGn7xbNDCl".tr, '1,450', 'kcal'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyStat(String label, String value, String unit) {
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

  Widget _buildBMIAnalysis() {
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
                  "9df17109942kAdgj8s5i".tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.green.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 32),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "7d67d928aawj57b21Vvu".tr,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "22b3e2df27laE3gHrDAH".tr,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildBMIRange(
                    "f92be065a68dmNPxi6LH".tr,
                    '<18.5',
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildBMIRange(
                    "296de0e31fpCo8YKesn8".tr,
                    '18.5-24',
                    Colors.green,
                    isCurrent: true,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildBMIRange(
                    "e63b805a616zihxE9cQ9".tr,
                    '24-28',
                    Colors.orange,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildBMIRange(
                    "a925178ee9bMskz2LYSJ".tr,
                    '>28',
                    Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBMIRange(
    String label,
    String range,
    Color color, {
    bool isCurrent = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isCurrent
            ? color.withValues(alpha: 0.2)
            : color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isCurrent ? color : color.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
              color: isCurrent ? color : AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            range,
            style: TextStyle(
              fontSize: 8,
              color: isCurrent ? color : AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyComposition() {
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
                  "90f13d395dg7r6XVnNdC".tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildCompositionItem(
                    "b986987086q045assoC0".tr,
                    '45.2kg',
                    '69.5%',
                    Colors.blue,
                    "fc1562ec9dGoUXNINeO5".tr,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildCompositionItem(
                    "d1cb6ec4c8qzQ76752JP".tr,
                    '12.0kg',
                    '18.5%',
                    Colors.orange,
                    "b084338665k2QMsvXlZf".tr,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildCompositionItem(
                    "7fbaf82478GWeBlEfwaN".tr,
                    '3.2kg',
                    '4.9%',
                    Colors.grey,
                    "a5950a3ffcTUce3C1m5A".tr,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompositionItem(
    String name,
    String weight,
    String percentage,
    Color color,
    String status,
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
            weight,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            percentage,
            style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
          ),
          const SizedBox(height: 8),
          Text(
            status,
            style: TextStyle(fontSize: 10, color: AppTheme.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTrendChart() {
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
                  "8779893585QW5kqHB0Sq".tr,
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
                  _buildWeightBar("3e750612b1dKRW9OLE3L".tr, 0.7, '67.2'),
                  _buildWeightBar("42d5f1ff3cyEn8uWRw6d".tr, 0.68, '66.8'),
                  _buildWeightBar("720a8da458B1XuUebKF4".tr, 0.67, '66.5'),
                  _buildWeightBar("1b6e21a2416LFUDw5HeW".tr, 0.66, '66.2'),
                  _buildWeightBar("295d12c477jj4hfluQC9".tr, 0.65, '65.8'),
                  _buildWeightBar("bc3e874c550ceXKFjnRe".tr, 0.64, '65.5'),
                  _buildWeightBar(
                    "e610f3af85ZcbRgCE2nS".tr,
                    0.63,
                    '65.0',
                    isToday: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "9c031dc9d9KQ15ipUSsf".tr,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "509fb077caoA8itp3nGt".tr,
                  style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeightBar(
    String month,
    double height,
    String weight, {
    bool isToday = false,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          weight,
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
                  ? [const Color(0xFF4facfe), const Color(0xFF00f2fe)]
                  : [
                      const Color(0xFF4facfe).withValues(alpha: 0.3),
                      const Color(0xFF4facfe).withValues(alpha: 0.1),
                    ],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          month,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
            color: isToday ? const Color(0xFF4facfe) : AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildHealthTips() {
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
                  "993f81e464pJxDCmt6kd".tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildTipItem(
              "6d0d97527fCiRqUF1UAq".tr,
              "bae002207b44xKTucx7K".tr,
              Icons.check_circle,
              Colors.green,
            ),
            const SizedBox(height: 12),
            _buildTipItem(
              "75eea6ac5bZgMjdiG0TJ".tr,
              "47e026e253fpeEGotcLx".tr,
              Icons.fitness_center,
              Colors.blue,
            ),
            const SizedBox(height: 12),
            _buildTipItem(
              "a5a7f08d8dWfnwsM8NFQ".tr,
              "3219ae304chbPLMsUh9A".tr,
              Icons.monitor_weight,
              Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipItem(
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
