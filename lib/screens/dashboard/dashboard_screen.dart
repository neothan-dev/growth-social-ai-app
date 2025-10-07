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
import 'package:provider/provider.dart';
import '../../models/dashboard_card_model.dart';
import '../../models/user_dashboard_config.dart';
import '../../widgets/blur_background_container.dart';
import '../../widgets/glassmorphism_app_bar.dart';
import '../../utils/asset_manager.dart';
import '../../services/user_manager.dart';
import '../../models/user.dart';
import 'dashboard_section.dart';
import 'cards/steps_card.dart';
import 'cards/weather_card.dart';
import 'cards/sleep_card.dart';
import 'cards/body_metrics_card.dart';
import 'cards/recipe_card.dart';
import 'cards/horizontal_scroll_cards.dart';
import 'cards/todo_list_card.dart';
import 'cards/blood_pressure_card.dart';
import 'cards/blood_sugar_card.dart';
import 'cards/exercise_card.dart';
import 'cards/water_intake_card.dart';
import 'cards/mood_card.dart';
import 'cards/health_summary_card.dart';
import 'cards/dashboard_summary_card.dart';
import 'cards/achievement_card.dart';
import 'cards/motivation_card.dart';
import 'cards/health_tip_card.dart';
import 'cards/community_activity_card.dart';
import 'cards/fitness_plan_card.dart';
import '../../localization/app_localizations.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _showVoiceChatTip = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVoiceChatTip();
    });
  }

  void _checkVoiceChatTip() async {
    final userManager = Provider.of<UserManager>(context, listen: false);
    final hasShownDashboardVoiceChatTip =
        await userManager.HasShownDashboardVoiceChatTip();
    bool hasShownVoiceChatTip = await userManager.HasShownVoiceChatTip();

    if (mounted && !hasShownDashboardVoiceChatTip && hasShownVoiceChatTip) {
      setState(() {
        _showVoiceChatTip = true;
      });

      await userManager.ShowDashboardVoiceChatTip();

      Future.delayed(Duration(seconds: 10), () {
        if (mounted) {
          setState(() {
            _showVoiceChatTip = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userConfig = UserDashboardConfig.defaultConfig();

    final stepsCard = StepsCard();
    final weatherCard = WeatherCard();

    final customCards = <Widget>[];
    if (userConfig.customCards.contains(DashboardCardType.sleep)) {
      customCards.add(SleepCard());
    }
    if (userConfig.customCards.contains(DashboardCardType.bodyMetrics)) {
      customCards.add(BodyMetricsCard());
    }
    if (userConfig.customCards.contains(DashboardCardType.bloodPressure)) {
      customCards.add(BloodPressureCard());
    }
    if (userConfig.customCards.contains(DashboardCardType.bloodSugar)) {
      customCards.add(BloodSugarCard());
    }
    if (userConfig.customCards.contains(DashboardCardType.exercise)) {
      customCards.add(ExerciseCard());
    }
    if (userConfig.customCards.contains(DashboardCardType.waterIntake)) {
      customCards.add(WaterIntakeCard());
    }
    if (userConfig.customCards.contains(DashboardCardType.mood)) {
      customCards.add(MoodCard());
    }
    if (userConfig.customCards.contains(DashboardCardType.healthSummary)) {
      customCards.add(HealthSummaryCard());
    }

    List<Widget> leftColumn = [];
    List<Widget> rightColumn = [];
    int leftHeight = 0, rightHeight = 0;
    for (var card in customCards) {
      if (leftHeight <= rightHeight) {
        leftColumn.add(card);
        leftHeight += 2;
      } else {
        rightColumn.add(card);
        rightHeight += 2;
      }
    }

    final recipeCard = RecipeCard();

    return Consumer<UserManager>(
      builder: (context, userManager, child) {
        final user = userManager.currentUser;

        return Scaffold(
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              _buildPageContent(
                context,
                user,
                stepsCard,
                weatherCard,
                leftColumn,
                rightColumn,
                recipeCard,
              ),
              _buildGlassmorphismAppBar(context, user),
              if (_showVoiceChatTip) _buildVoiceChatTip(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPageContent(
    BuildContext context,
    User? user,
    Widget stepsCard,
    Widget weatherCard,
    List<Widget> leftColumn,
    List<Widget> rightColumn,
    Widget recipeCard,
  ) {
    // 模拟健康数据
    final healthData = {
      'steps': 8500,
      'sleep': 7.5,
      'water': 1200,
      'mood': 8,
      'exercise': 45,
      'healthScore': 85,
    };

    return GlassmorphismBackgroundContainer(
      backgroundName: AppBackgrounds.dashboardBackground,
      blurSigma: 1.5,
      glassOpacity: 0.15,
      overlayColor: Colors.black.withValues(alpha: 0.2),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top + kToolbarHeight),
          Expanded(
            child: SafeArea(
              top: false,
              child: ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  // 顶部总结模块
                  DashboardSummaryCard(healthData: healthData),

                  // 水平滑动卡片区域
                  DashboardSection(children: [const HorizontalScrollCards()]),

                  // 激励卡片
                  DashboardSection(
                    children: [MotivationCard(motivationData: healthData)],
                  ),

                  // 步数卡片
                  // DashboardSection(children: [stepsCard]),

                  // 左右两列布局 - 健康数据卡片
                  DashboardSection(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: Column(children: leftColumn)),
                          const SizedBox(width: 12),
                          Expanded(child: Column(children: rightColumn)),
                        ],
                      ),
                    ],
                  ),

                  // 健身计划卡片
                  DashboardSection(
                    children: [FitnessPlanCard(fitnessData: healthData)],
                  ),

                  // 社区活动卡片
                  DashboardSection(children: [const CommunityActivityCard()]),

                  // 成就和健康建议并排
                  DashboardSection(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AchievementCard(achievementData: healthData),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: HealthTipCard(healthData: healthData),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // 待办事项
                  DashboardSection(children: [TodoListCard()]),

                  // 天气和食谱并排
                  // DashboardSection(
                  //   children: [
                  //     Row(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Expanded(child: weatherCard),
                  //         const SizedBox(width: 12),
                  //         Expanded(child: recipeCard),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassmorphismAppBar(BuildContext context, User? user) {
    return GlassmorphismAppBar(
      leading: _buildAvatarButton(context, user),
      title: _buildTitle(user),
      actions: [_buildVoiceChatButton(context), _buildSettingsButton(context)],
      backgroundColor: const Color.fromARGB(255, 197, 238, 150),
      blurRadius: 20.0,
      opacity: 0.001,
    );
  }

  Widget _buildAvatarButton(BuildContext context, User? user) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/user_profile_screen'),
      child: Container(
        margin: const EdgeInsets.all(8),
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white.withValues(alpha: 0.2),
          foregroundImage: const AssetImage('assets/images/avatar/avatar6.jpg'),
          child: const Icon(Icons.person, size: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildTitle(User? user) {
    return Row(
      children: [
        const Icon(Icons.health_and_safety, color: Colors.white, size: 24),
        const SizedBox(width: 8),
        Text(
          "707f709afbm0zZXZjpBc".tr +
              '${user?.displayName ?? "0d0e1a86b3HWgynGJLJv".tr}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildVoiceChatButton(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pushNamed(context, '/voice_chat_screen'),
      icon: const Icon(Icons.support_agent, color: Colors.white, size: 24),
      tooltip: '语音聊天',
    );
  }

  Widget _buildSettingsButton(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pushNamed(context, '/settings_screen'),
      icon: const Icon(Icons.settings, color: Colors.white, size: 24),
    );
  }

  Widget _buildVoiceChatTip() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + kToolbarHeight + 20,
      left: 16,
      right: 16,
      child: AnimatedOpacity(
        opacity: _showVoiceChatTip ? 1.0 : 0.0,
        duration: Duration(milliseconds: 300),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.withValues(alpha: 0.9),
                Colors.blue.withValues(alpha: 0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.mic, color: Colors.white, size: 24),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "d030cf9b3062KaAm0iVa".tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "1450e3ac657BQGiUibgu".tr,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _showVoiceChatTip = false;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
