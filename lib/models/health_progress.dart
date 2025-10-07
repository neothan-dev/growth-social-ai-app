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
import 'package:vital_ai/localization/app_localizations.dart';

enum HealthMetricType {
  steps,
  heartRate,
  sleepHours,
  weight,
  bmi,
  calories,
  distance,
  activeMinutes,
  waterIntake,
  bloodPressure,
  bloodSugar,
  bodyFat,
  muscleMass,
  flexibility,
  strength,
  endurance,
}

enum ProgressTrend {
  improving,
  declining,
  stable,
  fluctuating,
}

class HealthProgress {
  final String id;
  final HealthMetricType metricType;
  final String title;
  final String description;
  final double currentValue;
  final double previousValue;
  final double targetValue;
  final String unit;
  final DateTime date;
  final ProgressTrend trend;
  final double improvementPercentage;
  final String analysis;
  final List<String> recommendations;
  final Map<String, dynamic>? metadata;
  final bool isAchievement;
  final String? achievementIcon;
  final String? achievementTitle;

  HealthProgress({
    required this.id,
    required this.metricType,
    required this.title,
    required this.description,
    required this.currentValue,
    required this.previousValue,
    required this.targetValue,
    required this.unit,
    required this.date,
    required this.trend,
    required this.improvementPercentage,
    required this.analysis,
    required this.recommendations,
    this.metadata,
    this.isAchievement = false,
    this.achievementIcon,
    this.achievementTitle,
  });

  factory HealthProgress.fromJson(Map<String, dynamic> json) {
    return HealthProgress(
      id: json['id'] ?? '',
      metricType: HealthMetricType.values.firstWhere(
        (e) => e.name == json['metric_type'],
        orElse: () => HealthMetricType.steps,
      ),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      currentValue: (json['current_value'] ?? 0).toDouble(),
      previousValue: (json['previous_value'] ?? 0).toDouble(),
      targetValue: (json['target_value'] ?? 0).toDouble(),
      unit: json['unit'] ?? '',
      date: DateTime.parse(json['date']),
      trend: ProgressTrend.values.firstWhere(
        (e) => e.name == json['trend'],
        orElse: () => ProgressTrend.stable,
      ),
      improvementPercentage: (json['improvement_percentage'] ?? 0).toDouble(),
      analysis: json['analysis'] ?? '',
      recommendations: List<String>.from(json['recommendations'] ?? []),
      metadata: json['metadata'],
      isAchievement: json['is_achievement'] ?? false,
      achievementIcon: json['achievement_icon'],
      achievementTitle: json['achievement_title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'metric_type': metricType.name,
      'title': title,
      'description': description,
      'current_value': currentValue,
      'previous_value': previousValue,
      'target_value': targetValue,
      'unit': unit,
      'date': date.toIso8601String(),
      'trend': trend.name,
      'improvement_percentage': improvementPercentage,
      'analysis': analysis,
      'recommendations': recommendations,
      'metadata': metadata,
      'is_achievement': isAchievement,
      'achievement_icon': achievementIcon,
      'achievement_title': achievementTitle,
    };
  }

  IconData get trendIcon {
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

  Color get trendColor {
    switch (trend) {
      case ProgressTrend.improving:
        return const Color.fromARGB(255, 131, 237, 134);
      case ProgressTrend.declining:
        return Colors.red;
      case ProgressTrend.stable:
        return Colors.orange;
      case ProgressTrend.fluctuating:
        return Colors.blue;
    }
  }

  IconData get metricIcon {
    switch (metricType) {
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

  double get progressPercentage {
    if (targetValue == 0) return 0;
    return (currentValue / targetValue * 100).clamp(0, 100);
  }

  String get displayValue {
    if (currentValue == currentValue.toInt()) {
      return '${currentValue.toInt()}$unit';
    }
    return '${currentValue.toStringAsFixed(1)}$unit';
  }

  String get targetDisplayValue {
    if (targetValue == targetValue.toInt()) {
      return '${targetValue.toInt()}$unit';
    }
    return '${targetValue.toStringAsFixed(1)}$unit';
  }

  String get improvementDisplay {
    if (improvementPercentage > 0) {
      return '+${improvementPercentage.toStringAsFixed(1)}%';
    } else if (improvementPercentage < 0) {
      return '${improvementPercentage.toStringAsFixed(1)}%';
    }
    return '0%';
  }

  String get timeDisplay {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return "d5f5a7a010Z5MkEvCyIN".tr;
    } else if (difference.inDays == 1) {
      return "0c184871f6AC0vmwo5Mv".tr;
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ' + "798440e7e9o0fRCcnkDh".tr;
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()} ' + "1433e947cbYY51F5K6l3".tr;
    } else {
      return '${(difference.inDays / 30).floor()} ' + "5bb5c281a0aX52IAB2Is".tr;
    }
  }
}

class HealthProgressSummary {
  final int totalMetrics;
  final int improvingMetrics;
  final int decliningMetrics;
  final int stableMetrics;
  final double overallProgress;
  final List<HealthProgress> recentProgress;
  final List<HealthProgress> achievements;
  final Map<HealthMetricType, double> metricAverages;

  HealthProgressSummary({
    required this.totalMetrics,
    required this.improvingMetrics,
    required this.decliningMetrics,
    required this.stableMetrics,
    required this.overallProgress,
    required this.recentProgress,
    required this.achievements,
    required this.metricAverages,
  });

  ProgressTrend get overallTrend {
    if (improvingMetrics > decliningMetrics) {
      return ProgressTrend.improving;
    } else if (decliningMetrics > improvingMetrics) {
      return ProgressTrend.declining;
    } else {
      return ProgressTrend.stable;
    }
  }

  String get trendDescription {
    switch (overallTrend) {
      case ProgressTrend.improving:
        return "8ba89e3169MwnJLdKaw3".tr;
      case ProgressTrend.declining:
        return "9c227ccffbRda97I6L25".tr;
      case ProgressTrend.stable:
        return "369d9fb8dcjTTraerJxi".tr;
      case ProgressTrend.fluctuating:
        return "a06294e1b3Va9FmBTG5y".tr;
    }
  }
}

class HealthGoal {
  final String id;
  final HealthMetricType metricType;
  final String title;
  final String description;
  final double targetValue;
  final double currentValue;
  final String unit;
  final DateTime targetDate;
  final DateTime createdAt;
  final bool isCompleted;
  final double progressPercentage;

  HealthGoal({
    required this.id,
    required this.metricType,
    required this.title,
    required this.description,
    required this.targetValue,
    required this.currentValue,
    required this.unit,
    required this.targetDate,
    required this.createdAt,
    this.isCompleted = false,
    required this.progressPercentage,
  });

  factory HealthGoal.fromJson(Map<String, dynamic> json) {
    return HealthGoal(
      id: json['id'] ?? '',
      metricType: HealthMetricType.values.firstWhere(
        (e) => e.name == json['metric_type'],
        orElse: () => HealthMetricType.steps,
      ),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      targetValue: (json['target_value'] ?? 0).toDouble(),
      currentValue: (json['current_value'] ?? 0).toDouble(),
      unit: json['unit'] ?? '',
      targetDate: DateTime.parse(json['target_date']),
      createdAt: DateTime.parse(json['created_at']),
      isCompleted: json['is_completed'] ?? false,
      progressPercentage: (json['progress_percentage'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'metric_type': metricType.name,
      'title': title,
      'description': description,
      'target_value': targetValue,
      'current_value': currentValue,
      'unit': unit,
      'target_date': targetDate.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'is_completed': isCompleted,
      'progress_percentage': progressPercentage,
    };
  }

  int get remainingDays {
    final now = DateTime.now();
    final difference = targetDate.difference(now);
    return difference.inDays;
  }

  String get goalStatus {
    if (isCompleted) {
      return "f28461bb49KbWWys5Dmo".tr;
    } else if (remainingDays < 0) {
      return "13c68d1348GFwuCQwqAR".tr;
    } else if (remainingDays == 0) {
      return "9004c04f7334RIWHMTBU".tr;
    } else {
      return "f328f2e289vmCfQgfOoU".tr + ' ${remainingDays}';
    }
  }

  Color get goalStatusColor {
    if (isCompleted) {
      return Colors.green;
    } else if (remainingDays < 0) {
      return Colors.red;
    } else if (remainingDays <= 3) {
      return Colors.orange;
    } else {
      return Colors.blue;
    }
  }
}
