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

class ExerciseDetailScreen extends StatefulWidget {
  const ExerciseDetailScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen>
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
                      _buildExerciseOverview(),
                      const SizedBox(height: 24),
                      _buildExerciseStats(),
                      const SizedBox(height: 24),
                      _buildExerciseHistory(),
                      const SizedBox(height: 24),
                      _buildAchievements(),
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
      backgroundColor: const Color(0xFFE91E63),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFE91E63), Color(0xFFF06292)],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.directions_run,
                    color: Colors.white,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "ae4d58abf99P4eJzdRf9".tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "4105da7a20eaOZmoB97b".tr,
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
          "ae4d58abf99P4eJzdRf9".tr,
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

  Widget _buildExerciseOverview() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE91E63), Color(0xFFF06292)],
        ),
        borderRadius: AppTheme.borderRadiusLg,
        boxShadow: AppTheme.shadowMd,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildExerciseItem(
                "476f594017ROPFDJd9h2".tr,
                "45",
                "bd957bc497z5mERMpw3s".tr,
                Icons.access_time,
              ),
              Container(
                width: 1,
                height: 60,
                color: Colors.white.withValues(alpha: 0.3),
              ),
              _buildExerciseItem(
                "93ddcd048fnsaLmtQCyz".tr,
                "320",
                "kcal",
                Icons.local_fire_department,
              ),
              Container(
                width: 1,
                height: 60,
                color: Colors.white.withValues(alpha: 0.3),
              ),
              _buildExerciseItem(
                "ad2e2ae4bdhjQe6oDieB".tr,
                "591052c733Vnh0ZiO5Aa".tr,
                "",
                Icons.directions_run,
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
              "cfea0dce5cwGcInv4eEr".tr,
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

  Widget _buildExerciseItem(
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

  Widget _buildExerciseStats() {
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
                  Icons.analytics,
                  color: Color(0xFFE91E63),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "cd24f86413T1aSvS5048".tr,
                style: AppTheme.h4.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  "d7bd3929c9o6fd4Hg0Sg".tr,
                  "5",
                  "49da61ceeeNcMWupaC4V".tr,
                  Icons.calendar_today,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  "9b1830480cXzJWRmAF4O".tr,
                  "225",
                  "bd957bc497z5mERMpw3s".tr,
                  Icons.timer,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  "ebc7453e4cIKZAqFo9cq".tr,
                  "1600",
                  "kcal",
                  Icons.local_fire_department,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
    String unit,
    IconData icon,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFE91E63).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFFE91E63), size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTheme.h3.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFFE91E63),
          ),
        ),
        Text(unit, style: AppTheme.caption.copyWith(color: Colors.grey[600])),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTheme.caption.copyWith(color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildExerciseHistory() {
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
                "5ce63ada54eKUppgAkk5".tr,
                style: AppTheme.h4.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildHistoryItem(
            "d5f5a7a010IzjxF7WiWl".tr,
            "591052c733Vnh0ZiO5Aa".tr,
            "248b65d374qevUpbQhQM".tr,
            "320 kcal",
          ),
          _buildHistoryItem(
            "0c184871f6nTyxGqf7yX".tr,
            "3a8b5cef57f4GYPMtTyD".tr,
            "859757ea790GX2X81X8j".tr,
            "180 kcal",
          ),
          _buildHistoryItem(
            "807710c943vSDTH1tTOj".tr,
            "e81f910c0fjCPgyO8H5W".tr,
            "fd70a9cdccC4jfqgVulf".tr,
            "400 kcal",
          ),
          _buildHistoryItem(
            "c451a57e71NSe9NIbjWF".tr,
            "5d925cc69dtIlsZE85UM".tr,
            "e45e878440we2Oiu2WJl".tr,
            "280 kcal",
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(
    String date,
    String type,
    String duration,
    String calories,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFE91E63).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getExerciseIcon(type),
              color: const Color(0xFFE91E63),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: AppTheme.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  date,
                  style: AppTheme.caption.copyWith(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                duration,
                style: AppTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                calories,
                style: AppTheme.caption.copyWith(color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getExerciseIcon(String type) {
    if (type == "591052c7335CIJb4KyU1".tr) {
      return Icons.directions_run;
    } else if (type == "3a8b5cef5722hEX4N2Xj".tr) {
      return Icons.directions_walk;
    } else if (type == "e81f910c0fHVjV9AoDwL".tr) {
      return Icons.directions_bike;
    } else if (type == "5d925cc69dDsVAvBgs5O".tr) {
      return Icons.fitness_center;
    } else {
      return Icons.sports_soccer;
    }
  }

  Widget _buildAchievements() {
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
                  Icons.emoji_events,
                  color: Color(0xFF9C27B0),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "5f34bb48fahcRu5xL6gu".tr,
                style: AppTheme.h4.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildAchievementItem(
                  "2f61086b02zMHgx60JFh".tr,
                  "7",
                  "49da61ceeeNcMWupaC4V".tr,
                  Icons.local_fire_department,
                ),
              ),
              Expanded(
                child: _buildAchievementItem(
                  "a4b704ea12184BvNpItQ".tr,
                  "150",
                  "172fb7e67bllGxJMA2I7".tr,
                  Icons.fitness_center,
                ),
              ),
              Expanded(
                child: _buildAchievementItem(
                  "9b1830480cXzJWRmAF4O".tr,
                  "500",
                  "3b6fefc50fNuXmpyv220".tr,
                  Icons.timer,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementItem(
    String label,
    String value,
    String unit,
    IconData icon,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF9C27B0).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFF9C27B0), size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTheme.h3.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF9C27B0),
          ),
        ),
        Text(unit, style: AppTheme.caption.copyWith(color: Colors.grey[600])),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTheme.caption.copyWith(color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
      ],
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
                  Icons.lightbulb,
                  color: Color(0xFF4CAF50),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "6d0c215ca3skY6Q1xMjo".tr,
                style: AppTheme.h4.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTipItem(
            "2a2471ab80udlp5h6KJd".tr,
            "41943fb78fExeIqzTwW2".tr,
            Icons.trending_up,
          ),
          _buildTipItem(
            "500899a9ec9vDx1xXL70".tr,
            "b5420d59c56nNda0PW6o".tr,
            Icons.fitness_center,
          ),
          _buildTipItem(
            "ff5e66b69dA19GDGlVCc".tr,
            "c697f27cc2N3O3Smesc0".tr,
            Icons.bedtime,
          ),
          _buildTipItem(
            "facfba0f7fvknsHWkppf".tr,
            "deadb08138iFIvSJUFk2".tr,
            Icons.note_add,
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
              color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF4CAF50), size: 16),
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
