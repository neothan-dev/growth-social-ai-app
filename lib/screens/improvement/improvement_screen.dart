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
import '../../models/health_progress.dart';
import '../../services/health_progress_service.dart';
import '../../widgets/blur_background_container.dart';
import '../../widgets/glassmorphism_app_bar.dart';
import '../../theme/app_theme.dart';
import '../../utils/asset_manager.dart';
import '../../localization/app_localizations.dart';

class ImprovementScreen extends StatefulWidget {
  const ImprovementScreen({super.key});

  @override
  State<ImprovementScreen> createState() => _ImprovementScreenState();
}

class _ImprovementScreenState extends State<ImprovementScreen>
    with TickerProviderStateMixin {
  final HealthProgressService _progressService = HealthProgressService();

  late TabController _tabController;
  late AnimationController _fadeController;
  late AnimationController _slideController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  List<HealthProgress> _progressList = [];
  List<HealthGoal> _goals = [];
  HealthProgressSummary? _summary;

  bool _isLoading = true;

  // 开发者可配置的背景图片路径
  static const String? _cardBackgroundImage =
      "assets/images/improvement/letter.jpg";

  // 数据支持卡片的背景图片
  static const String? _dataCardBackgroundImage =
      "assets/images/improvement/data.jpg"; // 设置为 null 使用默认渐变，或设置图片路径

  // 建议卡片的背景图片
  static const String? _recommendationsCardBackgroundImage =
      "assets/images/improvement/goal.jpg"; // 设置为 null 使用默认渐变，或设置图片路径

  // 成就卡片的背景图片
  static const String? _achievementCardBackgroundImage =
      "assets/images/improvement/achievements_card.jpg"; // 设置为 null 使用默认渐变，或设置图片路径

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _initializeAnimations();
    _loadData();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOutCubic),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (mounted) {
      _fadeController.forward();
      _slideController.forward();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlassmorphismBackgroundContainer(
        backgroundName: AppBackgrounds.improvementBackground,
        blurSigma: 3.0,
        glassOpacity: 0.01,
        overlayColor: Colors.black.withValues(alpha: 0.1),
        child: Stack(
          children: [
            // 主要内容
            Column(
              children: [
                // 为 AppBar 预留空间
                SizedBox(
                  height: kToolbarHeight + MediaQuery.of(context).padding.top,
                ),
                Expanded(
                  child: _isLoading ? _buildLoadingView() : _buildTabView(),
                ),
              ],
            ),
            // AppBar 直接放在 Stack 中
            _buildGlassmorphismAppBar(),
            // 浮动操作按钮
            Positioned(
              bottom: 24,
              right: 24,
              child: _buildFloatingActionButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassmorphismAppBar() {
    return GlassmorphismAppBar(
      leading: _buildAvatarButton(),
      title: _buildTitle(),
      actions: _buildActions(),
      backgroundColor: const Color.fromARGB(255, 76, 175, 80),
      blurRadius: 20.0,
      opacity: 0.001,
    );
  }

  Widget _buildAvatarButton() {
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

  Widget _buildTitle() {
    return Row(
      children: [
        const Icon(Icons.trending_up, color: Colors.white, size: 24),
        const SizedBox(width: 8),
        Text(
          "21fbaf2a22OhLO74j9Uk".tr,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildActions() {
    return [
      IconButton(
        icon: const Icon(Icons.support_agent, color: Colors.white, size: 24),
        onPressed: () => Navigator.pushNamed(context, '/voice_chat_screen'),
        tooltip: "b03bba3614LC5vGo7kJ8".tr,
      ),
      IconButton(
        icon: const Icon(Icons.filter_list, color: Colors.white, size: 24),
        onPressed: _showFilterDialog,
      ),
      PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert, color: Colors.white, size: 24),
        onSelected: _handleMenuAction,
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 'add_goal',
            child: Row(
              children: [
                Icon(Icons.flag, color: AppTheme.primary),
                const SizedBox(width: 8),
                Text("e157145c54Bkhsqy0XYE".tr),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'export',
            child: Row(
              children: [
                Icon(Icons.download, color: AppTheme.secondary),
                const SizedBox(width: 8),
                Text("e86dd4d004EjktdMK4he".tr),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'settings',
            child: Row(
              children: [
                Icon(Icons.settings, color: AppTheme.info),
                const SizedBox(width: 8),
                Text("df3d58c7d8OBUkPnB2cw".tr),
              ],
            ),
          ),
        ],
      ),
    ];
  }

  Widget _buildTabView() {
    return _buildUnifiedView();
  }

  /// 构建统一的融合视图
  Widget _buildUnifiedView() {
    if (_summary == null) {
      return _buildEmptyState(
        icon: Icons.analytics_outlined,
        title: "497c85690csW6GfawhAX".tr,
        subtitle: "ec7509432cxAMr1j0fIh".tr,
      );
    }

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // 第一个卡片：好友语气的进步总结
              _buildFriendlySummaryCard(backgroundImage: _cardBackgroundImage),
              const SizedBox(height: 16),

              // 第二个卡片：数据支持解释
              _buildDataSupportCard(backgroundImage: _dataCardBackgroundImage),
              const SizedBox(height: 16),

              // 第三个卡片：具体建议
              _buildRecommendationsCard(
                backgroundImage: _recommendationsCardBackgroundImage,
              ),
              const SizedBox(height: 16),

              // 成就展示区域
              _buildAchievementsSection(),
              const SizedBox(height: 16),

              // 目标展示区域
              _buildGoalsSection(),
              const SizedBox(height: 100), // 为浮动按钮留出空间
            ],
          ),
        ),
      ),
    );
  }

  /// 构建好友语气的进步总结卡片
  Widget _buildFriendlySummaryCard({String? backgroundImage}) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.2),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // 背景图片或渐变背景
            if (backgroundImage != null)
              Positioned.fill(
                child: Image.asset(
                  backgroundImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    debugPrint("c5102941cdnnTgKxVn8T".tr + '$backgroundImage');
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.green.withValues(alpha: 0.25),
                            Colors.green.withValues(alpha: 0.15),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    );
                  },
                ),
              )
            else
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.withValues(alpha: 0.25),
                      Colors.green.withValues(alpha: 0.15),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            // 遮罩层
            if (backgroundImage != null)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(
                          255,
                          0,
                          0,
                          0,
                        ).withValues(alpha: 0.4),
                        const Color.fromARGB(255, 0, 0, 0).withValues(alpha: 0),
                        const Color.fromARGB(255, 0, 0, 0).withValues(alpha: 0),
                        const Color.fromARGB(255, 0, 0, 0).withValues(alpha: 0),
                        const Color.fromARGB(255, 0, 0, 0).withValues(alpha: 0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            // 内容层
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 顶部区域
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.green.withValues(alpha: 0.9),
                              Colors.green.withValues(alpha: 0.7),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withValues(alpha: 0.4),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            'assets/improvement_hero.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 24,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "b4c31d0461zudtgFOufq".tr,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "e7c6d1356fCczpAEydhQ".tr,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color.fromARGB(
                                255,
                                145,
                                255,
                                56,
                              ).withValues(alpha: 0.2),
                              const Color.fromARGB(
                                255,
                                63,
                                220,
                                48,
                              ).withValues(alpha: 0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color.fromARGB(
                              255,
                              90,
                              233,
                              34,
                            ).withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          "2c99de8357IdLrnRvGpv".tr,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 173, 255, 73),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // 好友语气的进步描述
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withValues(alpha: 0.15),
                          Colors.white.withValues(alpha: 0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: const Color.fromARGB(255, 176, 142, 8),
                          fontSize: 16,
                          height: 1.6,
                          fontFamily: 'PingFang SC',
                        ),
                        children: [
                          TextSpan(text: "4c6cdfa040nPAhkG7BTh".tr),
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () => _showAchievementDetail('energy'),
                              child: Text(
                                "8622f844bcOP3nWcdBpZ".tr,
                                style: TextStyle(
                                  color: Colors.amber[300],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.amber[300],
                                  decorationThickness: 1.5,
                                ),
                              ),
                            ),
                          ),
                          TextSpan(text: "b1c40c2de2VbHlK6ZMud".tr),
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () => _showAchievementDetail('mood'),
                              child: Text(
                                "b73849a8b2uq5cl0jDC5".tr,
                                style: TextStyle(
                                  color: Colors.lightGreen[300],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.lightGreen[300],
                                  decorationThickness: 1.5,
                                ),
                              ),
                            ),
                          ),
                          TextSpan(text: "7bc8f1b8b3GOi3toinyL".tr),
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () => _showAchievementDetail('sleep'),
                              child: Text(
                                "0d14fa3745ISl9xUBnRe".tr,
                                style: TextStyle(
                                  color: Colors.blue[300],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.blue[300],
                                  decorationThickness: 1.5,
                                ),
                              ),
                            ),
                          ),
                          TextSpan(text: "047a9134d56aOqQ8OT5A".tr),
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () => _showAchievementDetail('exercise'),
                              child: Text(
                                "8380a21077XKz61vwU4Q".tr,
                                style: TextStyle(
                                  color: Colors.orange[300],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.orange[300],
                                  decorationThickness: 1.5,
                                ),
                              ),
                            ),
                          ),
                          TextSpan(text: "f0d5d92615FUtG8zOnpy".tr),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建数据支持解释卡片
  Widget _buildDataSupportCard({String? backgroundImage}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // 背景图片或渐变背景
            if (backgroundImage != null)
              Positioned.fill(
                child: Image.asset(
                  backgroundImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    debugPrint("47f3b5afdeowSPHhnXIA".tr + '$backgroundImage');
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.withValues(alpha: 0.2),
                            Colors.blue.withValues(alpha: 0.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    );
                  },
                ),
              )
            else
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.withValues(alpha: 0.2),
                      Colors.blue.withValues(alpha: 0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            // 遮罩层
            if (backgroundImage != null)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(
                          255,
                          0,
                          0,
                          0,
                        ).withValues(alpha: 0.4),
                        const Color.fromARGB(
                          255,
                          0,
                          0,
                          0,
                        ).withValues(alpha: 0.3),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            // 内容层
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 标题区域
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.withValues(alpha: 0.8),
                              Colors.blue.withValues(alpha: 0.6),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/improvement_analytics.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.analytics,
                                color: Colors.white,
                                size: 20,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "a1c8900a965tPiO1yMcB".tr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "880b5b22b8v2abWsZ8NN".tr,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 数据解释项目
                  _buildDataItem(
                    "79115e8b3ei5IKHS67GV".tr,
                    "f0b23480823PxtWZHjQO".tr,
                    "9b0096d861VL9jqAIXGZ".tr,
                    "+15%",
                    const Color.fromARGB(255, 121, 238, 125),
                    "4c585a7dea6zgp8TfN30".tr,
                  ),
                  const SizedBox(height: 12),
                  _buildDataItem(
                    "5d211770bcJhcUMAhA50".tr,
                    "03601ee0462f6QhgZODk".tr,
                    "72 bpm",
                    "-8%",
                    const Color.fromARGB(255, 100, 184, 238),
                    "bac963f9778ovakxI4PV".tr,
                  ),
                  const SizedBox(height: 12),
                  _buildDataItem(
                    "c9e925e455EsWKtTxNRa".tr,
                    "98439c55d9s77ujFDqYA".tr,
                    "2575b164aetiWCiPA1Um".tr,
                    "+20%",
                    const Color.fromARGB(255, 149, 74, 241),
                    "b218432f1ekPGWs3E9mT".tr,
                  ),
                  const SizedBox(height: 12),
                  _buildDataItem(
                    "7fef83e893LHT8tNpf02".tr,
                    "4378bb2a59dYrkvHqFPA".tr,
                    "c7092c51fdX5F8TxvRjO".tr,
                    "+25%",
                    const Color.fromARGB(255, 251, 199, 67),
                    "8fe7145fd4CLqjSaSpjl".tr,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建数据项目
  Widget _buildDataItem(
    String emoji,
    String metric,
    String value,
    String change,
    Color color,
    String description,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.1),
            Colors.white.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Text(emoji, style: TextStyle(fontSize: 18, color: color)),
          const SizedBox(width: 25),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      metric,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: color.withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        change,
                        style: TextStyle(
                          color: color,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建具体建议卡片
  Widget _buildRecommendationsCard({String? backgroundImage}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.purple.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // 背景图片或渐变背景
            if (backgroundImage != null)
              Positioned.fill(
                child: Image.asset(
                  backgroundImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    debugPrint("2024b051d4VP5BgcKRn5".tr + '$backgroundImage');
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.purple.withValues(alpha: 0.2),
                            Colors.purple.withValues(alpha: 0.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    );
                  },
                ),
              )
            else
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.purple.withValues(alpha: 0.2),
                      Colors.purple.withValues(alpha: 0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            // 遮罩层
            if (backgroundImage != null)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(
                          255,
                          0,
                          0,
                          0,
                        ).withValues(alpha: 0.25),
                        const Color.fromARGB(
                          255,
                          0,
                          0,
                          0,
                        ).withValues(alpha: 0.0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            // 内容层
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 标题区域
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.purple.withValues(alpha: 0.8),
                              Colors.purple.withValues(alpha: 0.6),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/improvement_motivation.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.lightbulb,
                                color: Colors.white,
                                size: 20,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "04f4e0bfc45UUxRAP7TO".tr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "a8aa9d8e86NME97UlIoG".tr,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 建议项目
                  _buildRecommendationItem(
                    "🚶‍♂️",
                    "91c7d19429WNZ6TehWxl".tr,
                    "78088b879ff8GpOri0RN".tr,
                    "91db7eb0b5uoDtkeiBzv".tr,
                    const Color.fromARGB(255, 97, 239, 101),
                  ),
                  const SizedBox(height: 12),
                  _buildRecommendationItem(
                    "🧘‍♀️",
                    "7826dc60e7MAZv0k6BDU".tr,
                    "7d42b86498HJUOVNLByz".tr,
                    "bed79e7f63gk2XPTnbE9".tr,
                    const Color.fromARGB(255, 82, 237, 239),
                  ),
                  const SizedBox(height: 12),
                  _buildRecommendationItem(
                    "🌙",
                    "ebc3407839tgU7fIDZAB".tr,
                    "1f88ef8b6fGZn9mxgxKk".tr,
                    "37aac2adf6bRPCpw1jDQ".tr,
                    const Color.fromARGB(255, 204, 116, 248),
                  ),
                  const SizedBox(height: 12),
                  _buildRecommendationItem(
                    "🥗",
                    "c88b3ac3963Haa7ooPjM".tr,
                    "6047faf107xjg2tTWilj".tr,
                    "3f6a95f0c8DoZz92VPkj".tr,
                    const Color.fromARGB(255, 255, 155, 41),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建建议项目
  Widget _buildRecommendationItem(
    String emoji,
    String title,
    String mainTip,
    String detailTip,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.1),
            Colors.white.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 10),
          Text(
            emoji,
            style: TextStyle(
              fontSize: 40,
              color: color,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(width: 23),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  mainTip,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  detailTip,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建目标展示区域
  Widget _buildGoalsSection() {
    if (_goals.isEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withValues(alpha: 0.1),
              Colors.white.withValues(alpha: 0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.purple.withValues(alpha: 0.3),
                    Colors.purple.withValues(alpha: 0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/improvement_goal.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.flag,
                      color: Colors.white,
                      size: 24,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "7efe713d47eXFLsvwkxX".tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "62a208476abRVVJeQESH".tr,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.purple.withValues(alpha: 0.8),
                      Colors.purple.withValues(alpha: 0.6),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/improvement_goal.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.flag,
                        color: Colors.white,
                        size: 20,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "1a5c5513b51kTLFNx3SZ".tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "2428420e40oKFLJKnipJ".tr +
                          '${_goals.length}' +
                          "ff28267e07HM5aOjIhO4".tr,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // 显示前3个目标
          ...(_goals
              .take(3)
              .map(
                (goal) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: _buildCompactGoalCard(goal),
                ),
              )),
          if (_goals.length > 3)
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Center(
                child: Text(
                  "1a1f6f3d08OVidvfF87S".tr +
                      '${_goals.length - 3}' +
                      "faf17740e7nZ3nVBgmZ2".tr,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 12,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// 构建紧凑的目标卡片
  Widget _buildCompactGoalCard(HealthGoal goal) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 38, 255, 5).withValues(alpha: 0.3),
            const Color.fromARGB(255, 38, 255, 5).withValues(alpha: 0.1),
            const Color.fromARGB(255, 38, 255, 5).withValues(alpha: 0.01),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: _getGoalStatusColor(goal.goalStatus),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  goal.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${goal.currentValue.toStringAsFixed(0)}' +
                      ' ' +
                      '${goal.unit}' +
                      ' / ' +
                      '${goal.targetValue.toStringAsFixed(0)}' +
                      ' ' +
                      '${goal.unit}',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _getGoalStatusColor(
                goal.goalStatus,
              ).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _getGoalStatusColor(
                  goal.goalStatus,
                ).withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              '${goal.progressPercentage.toStringAsFixed(0)}' + ' ' + '%',
              style: TextStyle(
                color: _getGoalStatusColor(goal.goalStatus),
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.withValues(alpha: 0.9),
            Colors.green.withValues(alpha: 0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: _showAddProgressDialog,
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withValues(alpha: 0.2),
                Colors.white.withValues(alpha: 0.1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 背景图片
              ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Image.asset(
                  'assets/improvement_goal.png',
                  fit: BoxFit.cover,
                  width: 56,
                  height: 56,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox.shrink();
                  },
                ),
              ),
              // 添加图标
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(Icons.add, color: Colors.green, size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建加载视图
  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 加载动画容器
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green.withValues(alpha: 0.8),
                  Colors.green.withValues(alpha: 0.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(60),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 背景图片
                ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.asset(
                    'assets/improvement_hero.png',
                    fit: BoxFit.cover,
                    width: 120,
                    height: 120,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                // 加载图标
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.trending_up,
                    color: Colors.green,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // 加载文本
          Text(
            "9dc0825fbaOjDODqgn1q".tr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "9e6a02a8d8STtczQMLdY".tr,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          // 加载指示器
          Container(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.green.withValues(alpha: 0.8),
              ),
              strokeWidth: 3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 空状态图片容器
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.15),
                  Colors.white.withValues(alpha: 0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(60),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 背景图片
                ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.asset(
                    'assets/improvement_insight.png',
                    fit: BoxFit.cover,
                    width: 120,
                    height: 120,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                // 图标覆盖层
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    icon,
                    size: 30,
                    color: Colors.grey.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // 标题
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          // 副标题
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          // 建议操作按钮
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green.withValues(alpha: 0.8),
                  Colors.green.withValues(alpha: 0.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add_circle_outline, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  "c9922b63c5ubOcFdkgX7".tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsSection() {
    final achievements = _progressList.where((p) => p.isAchievement).toList();

    if (achievements.isEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withValues(alpha: 0.1),
              Colors.white.withValues(alpha: 0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange.withValues(alpha: 0.3),
                    Colors.orange.withValues(alpha: 0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/improvement_celebration.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.celebration,
                      color: Colors.white,
                      size: 30,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "80a373273ddA7dD7Wgbu".tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "8900a71f0abE0TZb19h4".tr,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.orange.withValues(alpha: 0.8),
                      Colors.orange.withValues(alpha: 0.6),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/improvement_celebration.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.celebration,
                        color: Colors.white,
                        size: 20,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "52b0e1703djEDrwKtOHZ".tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "313681a131DSDZAbWE6w".tr +
                          '${achievements.length}' +
                          "e4945f55acp2AjdUcFt3".tr,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: achievements.length,
              itemBuilder: (context, index) {
                final achievement = achievements[index];
                return Container(
                  width: 220,
                  margin: const EdgeInsets.only(right: 16),
                  child: _buildAchievementCard(
                    achievement,
                    backgroundImage: _achievementCardBackgroundImage,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 构建成就卡片
  Widget _buildAchievementCard(
    HealthProgress achievement, {
    String? backgroundImage,
  }) {
    return GestureDetector(
      onTap: () => _openProgressDetail(achievement),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 100,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // 背景图片或渐变背景
              if (backgroundImage != null)
                Positioned.fill(
                  child: Image.asset(
                    backgroundImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      debugPrint(
                        "e72e2eca9cQ2msbiHLDW".tr + '$backgroundImage',
                      );
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withValues(alpha: 0.2),
                              Colors.white.withValues(alpha: 0.1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      );
                    },
                  ),
                )
              else
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.2),
                        Colors.white.withValues(alpha: 0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              // 遮罩层
              if (backgroundImage != null)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(
                            255,
                            0,
                            0,
                            0,
                          ).withValues(alpha: 0.3),
                          const Color.fromARGB(
                            255,
                            0,
                            0,
                            0,
                          ).withValues(alpha: 0.1),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
              // 内容层
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 顶部区域
                    Row(
                      children: [
                        // 成就图片容器
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                achievement.trendColor.withValues(alpha: 0.9),
                                achievement.trendColor.withValues(alpha: 0.7),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: achievement.trendColor.withValues(
                                  alpha: 0.4,
                                ),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'assets/improvement_achievement.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  achievement.metricIcon,
                                  color: Colors.white,
                                  size: 18,
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                achievement.title,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                achievement.description,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white.withValues(alpha: 0.8),
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                        // 成就徽章
                        if (achievement.isAchievement &&
                            achievement.achievementIcon != null)
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.orange.withValues(alpha: 0.3),
                                  Colors.orange.withValues(alpha: 0.2),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.orange.withValues(alpha: 0.4),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.orange.withValues(alpha: 0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Text(
                              achievement.achievementIcon!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 7),

                    // 进度信息
                    Container(
                      padding: const EdgeInsets.fromLTRB(13, 5, 13, 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0.15),
                            Colors.white.withValues(alpha: 0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${achievement.currentValue.toStringAsFixed(1)}' +
                                      ' ' +
                                      '${achievement.unit}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  _getTrendDescription(achievement.trend),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: achievement.trendColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  achievement.trendColor.withValues(alpha: 0.3),
                                  achievement.trendColor.withValues(alpha: 0.2),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: achievement.trendColor.withValues(
                                    alpha: 0.2,
                                  ),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: achievement.trendColor,
                              size: 14,
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
        ),
      ),
    );
  }

  /// 获取趋势描述
  String _getTrendDescription(ProgressTrend trend) {
    switch (trend) {
      case ProgressTrend.improving:
        return "cb442ceea9ICCWHGfVfN".tr;
      case ProgressTrend.declining:
        return "d0c1baf151pYDoayIyEy".tr;
      case ProgressTrend.stable:
        return "8d972cf006xHmGHOgLdH".tr;
      case ProgressTrend.fluctuating:
        return "e424a882c0PBWGO93eAC".tr;
    }
  }

  /// 获取目标状态颜色
  Color _getGoalStatusColor(String status) {
    if (status.toLowerCase() == "dc9591e56deG7CNxA7Pt".tr) {
      return Colors.blue;
    } else if (status.toLowerCase() == "f28461bb491Yj9pxyIMr".tr) {
      return Colors.green;
    } else if (status.toLowerCase() == "f6e0d6919fqiAFPjvkY4".tr) {
      return Colors.grey;
    } else if (status.toLowerCase() == "eb0c326b607jDKgDfjQX".tr) {
      return Colors.orange;
    } else {
      return const Color.fromARGB(255, 230, 120, 250);
    }
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    try {
      final futures = await Future.wait([
        _progressService.getProgressList(),
        _progressService.getGoals(),
        _progressService.getSummary(),
      ]);

      _progressList = futures[0] as List<HealthProgress>;
      _goals = futures[1] as List<HealthGoal>;
      _summary = futures[2] as HealthProgressSummary?;
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("08417baa06J1IeiTUjAJ".tr + '$e')));
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _openProgressDetail(HealthProgress progress) {
    Navigator.of(
      context,
    ).pushNamed('/progress_detail_screen', arguments: progress);
  }

  void _showAddProgressDialog() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("925de7f192VYtwKw7r29".tr)));
  }

  void _showFilterDialog() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("091ba362a7tmdpanf1tf".tr)));
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'add_goal':
        _showAddGoalDialog();
        break;
      case 'export':
        _exportData();
        break;
      case 'settings':
        _showSettings();
        break;
    }
  }

  void _showAddGoalDialog() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("555e1f20cfzIYAWvXGSW".tr)));
  }

  void _exportData() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("21550aa350oElfx9zlYe".tr)));
  }

  void _showSettings() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("ac2fbb0976CbulJsEYKu".tr)));
  }

  /// 显示成就详情
  void _showAchievementDetail(String achievementType) {
    Map<String, Map<String, dynamic>> achievementData = {
      'energy': {
        'title': "2d462778cb0T2sxYIsIC".tr,
        'description': "f8316930b3hmJp38jELL".tr,
        'details': [
          "6bf8127061y1fls7J0xj".tr,
          "18dee92110ohyFTREpei".tr,
          "7b0a53ac19r7m8NcCkZg".tr,
          "0b588c8c9bH5RT5mUd1k".tr,
        ],
        'tips': [
          "a405673433NviN7MdP26".tr,
          "05edcc943a7uvKa9PqoK".tr,
          "d9c62e051a4nUDAZs9sz".tr,
        ],
        'color': Colors.amber,
        'icon': '💪',
      },
      'mood': {
        'title': "d1b6f5e4d5vGJGJyXZHG".tr,
        'description': "ee2b3941d7PbqO7SsO8m".tr,
        'details': [
          "bc18a5cef4cr3kiuNgIH".tr,
          "21773f8687e1RAOblx4t".tr,
          "f2e912c9b7a3afFWhR4h".tr,
          "de41d84fdaKcMeSC1eU7".tr,
        ],
        'tips': [
          "be8474fafcJNHnYA3KBd".tr,
          "5e7b6ec463PqbGqUpX8u".tr,
          "c19ac3b6a68UVFeAHFdB".tr,
        ],
        'color': Colors.lightGreen,
        'icon': '😌',
      },
      'sleep': {
        'title': "256e89533cm0UmKo0xwt".tr,
        'description': "379f93c5e4MH4W3UQbU5".tr,
        'details': [
          "484c0e23a703w4e4d08N".tr,
          "aa50efd4a3A7hgxgLzz8".tr,
          "3881453192Yi5YXbm8D3".tr,
          "7dc7ac0f16TK1PC0Kqx0".tr,
        ],
        'tips': [
          "7b2d940a3cBi2OVc08bg".tr,
          "37aac2adf6RlkYsdkSqr".tr,
          "135f79ff4bLgmFysZ1if".tr,
        ],
        'color': Colors.blue,
        'icon': '😴',
      },
      'exercise': {
        'title': "30dbda6ac4g9YDoDMojy".tr,
        'description': "f8db9604b3haWubRwSmG".tr,
        'details': [
          "8fe7145fd4Qyb1NoOFnI".tr,
          "06625cf218WOMk89EHMm".tr,
          "7169c31b52H7E8sxWddk".tr,
          "5388b8adebec7JRIeWS6".tr,
        ],
        'tips': [
          "525a67e598g68iQo5pDN".tr,
          "f44101edc04YDfOxEVZd".tr,
          "073b5fb37e4kuf9d8gfm".tr,
        ],
        'color': Colors.orange,
        'icon': '🏃‍♂️',
      },
    };

    final data = achievementData[achievementType];
    if (data == null) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white.withValues(alpha: 0.95),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    data['color'].withValues(alpha: 0.8),
                    data['color'].withValues(alpha: 0.6),
                  ],
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: data['color'].withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Center(
                child: Text(data['icon'], style: const TextStyle(fontSize: 24)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                data['title'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 成就描述
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: data['color'].withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: data['color'].withValues(alpha: 0.2),
                  ),
                ),
                child: Text(
                  data['description'],
                  style: TextStyle(
                    color: data['color'],
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 详细数据
              Text(
                "9045012dcbLShN7v2Fhq".tr,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              ...data['details'].map<Widget>(
                (detail) => Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.only(top: 6, right: 8),
                        decoration: BoxDecoration(
                          color: data['color'],
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          detail,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 建议
              Text(
                "b4439cba527ZlUVLbimp".tr,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              ...data['tips'].map<Widget>(
                (tip) => Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.only(top: 6, right: 8),
                        decoration: BoxDecoration(
                          color: data['color'],
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          tip,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "de32e20193otR9DnVRiF".tr,
              style: TextStyle(
                color: data['color'],
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
