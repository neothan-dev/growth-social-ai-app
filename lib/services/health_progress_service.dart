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

import 'dart:async';
import '../models/health_progress.dart';
import '../localization/app_localizations.dart';

class HealthProgressService {
  static final HealthProgressService _instance =
      HealthProgressService._internal();
  factory HealthProgressService() => _instance;
  HealthProgressService._internal();

  List<HealthProgress> _progressList = [];
  List<HealthGoal> _goals = [];
  HealthProgressSummary? _summary;

  final StreamController<List<HealthProgress>> _progressController =
      StreamController<List<HealthProgress>>.broadcast();
  final StreamController<List<HealthGoal>> _goalsController =
      StreamController<List<HealthGoal>>.broadcast();
  final StreamController<HealthProgressSummary?> _summaryController =
      StreamController<HealthProgressSummary?>.broadcast();

  Stream<List<HealthProgress>> get progressStream => _progressController.stream;

  Stream<List<HealthGoal>> get goalsStream => _goalsController.stream;

  Stream<HealthProgressSummary?> get summaryStream => _summaryController.stream;

  Future<List<HealthProgress>> getProgressList() async {
    try {
      await _loadMockProgressData();
      _progressController.add(_progressList);
      return _progressList;
    } catch (e) {
      print('获取进步记录失败: $e');
      return [];
    }
  }

  Future<List<HealthGoal>> getGoals() async {
    try {
      await _loadMockGoalsData();
      _goalsController.add(_goals);
      return _goals;
    } catch (e) {
      print('获取健康目标失败: $e');
      return [];
    }
  }

  Future<HealthProgressSummary?> getSummary() async {
    try {
      await getProgressList();
      await getGoals();
      _summary = _calculateSummary();
      _summaryController.add(_summary);
      return _summary;
    } catch (e) {
      print('获取进步摘要失败: $e');
      return null;
    }
  }

  Future<List<HealthProgress>> getProgressByType(HealthMetricType type) async {
    final allProgress = await getProgressList();
    return allProgress
        .where((progress) => progress.metricType == type)
        .toList();
  }

  Future<List<HealthProgress>> getRecentProgress({int limit = 5}) async {
    final allProgress = await getProgressList();
    allProgress.sort((a, b) => b.date.compareTo(a.date));
    return allProgress.take(limit).toList();
  }

  Future<List<HealthProgress>> getAchievements() async {
    final allProgress = await getProgressList();
    return allProgress.where((progress) => progress.isAchievement).toList();
  }

  Future<bool> addProgress(HealthProgress progress) async {
    try {
      _progressList.add(progress);
      _progressList.sort((a, b) => b.date.compareTo(a.date));
      _progressController.add(_progressList);

      _summary = _calculateSummary();
      _summaryController.add(_summary);

      return true;
    } catch (e) {
      print('添加进步记录失败: $e');
      return false;
    }
  }

  Future<bool> addGoal(HealthGoal goal) async {
    try {
      _goals.add(goal);
      _goals.sort((a, b) => a.targetDate.compareTo(b.targetDate));
      _goalsController.add(_goals);
      return true;
    } catch (e) {
      print('添加健康目标失败: $e');
      return false;
    }
  }

  Future<bool> updateGoalProgress(String goalId, double currentValue) async {
    try {
      final index = _goals.indexWhere((goal) => goal.id == goalId);
      if (index != -1) {
        final goal = _goals[index];
        final progressPercentage = (currentValue / goal.targetValue * 100)
            .clamp(0, 100);
        final isCompleted = progressPercentage >= 100;

        _goals[index] = HealthGoal(
          id: goal.id,
          metricType: goal.metricType,
          title: goal.title,
          description: goal.description,
          targetValue: goal.targetValue,
          currentValue: currentValue,
          unit: goal.unit,
          targetDate: goal.targetDate,
          createdAt: goal.createdAt,
          isCompleted: isCompleted,
          progressPercentage: progressPercentage.toDouble(),
        );

        _goalsController.add(_goals);
        return true;
      }
      return false;
    } catch (e) {
      print('更新目标进度失败: $e');
      return false;
    }
  }

  Future<bool> deleteProgress(String progressId) async {
    try {
      _progressList.removeWhere((progress) => progress.id == progressId);
      _progressController.add(_progressList);

      _summary = _calculateSummary();
      _summaryController.add(_summary);

      return true;
    } catch (e) {
      print('删除进步记录失败: $e');
      return false;
    }
  }

  Future<bool> deleteGoal(String goalId) async {
    try {
      _goals.removeWhere((goal) => goal.id == goalId);
      _goalsController.add(_goals);
      return true;
    } catch (e) {
      print('删除健康目标失败: $e');
      return false;
    }
  }

  HealthProgressSummary _calculateSummary() {
    if (_progressList.isEmpty) {
      return HealthProgressSummary(
        totalMetrics: 0,
        improvingMetrics: 0,
        decliningMetrics: 0,
        stableMetrics: 0,
        overallProgress: 0,
        recentProgress: [],
        achievements: [],
        metricAverages: {},
      );
    }

    int improving = 0, declining = 0, stable = 0;
    final Map<HealthMetricType, List<double>> metricValues = {};

    for (final progress in _progressList) {
      switch (progress.trend) {
        case ProgressTrend.improving:
          improving++;
          break;
        case ProgressTrend.declining:
          declining++;
          break;
        case ProgressTrend.stable:
        case ProgressTrend.fluctuating:
          stable++;
          break;
      }

      if (!metricValues.containsKey(progress.metricType)) {
        metricValues[progress.metricType] = [];
      }
      metricValues[progress.metricType]!.add(progress.currentValue);
    }

    final Map<HealthMetricType, double> averages = {};
    metricValues.forEach((type, values) {
      if (values.isNotEmpty) {
        final sum = values.reduce((a, b) => a + b);
        averages[type] = sum / values.length;
      }
    });

    final recent = _progressList.take(5).toList();

    final achievements = _progressList.where((p) => p.isAchievement).toList();

    final overallProgress =
        _progressList.fold<double>(
          0,
          (sum, progress) => sum + progress.progressPercentage,
        ) /
        _progressList.length;

    return HealthProgressSummary(
      totalMetrics: _progressList.length,
      improvingMetrics: improving,
      decliningMetrics: declining,
      stableMetrics: stable,
      overallProgress: overallProgress,
      recentProgress: recent,
      achievements: achievements,
      metricAverages: averages,
    );
  }

  List<String> generateRecommendations(HealthProgress progress) {
    final recommendations = <String>[];

    switch (progress.metricType) {
      case HealthMetricType.steps:
        if (progress.currentValue < 8000) {
          recommendations.addAll([
            "25d24ec515cvFJVCrQkX".tr,
            "9831a2f807htydLqhF63".tr,
            "99ce6e7590pkvBES1Djx".tr,
          ]);
        }
        break;
      case HealthMetricType.heartRate:
        if (progress.currentValue > 100) {
          recommendations.addAll([
            "65b53ddd84SJTcHLPCsD".tr,
            "c885285033cjiosQsnep".tr,
            "bde436b514uzJxLTo9KZ".tr,
          ]);
        }
        break;
      case HealthMetricType.sleepHours:
        if (progress.currentValue < 7) {
          recommendations.addAll([
            "3fa42610f0JQHs9DBw2N".tr,
            "c226c00280UlPL8Nlzyq".tr,
            "e9fae8857b8MstI5wOSh".tr,
            "135f79ff4b9OjVVr8Zp2".tr,
          ]);
        }
        break;
      case HealthMetricType.weight:
        if (progress.trend == ProgressTrend.declining) {
          recommendations.addAll([
            "aec860ee23qlGhkZrZK7".tr,
            "92714384b0idWMJtatGK".tr,
            "458b96f4eem74ST3qWo2".tr,
          ]);
        }
        break;
      case HealthMetricType.calories:
        if (progress.currentValue < 2000) {
          recommendations.addAll([
            "23249a6405osneyg4JeW".tr,
            "2794aa460fMsrYK4o0Fh".tr,
            "52c7bc6a1fzUps8RmppD".tr,
          ]);
        }
        break;
      default:
        recommendations.add("731537418bK94vRoiXXH".tr);
    }

    return recommendations;
  }

  Future<void> _loadMockProgressData() async {
    await Future.delayed(const Duration(milliseconds: 300));

    _progressList = [
      HealthProgress(
        id: '1',
        metricType: HealthMetricType.steps,
        title: "edc6406a4dRbEUCiiPzx".tr,
        description: "f3f50a4c25IdQVdARWfk".tr,
        currentValue: 8500,
        previousValue: 7400,
        targetValue: 10000,
        unit: 'a621b7cd7afC2z2uArdY'.tr,
        date: DateTime.now().subtract(const Duration(days: 1)),
        trend: ProgressTrend.improving,
        improvementPercentage: 15.2,
        analysis: "8f224e04fcKSM05FGozD".tr,
        recommendations: [
          "36b6abcae1uBIkY06nFf".tr,
          "bd2d1cce86LjoBYW2GPy".tr,
          "a7e46b5473BbpdnDY3uM".tr,
        ],
        isAchievement: true,
        achievementIcon: '🏃‍♂️',
        achievementTitle: "769958682fQwY0dhWAwI".tr,
      ),
      HealthProgress(
        id: '2',
        metricType: HealthMetricType.heartRate,
        title: "1cccefdd7edwxDTGodrX".tr,
        description: "77f505a7c2KZZUREg1En".tr,
        currentValue: 68,
        previousValue: 75,
        targetValue: 60,
        unit: 'bpm',
        date: DateTime.now().subtract(const Duration(days: 2)),
        trend: ProgressTrend.improving,
        improvementPercentage: 9.3,
        analysis: "ba0936986f55BBAWIeKT".tr,
        recommendations: [
          "547a389085jUirzRoKIO".tr,
          "766cb6e421ZImin7QSvD".tr,
          "39a781631aLtkhrhRvqD".tr,
        ],
      ),
      HealthProgress(
        id: '3',
        metricType: HealthMetricType.sleepHours,
        title: "11e907dbc6eDMTezlrXB".tr,
        description: "b3b056128eGCWtCiYWqU".tr,
        currentValue: 7.5,
        previousValue: 6.8,
        targetValue: 8.0,
        unit: "3b6fefc50fR3XkqCjJIs".tr,
        date: DateTime.now().subtract(const Duration(days: 3)),
        trend: ProgressTrend.improving,
        improvementPercentage: 10.3,
        analysis: "97b3a7f018sQV3AsZHHX".tr,
        recommendations: [
          "c226c00280Ji8uBRP8hj".tr,
          "e9fae8857buYbcUvmsw4".tr,
          "135f79ff4bmUUzrPouli".tr,
        ],
      ),
      HealthProgress(
        id: '4',
        metricType: HealthMetricType.weight,
        title: "88b9de4257ZIrtph2Loo".tr,
        description: "f7d0558341WTkkliVt4q".tr,
        currentValue: 65.0,
        previousValue: 66.2,
        targetValue: 63.0,
        unit: 'kg',
        date: DateTime.now().subtract(const Duration(days: 4)),
        trend: ProgressTrend.improving,
        improvementPercentage: 1.8,
        analysis: "f8aa3ea1893uAFCgvbJX".tr,
        recommendations: [
          "17f78f88b4gxWehsKqWD".tr,
          "175cbee403bPEKXCN07I".tr,
          "28cf543d80gHUAKe4ai4".tr,
        ],
      ),
      HealthProgress(
        id: '5',
        metricType: HealthMetricType.calories,
        title: "9be0ae5dfaYNpgY89sgH".tr,
        description: "5334660719qZJKaY9Rpo".tr,
        currentValue: 2200,
        previousValue: 1950,
        targetValue: 2000,
        unit: 'kcal',
        date: DateTime.now().subtract(const Duration(days: 5)),
        trend: ProgressTrend.improving,
        improvementPercentage: 12.8,
        analysis: "b09510af27MpQHqKRXeW".tr,
        recommendations: [
          "640ebdcd92qakRqbPyvO".tr,
          "7cae2f10b8PxP0srsx0z".tr,
          "277b8aae8acvhsR1HfDG".tr,
        ],
        isAchievement: true,
        achievementIcon: '🔥',
        achievementTitle: "88c3d10ccc3EJceHcUSA".tr,
      ),
      HealthProgress(
        id: '6',
        metricType: HealthMetricType.waterIntake,
        title: "47d2c054a8BQ7FocT9IF".tr,
        description: "8e78d4bb74BUgoGYA9We".tr,
        currentValue: 2.5,
        previousValue: 2.0,
        targetValue: 2.5,
        unit: 'L',
        date: DateTime.now().subtract(const Duration(days: 6)),
        trend: ProgressTrend.improving,
        improvementPercentage: 25.0,
        analysis: "d751029c205A7B6UEclh".tr,
        recommendations: [
          "bf53d41cd6BALnh5j3fZ".tr,
          "2829a5110enHatokYrV4".tr,
          "be251755bdVHeb377ILW".tr,
        ],
      ),
    ];
  }

  Future<void> _loadMockGoalsData() async {
    await Future.delayed(const Duration(milliseconds: 200));

    _goals = [
      HealthGoal(
        id: '1',
        metricType: HealthMetricType.steps,
        title: "ea202fd4ae7LPdu5alpO".tr,
        description: "613bf827f0IUj1oJnhdv".tr,
        targetValue: 10000,
        currentValue: 8500,
        unit: "a621b7cd7aIzkSO4yvHs".tr,
        targetDate: DateTime.now().add(const Duration(days: 30)),
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
        progressPercentage: 85.0,
      ),
      HealthGoal(
        id: '2',
        metricType: HealthMetricType.weight,
        title: "4c3da923218vohaUTtC3".tr,
        description: "2e9749f61c61WL0ToyDr".tr,
        targetValue: 63.0,
        currentValue: 65.0,
        unit: 'kg',
        targetDate: DateTime.now().add(const Duration(days: 60)),
        createdAt: DateTime.now().subtract(const Duration(days: 14)),
        progressPercentage: 66.7,
      ),
      HealthGoal(
        id: '3',
        metricType: HealthMetricType.sleepHours,
        title: "20df84b83afU4bhual8r".tr,
        description: "7588d90ecfpv8RtuxUTK".tr,
        targetValue: 8.0,
        currentValue: 7.5,
        unit: "3b6fefc50fQrvFiiGFu0".tr,
        targetDate: DateTime.now().add(const Duration(days: 21)),
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        progressPercentage: 93.8,
      ),
    ];
  }

  void dispose() {
    _progressController.close();
    _goalsController.close();
    _summaryController.close();
  }
}
