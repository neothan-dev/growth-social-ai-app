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

class HealthSummaryDetailScreen extends StatefulWidget {
  const HealthSummaryDetailScreen({super.key});

  @override
  State<HealthSummaryDetailScreen> createState() =>
      _HealthSummaryDetailScreenState();
}

class _HealthSummaryDetailScreenState extends State<HealthSummaryDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final Map<String, dynamic> healthData = {
    'healthScore': 85,
    'steps': 8500,
    'sleep': 7.5,
    'water': 1200,
    'exercise': 45,
    'mood': 8,
    'bloodPressure': {'systolic': 120, 'diastolic': 80},
    'bloodSugar': 5.8,
    'weight': 65.5,
    'bmi': 22.1,
  };

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
                      _buildHealthScoreOverview(),
                      const SizedBox(height: 24),
                      _buildHealthMetricsGrid(),
                      const SizedBox(height: 24),
                      _buildHealthAnalysis(),
                      const SizedBox(height: 24),
                      _buildHealthSummary(),
                      const SizedBox(height: 24),
                      _buildOptimizationSuggestions(),
                      const SizedBox(height: 24),
                      _buildWeeklyTrend(),
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
    final healthScore = healthData['healthScore'] as int;
    final healthColor = _getHealthScoreColor(healthScore);

    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      backgroundColor: healthColor,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [healthColor, healthColor.withValues(alpha: 0.8)],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.health_and_safety,
                    color: Colors.white,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "4edccb64faQ7QgXVNpQd".tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '85',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
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
          "4edccb64faQ7QgXVNpQd".tr,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildHealthScoreOverview() {
    final healthScore = healthData['healthScore'] as int;
    final healthColor = _getHealthScoreColor(healthScore);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [healthColor, healthColor.withValues(alpha: 0.8)],
        ),
        borderRadius: AppTheme.borderRadiusLg,
        boxShadow: AppTheme.shadowMd,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildScoreItem(
                "4b4d9b9b5eMgeaMW6sat".tr,
                "$healthScore",
                "b6a993c2569WP5gGOGR4".tr,
                "🏆",
              ),
              Container(
                width: 1,
                height: 60,
                color: Colors.white.withValues(alpha: 0.3),
              ),
              _buildScoreItem(
                "f7b9a497c8ADa5MIk4W7".tr,
                _getHealthStatus(healthScore),
                "",
                "📊",
              ),
              Container(
                width: 1,
                height: 60,
                color: Colors.white.withValues(alpha: 0.3),
              ),
              _buildScoreItem(
                "abee497473gYUgSlL9rk".tr,
                _getHealthAdvice(healthScore),
                "",
                "💡",
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: healthScore / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "72aa205ee6bs5WZp6JQX".tr +
                '${100 - healthScore}' +
                "b75a03ace7sqjoYKa5ut".tr,
            style: AppTheme.bodySmall.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreItem(
    String label,
    String value,
    String unit,
    String emoji,
  ) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTheme.h2.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (unit.isNotEmpty)
          Text(
            unit,
            style: AppTheme.caption.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTheme.caption.copyWith(
            color: Colors.white.withValues(alpha: 0.9),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildHealthMetricsGrid() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppTheme.borderRadiusLg,
        boxShadow: AppTheme.shadowSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.dashboard,
                  color: Color(0xFF2196F3),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "7d6a2704cfVDRDxw90MN".tr,
                style: AppTheme.h4.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
            children: [
              _buildMetricCard(
                "2986c7ee97TuBiXMmIgj".tr,
                "${healthData['steps']}",
                "a621b7cd7aXiNj8gcJSc".tr,
                "🚶‍♂️",
                const Color(0xFF4CAF50),
              ),
              _buildMetricCard(
                "01324e540dMvhSa0iTnS".tr,
                "${healthData['sleep']}",
                "3b6fefc50fQ2Y3gIyqjq".tr,
                "😴",
                const Color(0xFF667eea),
              ),
              _buildMetricCard(
                "6edae041a3iTBc0CQNti".tr,
                "${healthData['water']}",
                "ml",
                "💧",
                const Color(0xFF2196F3),
              ),
              _buildMetricCard(
                "a9d130d795LePAul47YQ".tr,
                "${healthData['exercise']}",
                "bd957bc497NZM9Th9WQ9".tr,
                "🏃‍♂️",
                const Color(0xFFFF9800),
              ),
              _buildMetricCard(
                "28f5b85888KDAzS8gCpN".tr,
                "${healthData['mood']}",
                "b6a993c2569WP5gGOGR4".tr,
                "😊",
                const Color(0xFF9C27B0),
              ),
              _buildMetricCard(
                "286592e54aXUSwX8NR8f".tr,
                "${healthData['bloodPressure']['systolic']}/${healthData['bloodPressure']['diastolic']}",
                "mmHg",
                "❤️",
                const Color(0xFFF44336),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(
    String label,
    String value,
    String unit,
    String emoji,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: AppTheme.bodySmall.copyWith(
                    fontWeight: FontWeight.w500,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: AppTheme.h3.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            unit,
            style: AppTheme.caption.copyWith(
              color: color.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthAnalysis() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppTheme.borderRadiusLg,
        boxShadow: AppTheme.shadowSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.analytics,
                  color: Color(0xFF4CAF50),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "1f23c0b29bnKEazFN45P".tr,
                style: AppTheme.h4.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildAnalysisItem(
            "b721527f7focbpZx0L8Q".tr,
            "cfea0dce5cU2ctZd2wSe".tr,
            "55776e283eiKfxKTzxT5".tr,
            "✅",
          ),
          _buildAnalysisItem(
            "492325ca78XrpiPaqFjq".tr,
            "2c99de8357ODIrrYsOf4".tr,
            "b82fa7d5051RK1eJzVxn".tr,
            "💪",
          ),
          _buildAnalysisItem(
            "7fe72e5d97H8pSXxzg6N".tr,
            "cfea0dce5cU2ctZd2wSe".tr,
            "c6ddf89f4bQwYE50hdr4".tr,
            "🌙",
          ),
          _buildAnalysisItem(
            "5338472183SQmMTYyujG".tr,
            "82474ffff03fLsltldck".tr,
            "3258ad8860wVzjFTGfVy".tr,
            "🥗",
          ),
          _buildAnalysisItem(
            "1986a8d194IwQq8diR26".tr,
            "2c99de8357ODIrrYsOf4".tr,
            "277a63d4ccyDdIi6TidC".tr,
            "😊",
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisItem(
    String label,
    String status,
    String description,
    String emoji,
  ) {
    Color statusColor = const Color(0xFF4CAF50);
    if (status == "82474ffff03fLsltldck".tr)
      statusColor = const Color(0xFFFF9800);
    if (status == "f121ab742ciURPmUNQ64".tr)
      statusColor = const Color(0xFFF44336);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      label,
                      style: AppTheme.bodyMedium.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        status,
                        style: AppTheme.caption.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTheme.caption.copyWith(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptimizationSuggestions() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppTheme.borderRadiusLg,
        boxShadow: AppTheme.shadowSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9800).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.lightbulb,
                  color: Color(0xFFFF9800),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "d05dc03c67SeoFfvFpol".tr,
                style: AppTheme.h4.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSuggestionItem(
            "693bd12702Iojcw8Qb7s".tr,
            "6f60e702b01vupWFqHYK".tr,
            "🏋️‍♂️",
            const Color(0xFFFF9800),
          ),
          _buildSuggestionItem(
            "b232106aaboWDTVqNIIL".tr,
            "b84bd6c63eXAoXrHHA8K".tr,
            "🌙",
            const Color(0xFF667eea),
          ),
          _buildSuggestionItem(
            "ea2031a434V1tUxL05t6".tr,
            "bd9b51164cqeGS6CMzbE".tr,
            "🥗",
            const Color(0xFF4CAF50),
          ),
          _buildSuggestionItem(
            "43ec42a22f95M9OzXHdC".tr,
            "8e087fa55e2YRgfZGZ2M".tr,
            "🏥",
            const Color(0xFF2196F3),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionItem(
    String title,
    String description,
    String emoji,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(emoji, style: const TextStyle(fontSize: 16)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.bodyMedium.copyWith(
                      fontWeight: FontWeight.w500,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: AppTheme.caption.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyTrend() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppTheme.borderRadiusLg,
        boxShadow: AppTheme.shadowSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF9C27B0).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.show_chart,
                  color: Color(0xFF9C27B0),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "65cb439313En2aek7Y5f".tr,
                style: AppTheme.h4.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.insert_chart, size: 48, color: Colors.grey),
                  const SizedBox(height: 8),
                  Text(
                    "5627b99872A5zDJZo0ZQ".tr,
                    style: AppTheme.bodyMedium.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "14468f665fApF9Yo5etn".tr,
                    style: AppTheme.caption.copyWith(color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthTips() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppTheme.borderRadiusLg,
        boxShadow: AppTheme.shadowSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.psychology,
                  color: Color(0xFF4CAF50),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "9409fd5409Gxu4FQAzIh".tr,
                style: AppTheme.h4.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTipItem(
            "f7d67244642cmpMwOEXS".tr,
            "09d9b41e9ahu0G6On4He".tr,
            "💧",
          ),
          _buildTipItem(
            "80a8a99446N0VPaM4XjR".tr,
            "7b24b5084asjmMp8hzcR".tr,
            "⏰",
          ),
          _buildTipItem(
            "d60139cb54QUhA8zaE7C".tr,
            "df49a2578djOfo286CtS".tr,
            "🏃‍♂️",
          ),
          _buildTipItem(
            "ea2031a434V1tUxL05t6".tr,
            "f74aeebd76Q2CgrToozx".tr,
            "🥗",
          ),
          _buildTipItem(
            "3287c7a986f8p863Dp71".tr,
            "b750619d757oX7vBiAwW".tr,
            "😊",
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String title, String description, String emoji) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  description,
                  style: AppTheme.caption.copyWith(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppTheme.borderRadiusLg,
        boxShadow: AppTheme.shadowSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFE91E63).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.summarize,
                  color: Color(0xFFE91E63),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "2b24b8481bFeH1u3a0O6".tr,
                style: AppTheme.h4.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSummaryItem(
            "9eafc11ef5srNOn1oeJJ".tr,
            "e27748c287uV5hCt9h2u".tr,
            "📊",
            const Color(0xFF4CAF50),
          ),
          _buildSummaryItem(
            "cdaffe9eabeme1IbVOhP".tr,
            "a9f0af38012r2KTeBRpE".tr,
            "⭐",
            const Color(0xFFFFC107),
          ),
          _buildSummaryItem(
            "f121ab742ciURPmUNQ64".tr,
            "e0924eea91C9s4oevZbz".tr,
            "⚠️",
            const Color(0xFFFF9800),
          ),
          _buildSummaryItem(
            "7919f94e55V9wdsvVpkK".tr,
            "2e8a65e94cfMX7xJ56v3".tr,
            "💪",
            const Color(0xFF2196F3),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF4CAF50), Color(0xFF8BC34A)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.emoji_events, color: Colors.white, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "59f2b7640eJovpmHQYEt".tr,
                        style: AppTheme.bodyMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "ee996d6903kMiWBA1n3O".tr,
                        style: AppTheme.caption.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
    String title,
    String description,
    String emoji,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(emoji, style: const TextStyle(fontSize: 16)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.bodyMedium.copyWith(
                      fontWeight: FontWeight.w500,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: AppTheme.caption.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getHealthScoreColor(int score) {
    if (score >= 90) return const Color(0xFF4CAF50);
    if (score >= 80) return const Color(0xFF8BC34A);
    if (score >= 70) return const Color(0xFFFFC107);
    if (score >= 60) return const Color(0xFFFF9800);
    return const Color(0xFFF44336);
  }

  String _getHealthStatus(int score) {
    if (score >= 90) return "2c99de8357ODIrrYsOf4".tr;
    if (score >= 80) return "cfea0dce5cU2ctZd2wSe".tr;
    if (score >= 70) return "91e25f4ddc3NvXBmaiiP".tr;
    if (score >= 60) return "82474ffff03fLsltldck".tr;
    return "f121ab742ciURPmUNQ64".tr;
  }

  String _getHealthAdvice(int score) {
    if (score >= 90) return "7084063046Y7Iqh8yVwY".tr;
    if (score >= 80) return "625ba0fcd7lHd1bYglXy".tr;
    if (score >= 70) return "82474ffff03fLsltldck".tr;
    if (score >= 60) return "becfbebc28pQVWRTBv4v".tr;
    return "87a120a024Mti3TgtWWt".tr;
  }
}
