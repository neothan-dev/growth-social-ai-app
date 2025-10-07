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
import '../../../utils/haptic_feedback_helper.dart';
import '../../../widgets/blur_background_container.dart';
import '../../../utils/asset_manager.dart';
import '../../../localization/app_localizations.dart';

class AchievementsHubScreen extends StatefulWidget {
  const AchievementsHubScreen({super.key});

  @override
  State<AchievementsHubScreen> createState() => _AchievementsHubScreenState();
}

class _AchievementsHubScreenState extends State<AchievementsHubScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<AchievementItem> _achievements = [];
  bool _isLoading = true;
  String _selectedCategory = "5c55a67935iOL3edWxOU".tr;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadMockData();
    _startAnimations();
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
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (mounted) {
      _fadeController.forward();
      _slideController.forward();
    }
  }

  void _loadMockData() {
    _achievements.addAll([
      AchievementItem(
        id: '1',
        title: "91c47e014elkHxsc9Ey5".tr,
        description: "be922b64f7YFtH152bQn".tr,
        icon: Icons.directions_run,
        category: AchievementCategory.fitness,
        rarity: AchievementRarity.common,
        isUnlocked: true,
        unlockedAt: DateTime.now().subtract(const Duration(days: 5)),
        progress: 100,
        target: 100,
        reward: "82388a480drA7AsJTA6z".tr,
        color: Colors.blue,
      ),
      AchievementItem(
        id: '2',
        title: "1f33792d3a1Va6YM8Y5W".tr,
        description: "1ff0affd3ayAnGaUw6sE".tr,
        icon: Icons.restaurant,
        category: AchievementCategory.nutrition,
        rarity: AchievementRarity.rare,
        isUnlocked: true,
        unlockedAt: DateTime.now().subtract(const Duration(days: 2)),
        progress: 7,
        target: 7,
        reward: "59d84a23b3KG0ZqxTZr4".tr,
        color: Colors.green,
      ),
      AchievementItem(
        id: '3',
        title: "d3d978807fsk2Nm2F1se".tr,
        description: "b885fca37biDqX2VthG9".tr,
        icon: Icons.school,
        category: AchievementCategory.learning,
        rarity: AchievementRarity.epic,
        isUnlocked: false,
        unlockedAt: null,
        progress: 6,
        target: 10,
        reward: "0926b2c42d3NeXNUWxJq".tr,
        color: Colors.purple,
      ),
      AchievementItem(
        id: '4',
        title: "750236442cYoKlkl4nCl".tr,
        description: "19fdd7cf9fWSpbigU9kT".tr,
        icon: Icons.wb_sunny,
        category: AchievementCategory.lifestyle,
        rarity: AchievementRarity.legendary,
        isUnlocked: false,
        unlockedAt: null,
        progress: 15,
        target: 30,
        reward: "882ad99b5aMJ4z3FzxHR".tr,
        color: Colors.amber,
      ),
      AchievementItem(
        id: '5',
        title: "99193fb765LqsiOPLlrL".tr,
        description: "37305c36bcRTBZBiJOYs".tr,
        icon: Icons.fitness_center,
        category: AchievementCategory.fitness,
        rarity: AchievementRarity.common,
        isUnlocked: true,
        unlockedAt: DateTime.now().subtract(const Duration(days: 30)),
        progress: 1,
        target: 1,
        reward: "0d310d742aD5HcFXaWip".tr,
        color: Colors.orange,
      ),
      AchievementItem(
        id: '6',
        title: "fceaa983f8CgikWEGAvc".tr,
        description: "52bde9cbecJVmyHMTi9a".tr,
        icon: Icons.article,
        category: AchievementCategory.learning,
        rarity: AchievementRarity.rare,
        isUnlocked: false,
        unlockedAt: null,
        progress: 23,
        target: 50,
        reward: "03ef184b7da2nT4JnxMJ".tr,
        color: Colors.indigo,
      ),
      AchievementItem(
        id: '7',
        title: "6f6692bbc8XcIa6ownJz".tr,
        description: "9031f65f06s8qrOmRaWA".tr,
        icon: Icons.bedtime,
        category: AchievementCategory.lifestyle,
        rarity: AchievementRarity.epic,
        isUnlocked: false,
        unlockedAt: null,
        progress: 8,
        target: 14,
        reward: "4f8ddbf18fgjRo6vYOYM".tr,
        color: Colors.teal,
      ),
      AchievementItem(
        id: '8',
        title: "9b4504868fjPhzl8UuHj".tr,
        description: "ad712b680dtPROEb3q7O".tr,
        icon: Icons.health_and_safety,
        category: AchievementCategory.overall,
        rarity: AchievementRarity.legendary,
        isUnlocked: false,
        unlockedAt: null,
        progress: 45,
        target: 100,
        reward: "55dce255a4thxE89S8wB".tr,
        color: Colors.red,
      ),
    ]);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlassmorphismBackgroundContainer(
        backgroundName: AppBackgrounds.societyBackground,
        blurSigma: 7.0,
        glassOpacity: 0.01,
        overlayColor: Colors.black.withValues(alpha: 0.1),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                children: [
                  _buildAppBar(),
                  _buildCategoryTabs(),
                  const SizedBox(height: 15),
                  Expanded(
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : _buildAchievementList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20,
              ),
            ),
            onPressed: () {
              HapticFeedbackHelper.lightImpact();
              Navigator.pop(context);
            },
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "d166ed9d311iMiNsqM1N".tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.emoji_events,
                color: Colors.white,
                size: 20,
              ),
            ),
            onPressed: () {
              HapticFeedbackHelper.lightImpact();
              _showAchievementStats();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    final unlockedCount = _achievements.where((a) => a.isUnlocked).length;
    final totalCount = _achievements.length;
    final progress = totalCount > 0 ? (unlockedCount / totalCount) : 0.0;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.amber.withValues(alpha: 0.8),
            Colors.orange.withValues(alpha: 0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.emoji_events,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "2ca95d29fbNOwQCRugFs".tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "50e4c5b480ksRRutjY7E".tr +
                          "$unlockedCount/$totalCount" +
                          "e4945f55ac5cjsSdSjAO".tr,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white.withValues(alpha: 0.3),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            minHeight: 8,
          ),
          const SizedBox(height: 8),
          Text(
            "${(progress * 100).toInt()}% " + "c0b3fbff51K5s6M49OgE".tr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    final categories = [
      "5c55a67935MAn769TuWt".tr,
      "5d925cc69d3rlFGPTths".tr,
      "fd8f627cc14LQ1ZWMqq3".tr,
      "2118cbc109sSpoYJOk4E".tr,
      "15d208d1b4lWuqKpRQPG".tr,
      "4a0d4edef9dOKJ6OhVJV".tr,
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategory == category;
          return _buildCategoryChip(category, isSelected);
        },
      ),
    );
  }

  Widget _buildCategoryChip(String category, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(
          category,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : Colors.white.withValues(alpha: 0.8),
            fontSize: 14,
          ),
        ),
        selected: isSelected,
        onSelected: (selected) {
          HapticFeedbackHelper.lightImpact();
          setState(() {
            _selectedCategory = category;
          });
        },
        backgroundColor: Colors.amber.withValues(alpha: 0.9),
        selectedColor: Colors.amber.withValues(alpha: 0.8),
        checkmarkColor: Colors.white,
        side: BorderSide(
          color: isSelected
              ? Colors.amber.withValues(alpha: 0.8)
              : Colors.amber.withValues(alpha: 0.3),
        ),
      ),
    );
  }

  Widget _buildAchievementList() {
    final filteredAchievements = _selectedCategory == "5c55a679353GZyYnTm8V".tr
        ? _achievements
        : _achievements
              .where(
                (achievement) =>
                    _getCategoryDisplayName(achievement.category) ==
                    _selectedCategory,
              )
              .toList();

    return CustomScrollView(
      slivers: [
        _buildMedalWall(),
        _buildAchievementGrid(filteredAchievements),
        SliverToBoxAdapter(child: _buildStatsSection()),
      ],
    );
  }

  Widget _buildMedalWall() {
    final unlockedAchievements = _achievements
        .where((a) => a.isUnlocked)
        .toList();

    return SliverToBoxAdapter(
      child: Container(
        height: 120,
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "133fdb2ff0TpJFomaFFM".tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: unlockedAchievements.length + 2, // 添加一些空白项
                itemBuilder: (context, index) {
                  if (index == 0 || index == unlockedAchievements.length + 1) {
                    return const SizedBox(width: 20); // 左右边距
                  }
                  final achievement = unlockedAchievements[index - 1];
                  return _buildMedalItem(achievement);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedalItem(AchievementItem achievement) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  achievement.color.withValues(alpha: 0.8),
                  achievement.color.withValues(alpha: 0.4),
                ],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: achievement.color.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(achievement.icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 8),
          Text(
            achievement.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementGrid(List<AchievementItem> achievements) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => _buildAchievementCard(achievements[index]),
          childCount: achievements.length,
        ),
      ),
    );
  }

  Widget _buildAchievementCard(AchievementItem achievement) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: achievement.isUnlocked
              ? achievement.color.withValues(alpha: 0.3)
              : Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // 成就图标
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: achievement.isUnlocked
                    ? achievement.color.withValues(alpha: 0.2)
                    : Colors.grey.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: achievement.isUnlocked
                      ? achievement.color.withValues(alpha: 0.5)
                      : Colors.grey.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: Icon(
                achievement.icon,
                color: achievement.isUnlocked ? achievement.color : Colors.grey,
                size: 17,
              ),
            ),
            const SizedBox(width: 10),
            // 成就信息
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          achievement.title,
                          style: TextStyle(
                            color: achievement.isUnlocked
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.6),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildRarityBadge(achievement.rarity),
                    ],
                  ),
                  const SizedBox(height: 1),
                  Text(
                    achievement.description,
                    style: TextStyle(
                      color: achievement.isUnlocked
                          ? Colors.white.withValues(alpha: 0.8)
                          : Colors.white.withValues(alpha: 0.5),
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // 进度条
                  if (!achievement.isUnlocked) ...[
                    LinearProgressIndicator(
                      value: achievement.progress / achievement.target,
                      backgroundColor: Colors.grey.withValues(alpha: 0.3),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        achievement.color,
                      ),
                      minHeight: 4,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${achievement.progress}/${achievement.target}",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 10,
                      ),
                    ),
                  ] else ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: achievement.color.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "e4cf2de9b4HXDXMzTQM6".tr,
                        style: TextStyle(
                          color: achievement.color,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    "de4ff756afj02oBtZ8sS".tr + "${achievement.reward}",
                    style: TextStyle(
                      color: Colors.amber.shade300,
                      fontSize: 10,
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

  Widget _buildRarityBadge(AchievementRarity rarity) {
    Color color;
    String text;

    switch (rarity) {
      case AchievementRarity.common:
        color = Colors.grey;
        text = "de907d10dfAqe2nkVEqB".tr;
        break;
      case AchievementRarity.rare:
        color = Colors.blue;
        text = "050c11f35arMXZan4Vfy".tr;
        break;
      case AchievementRarity.epic:
        color = Colors.purple;
        text = "a47ff1babc4inJfWhucV".tr;
        break;
      case AchievementRarity.legendary:
        color = Colors.amber;
        text = "5575627d89ljjKiXibUv".tr;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _getCategoryDisplayName(AchievementCategory category) {
    switch (category) {
      case AchievementCategory.fitness:
        return "5d925cc69dkRnUOptq2Q".tr;
      case AchievementCategory.nutrition:
        return "fd8f627cc1D08ECZneCE".tr;
      case AchievementCategory.learning:
        return "2118cbc109HWnqRX7ZRU".tr;
      case AchievementCategory.lifestyle:
        return "15d208d1b4bn0hZH3wpK".tr;
      case AchievementCategory.overall:
        return "4a0d4edef9L0n17THLEQ".tr;
    }
  }

  void _showAchievementStats() {
    final unlockedCount = _achievements.where((a) => a.isUnlocked).length;
    final totalCount = _achievements.length;
    final recentUnlocked =
        _achievements
            .where((a) => a.isUnlocked && a.unlockedAt != null)
            .toList()
          ..sort((a, b) => b.unlockedAt!.compareTo(a.unlockedAt!));

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("29bc5bffd7kT52rlnC51".tr),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("f8f9d136967REHgCJBYy".tr + "$totalCount"),
              Text("833ae88dc57MxU3Hpz8B".tr + "$unlockedCount"),
              Text(
                "0f171c1eb1H1fGT4LVNE".tr +
                    "${((unlockedCount / totalCount) * 100).toInt()}%",
              ),
              const SizedBox(height: 16),
              Text(
                "c03d2dbcff18z5sheKUi".tr,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...recentUnlocked
                  .take(3)
                  .map(
                    (achievement) => ListTile(
                      leading: Icon(achievement.icon, color: achievement.color),
                      title: Text(achievement.title),
                      subtitle: Text(
                        "${_formatTime(achievement.unlockedAt!)}" +
                            "20b29e8907MdsMux5c5w".tr,
                      ),
                      dense: true,
                    ),
                  ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("3fd47edce4xLkspMDxMV".tr),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return '${difference.inDays}' + "4ce3054e7clorsyY8wUx".tr;
    } else if (difference.inHours > 0) {
      return '${difference.inHours}' + "8f82ece04fkYUbBy38Vq".tr;
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}' + "40de54344duGYSlXwBBm".tr;
    } else {
      return "de6785d99eGc2IlUZ6WW".tr;
    }
  }
}

class AchievementItem {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final AchievementCategory category;
  final AchievementRarity rarity;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final int progress;
  final int target;
  final String reward;
  final Color color;

  AchievementItem({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.category,
    required this.rarity,
    required this.isUnlocked,
    required this.unlockedAt,
    required this.progress,
    required this.target,
    required this.reward,
    required this.color,
  });
}

enum AchievementCategory { fitness, nutrition, learning, lifestyle, overall }

enum AchievementRarity { common, rare, epic, legendary }
