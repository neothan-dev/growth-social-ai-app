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

class BloodSugarDetailScreen extends StatefulWidget {
  const BloodSugarDetailScreen({Key? key}) : super(key: key);

  @override
  State<BloodSugarDetailScreen> createState() => _BloodSugarDetailScreenState();
}

class _BloodSugarDetailScreenState extends State<BloodSugarDetailScreen>
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
                      _buildBloodSugarOverview(),
                      const SizedBox(height: 24),
                      _buildBloodSugarAnalysis(),
                      const SizedBox(height: 24),
                      _buildTrendChart(),
                      const SizedBox(height: 24),
                      _buildMeasurementHistory(),
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
      backgroundColor: const Color(0xFF4CAF50),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF4CAF50), Color(0xFF8BC34A)],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.water_drop, color: Colors.white, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    "2b3f634878i2Z5fOxAQ8".tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "5.8 mmol/L",
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
          "2b3f634878qO8YbFzLLs".tr,
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

  Widget _buildBloodSugarOverview() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4CAF50), Color(0xFF8BC34A)],
        ),
        borderRadius: AppTheme.borderRadiusLg,
        boxShadow: AppTheme.shadowMd,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSugarItem(
                "5c649f7f66lKIlgk0iuW".tr,
                "5.8",
                "mmol/L",
                Icons.water_drop,
              ),
              Container(
                width: 1,
                height: 60,
                color: Colors.white.withValues(alpha: 0.3),
              ),
              _buildSugarItem(
                "3c053e46b4G90G59STi7".tr,
                "3.9-6.1",
                "mmol/L",
                Icons.track_changes,
              ),
              Container(
                width: 1,
                height: 60,
                color: Colors.white.withValues(alpha: 0.3),
              ),
              _buildSugarItem(
                "9ac1756057MLNVJHn5q2".tr,
                "571f6ee9d87pI0OoScOa".tr,
                "",
                Icons.access_time,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "296de0e31foo4wZsFv9W".tr,
              style: AppTheme.bodyMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSugarItem(
    String label,
    String value,
    String unit,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
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

  Widget _buildBloodSugarAnalysis() {
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
                "adb3322e4bjL3xlmNVYU".tr,
                style: AppTheme.h4.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildAnalysisItem(
            "3ad7bf7026m0mYsxQZrS".tr,
            "296de0e31f7FC8WPdWSQ".tr,
            "1c7fe4e087QcMZwzMx2b".tr,
          ),
          _buildAnalysisItem(
            "d23c11b6fbc1Cx90X5Vn".tr,
            "2f9165199d8hXfq2idq4".tr,
            "2dcaed8ebfVmAEMgvzyc".tr,
          ),
          _buildAnalysisItem(
            "abee497473Ui8tChmGR5".tr,
            "a5a7f08d8dFyCMIG0Sp0".tr,
            "fbedc25f5aFeb4i1VO0U".tr,
          ),
          _buildAnalysisItem(
            "5338472183ycklgpBVZ7".tr,
            "987e4c2947MZHFWXujTA".tr,
            "a5fa7e2e3bs7pqS4QbY1".tr,
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisItem(String label, String value, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: AppTheme.bodyMedium.copyWith(color: Colors.grey[600]),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              value,
              style: AppTheme.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
                color: const Color(0xFF4CAF50),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              description,
              style: AppTheme.caption.copyWith(color: Colors.grey[500]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendChart() {
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
                  Icons.show_chart,
                  color: Color(0xFF2196F3),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "7e098fd4f2peKuMlZEGc".tr,
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
                  Icon(Icons.insert_chart, size: 48, color: Colors.grey[400]),
                  const SizedBox(height: 8),
                  Text(
                    "96e9bc9214sjj2yJKpUA".tr,
                    style: AppTheme.bodyMedium.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "5c3bfdde49uJ1pGPoxa5".tr,
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

  Widget _buildMeasurementHistory() {
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
                  Icons.history,
                  color: Color(0xFFFF9800),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "38c86d761bxUA69F3yMD".tr,
                style: AppTheme.h4.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildHistoryItem(
            "d62f698ec1IskSlChsLm".tr,
            "5.8",
            "571f6ee9d8qaV1Pvmbke".tr,
            "296de0e31fFimGjUO5Ub".tr,
          ),
          _buildHistoryItem(
            "029d5509d6A0sr3QwZI2".tr,
            "5.2",
            "571f6ee9d8XUUWhaHfPk".tr,
            "296de0e31fK6Xr0qxzP1".tr,
          ),
          _buildHistoryItem(
            "159547a92f2bB6nqFe54".tr,
            "5.9",
            "571f6ee9d8xGZCQ5miWW".tr,
            "296de0e31f6efjOoANKH".tr,
          ),
          _buildHistoryItem(
            "95347b71918THNyzIcRZ".tr,
            "5.5",
            "571f6ee9d8LdRYJ3zVgZ".tr,
            "296de0e31fch2Ff4v5QO".tr,
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(
    String time,
    String glucose,
    String mealTime,
    String status,
  ) {
    Color statusColor = const Color(0xFF4CAF50);
    if (status == "cde6311d91ZDNHeKsZmu".tr)
      statusColor = const Color(0xFFFF9800);
    if (status == "b1c27820feeJsXVYFDwy".tr)
      statusColor = const Color(0xFFF44336);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              time,
              style: AppTheme.bodySmall.copyWith(color: Colors.grey[600]),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "$glucose mmol/L",
              style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              mealTime,
              style: AppTheme.bodySmall.copyWith(color: Colors.grey[600]),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                textAlign: TextAlign.center,
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
                  color: const Color(0xFF9C27B0).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.lightbulb,
                  color: Color(0xFF9C27B0),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "993f81e4641RFvQUcKHu".tr,
                style: AppTheme.h4.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTipItem(
            "080adce27216Gj6dgDFN".tr,
            "337afdd3e76YraHCZRU4".tr,
            Icons.restaurant,
          ),
          _buildTipItem(
            "19228659aa1rweoP6MFA".tr,
            "23b513f4a2xF6SG42oh5".tr,
            Icons.directions_run,
          ),
          _buildTipItem(
            "a5a7f08d8dHbm5UeMYCx".tr,
            "712fd9f039tUDMEdgeYM".tr,
            Icons.monitor_heart,
          ),
          _buildTipItem(
            "d3be98b56cweF0OujziL".tr,
            "cc8d98f28cRm7XdQY6UL".tr,
            Icons.bedtime,
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String title, String description, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF9C27B0).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF9C27B0), size: 16),
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
    );
  }
}
