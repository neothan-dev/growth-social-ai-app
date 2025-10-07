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
import '../models/health_progress.dart';
import '../theme/app_theme.dart';
import '../localization/app_localizations.dart';

class ProgressCard extends StatelessWidget {
  final HealthProgress progress;
  final VoidCallback? onTap;
  final bool showDetails;

  const ProgressCard({
    super.key,
    required this.progress,
    this.onTap,
    this.showDetails = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.12),
            Colors.white.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 12),
                _buildProgressInfo(),
                if (showDetails) ...[
                  const SizedBox(height: 12),
                  _buildAnalysis(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: progress.trendColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            progress.metricIcon,
            color: progress.trendColor,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      progress.title,
                      style: const TextStyle(
                        fontSize: 16,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (progress.isAchievement &&
                      progress.achievementIcon != null)
                    Text(
                      progress.achievementIcon!,
                      style: const TextStyle(
                        fontSize: 20,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                progress.description,
                style: AppTheme.bodyMedium.copyWith(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 13,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Column(
          children: [
            Icon(progress.trendIcon, color: progress.trendColor, size: 20),
            const SizedBox(height: 4),
            Text(
              progress.improvementDisplay,
              style: AppTheme.caption.copyWith(
                color: progress.trendColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressInfo() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "1220fd233a0jIa81dz4C".tr,
                style: AppTheme.caption.copyWith(
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                progress.displayValue,
                style: AppTheme.h3.copyWith(
                  fontSize: 15,
                  color: progress.trendColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "dcaee44404Rn9t8J84Se".tr,
                style: AppTheme.caption.copyWith(
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                progress.targetDisplayValue,
                style: AppTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "f81ff55de1vivPlil59j".tr,
                style: AppTheme.caption.copyWith(
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${progress.progressPercentage.toStringAsFixed(1)}%',
                style: AppTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: progress.progressPercentage >= 100
                      ? AppTheme.success
                      : AppTheme.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAnalysis() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 16),
        Text(
          "2af437d328xJw94Sqofa".tr,
          style: AppTheme.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          progress.analysis,
          style: AppTheme.bodyMedium.copyWith(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontSize: 13,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        if (progress.recommendations.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            "abee4974736JJ47GQ5Mc".tr,
            style: AppTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          const SizedBox(height: 8),
          ...progress.recommendations
              .take(2)
              .map(
                (recommendation) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        size: 16,
                        color: AppTheme.success,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          recommendation,
                          style: AppTheme.bodySmall.copyWith(
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        ],
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              progress.timeDisplay,
              style: AppTheme.caption.copyWith(
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            if (progress.isAchievement && progress.achievementTitle != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                    255,
                    119,
                    255,
                    111,
                  ).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  progress.achievementTitle!,
                  style: AppTheme.caption.copyWith(
                    color: const Color.fromARGB(255, 119, 255, 111),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class GoalCard extends StatelessWidget {
  final HealthGoal goal;
  final VoidCallback? onTap;

  const GoalCard({super.key, required this.goal, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.12),
            Colors.white.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 16),
                _buildProgressBar(),
                const SizedBox(height: 12),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: goal.goalStatusColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            _getMetricIcon(goal.metricType),
            color: goal.goalStatusColor,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                goal.title,
                style: AppTheme.h4.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                goal.description,
                style: AppTheme.bodyMedium.copyWith(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 13,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: goal.goalStatusColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            goal.goalStatus,
            style: AppTheme.caption.copyWith(
              color: goal.goalStatusColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${goal.currentValue.toStringAsFixed(1)}${goal.unit}',
              style: AppTheme.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: goal.goalStatusColor,
              ),
            ),
            Text(
              '${goal.progressPercentage.toStringAsFixed(1)}%',
              style: AppTheme.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: goal.goalStatusColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: goal.progressPercentage / 100,
          backgroundColor: Colors.white.withValues(alpha: 0.15),
          valueColor: AlwaysStoppedAnimation<Color>(goal.goalStatusColor),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
        const SizedBox(height: 4),
        Text(
          "7632918e84ya8JlzArgW".tr +
              ' ${goal.targetValue.toStringAsFixed(1)}${goal.unit}',
          style: AppTheme.caption.copyWith(
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "4363b456cfRUxHPJPPPu".tr + ' ${_formatDate(goal.createdAt)}',
          style: AppTheme.caption.copyWith(
            color: Colors.white.withValues(alpha: 0.75),
          ),
        ),
        Text(
          "d6cc06a90aUx8oq2E3qy".tr + '  ${_formatDate(goal.targetDate)}',
          style: AppTheme.caption.copyWith(
            color: goal.remainingDays <= 3
                ? Colors.red
                : Colors.white.withValues(alpha: 0.75),
            fontWeight: goal.remainingDays <= 3
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}';
  }

  IconData _getMetricIcon(HealthMetricType type) {
    switch (type) {
      case HealthMetricType.steps:
        return Icons.directions_walk;
      case HealthMetricType.heartRate:
        return Icons.favorite;
      case HealthMetricType.sleepHours:
        return Icons.bedtime;
      case HealthMetricType.weight:
        return Icons.monitor_weight;
      case HealthMetricType.bmi:
        return Icons.analytics;
      case HealthMetricType.calories:
        return Icons.local_fire_department;
      case HealthMetricType.distance:
        return Icons.straighten;
      case HealthMetricType.activeMinutes:
        return Icons.timer;
      case HealthMetricType.waterIntake:
        return Icons.water_drop;
      case HealthMetricType.bloodPressure:
        return Icons.favorite_border;
      case HealthMetricType.bloodSugar:
        return Icons.bloodtype;
      case HealthMetricType.bodyFat:
        return Icons.person_outline;
      case HealthMetricType.muscleMass:
        return Icons.fitness_center;
      case HealthMetricType.flexibility:
        return Icons.accessibility;
      case HealthMetricType.strength:
        return Icons.sports_gymnastics;
      case HealthMetricType.endurance:
        return Icons.directions_run;
    }
  }

  Color _getTrendColor(ProgressTrend trend) {
    switch (trend) {
      case ProgressTrend.improving:
        return Colors.green;
      case ProgressTrend.declining:
        return Colors.red;
      case ProgressTrend.stable:
        return Colors.orange;
      case ProgressTrend.fluctuating:
        return Colors.blue;
    }
  }

  IconData _getTrendIcon(ProgressTrend trend) {
    switch (trend) {
      case ProgressTrend.improving:
        return Icons.trending_up;
      case ProgressTrend.declining:
        return Icons.trending_down;
      case ProgressTrend.stable:
        return Icons.trending_flat;
      case ProgressTrend.fluctuating:
        return Icons.trending_up;
    }
  }
}

class ProgressSummaryCard extends StatelessWidget {
  final HealthProgressSummary summary;
  final VoidCallback? onTap;

  const ProgressSummaryCard({super.key, required this.summary, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.12),
            Colors.white.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                _buildMetrics(),
                const SizedBox(height: 20),
                _buildTrendDescription(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: _getTrendColor(summary.overallTrend).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            _getTrendIcon(summary.overallTrend),
            color: _getTrendColor(summary.overallTrend),
            size: 28,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "018adde63c7ztGdXiDrK".tr,
                style: AppTheme.h3.copyWith(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(height: 4),
              Text(
                "b92276ef54XOugisZ8gq".tr +
                    '${summary.overallProgress.toStringAsFixed(1)}%',
                style: AppTheme.bodyMedium.copyWith(
                  color: Colors.white.withValues(alpha: 0.85),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetrics() {
    return Row(
      children: [
        _buildMetricItem(
          "e0951339aeOpvI6jCkAD".tr,
          summary.improvingMetrics.toString(),
          Colors.green,
          Icons.trending_up,
        ),
        _buildMetricItem(
          "8d972cf006DPVcMlrO9P".tr,
          summary.stableMetrics.toString(),
          Colors.orange,
          Icons.trending_flat,
        ),
        _buildMetricItem(
          "2b1f270ff8bnuVbv1sSi".tr,
          summary.decliningMetrics.toString(),
          Colors.red,
          Icons.trending_down,
        ),
      ],
    );
  }

  Widget _buildMetricItem(
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTheme.h4.copyWith(
              fontSize: 18,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: AppTheme.caption.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendDescription() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _getTrendColor(summary.overallTrend).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _getTrendColor(summary.overallTrend).withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.lightbulb_outline,
            color: _getTrendColor(summary.overallTrend),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              summary.trendDescription,
              style: AppTheme.bodyMedium.copyWith(
                color: _getTrendColor(summary.overallTrend),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getTrendColor(ProgressTrend trend) {
    switch (trend) {
      case ProgressTrend.improving:
        return Colors.green;
      case ProgressTrend.declining:
        return Colors.red;
      case ProgressTrend.stable:
        return Colors.orange;
      case ProgressTrend.fluctuating:
        return Colors.blue;
    }
  }

  IconData _getTrendIcon(ProgressTrend trend) {
    switch (trend) {
      case ProgressTrend.improving:
        return Icons.trending_up;
      case ProgressTrend.declining:
        return Icons.trending_down;
      case ProgressTrend.stable:
        return Icons.trending_flat;
      case ProgressTrend.fluctuating:
        return Icons.trending_up;
    }
  }
}
