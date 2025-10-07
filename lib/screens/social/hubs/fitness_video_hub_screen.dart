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
import '../../../utils/haptic_feedback_helper.dart';
import '../../../widgets/blur_background_container.dart';
import '../../../utils/asset_manager.dart';

class FitnessVideoHubScreen extends StatefulWidget {
  const FitnessVideoHubScreen({super.key});

  @override
  State<FitnessVideoHubScreen> createState() => _FitnessVideoHubScreenState();
}

class _FitnessVideoHubScreenState extends State<FitnessVideoHubScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<FitnessVideoItem> _fitnessVideos = [];
  bool _isLoading = true;
  String _selectedCategory = "5c55a67935hHKgqdq6F0".tr;

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
    _fitnessVideos.addAll([
      FitnessVideoItem(
        id: '1',
        title: "54a328d19a95bke4xSwR".tr,
        description: "70c815d1718mlpv13Jpg".tr,
        thumbnail: 'assets/images/social_custom/fitness_video/fitness_hiit.jpg',
        duration: '30:15',
        difficulty: FitnessDifficulty.intermediate,
        calories: 350,
        category: FitnessCategory.cardio,
        trainer: "399f1a619eYRZim3jKFs".tr,
        rating: 4.8,
        views: 3456,
        likes: 234,
        equipment: ["2bed1777d8H3Gzthbd8y".tr, "cfbb88c4baF5ikwAbcFU".tr],
        tags: ["f6516efcceVCebkhk1lP".tr, 'HIIT', "acceb05257CGBIRuBhC3".tr],
      ),
      FitnessVideoItem(
        id: '2',
        title: "ede9f477c7MsBFg87mcl".tr,
        description: "b8440f9558HfjEWLQe76".tr,
        thumbnail: 'assets/images/social_custom/fitness_video/fitness_core.jpg',
        duration: '25:30',
        difficulty: FitnessDifficulty.beginner,
        calories: 280,
        category: FitnessCategory.strength,
        trainer: "bb469e95b5RJmTdDZoDT".tr,
        rating: 4.6,
        views: 2890,
        likes: 189,
        equipment: ["2bed1777d8qBZvzXZl6k".tr],
        tags: [
          "a8a88ddbeae7Jf4Ub4Cm".tr,
          "16b7568de4VIqhYg9O83".tr,
          "f90723cf425YSISTOr57".tr,
        ],
      ),
      FitnessVideoItem(
        id: '3',
        title: "fbd0628eb7TLm8O6XDho".tr,
        description: "e1602e1e59QtisugDUzg".tr,
        thumbnail:
            'assets/images/social_custom/fitness_video/fitness_upper.jpg',
        duration: '35:20',
        difficulty: FitnessDifficulty.advanced,
        calories: 420,
        category: FitnessCategory.strength,
        trainer: "46418502e939pksEUKGK".tr,
        rating: 4.9,
        views: 4123,
        likes: 312,
        equipment: [
          "cfbb88c4baYjqk4wvm6I".tr,
          "178ac6abc21XerdP7rb0".tr,
          "2bed1777d84Dvvmyqgus".tr,
        ],
        tags: [
          "6bcb8f553eaqNRFKDiW3".tr,
          "16b7568de46Ieaz4pg99".tr,
          "4baa263453KNgYimxxMQ".tr,
        ],
      ),
      FitnessVideoItem(
        id: '4',
        title: "5c009d805e8T1bhBJFMD".tr,
        description: "7dddcbd16eaR87LAccIW".tr,
        thumbnail:
            'assets/images/social_custom/fitness_video/fitness_lower.jpg',
        duration: '28:45',
        difficulty: FitnessDifficulty.intermediate,
        calories: 380,
        category: FitnessCategory.strength,
        trainer: "cefaee9df0uJFFP6Xx9O".tr,
        rating: 4.7,
        views: 2987,
        likes: 201,
        equipment: ["cfbb88c4ba5wMEzh2fJQ".tr, "2bed1777d8oNDlosDzIp".tr],
        tags: [
          "7e81763b5ekXqQLfa6Xl".tr,
          "16b7568de4Tz22r6rfhk".tr,
          "18a44b048bGpeiI3wS0N".tr,
        ],
      ),
      FitnessVideoItem(
        id: '5',
        title: "c083809c47Bz40XIsl9F".tr,
        description: "7fe90e5874vvvJgx1P7u".tr,
        thumbnail: 'assets/images/social_custom/fitness_video/fitness_yoga.jpg',
        duration: '20:15',
        difficulty: FitnessDifficulty.beginner,
        calories: 150,
        category: FitnessCategory.flexibility,
        trainer: "3a3e266126YTT46bXBxa".tr,
        rating: 4.5,
        views: 1876,
        likes: 145,
        equipment: ["2bed1777d8HrmzxbUCrV".tr],
        tags: [
          "5d7d4daca2snrGCIAJ7Y".tr,
          "7bb5f03a00kMRycGEOJ1".tr,
          "bd4e166240hMACCUXhkz".tr,
        ],
      ),
      FitnessVideoItem(
        id: '6',
        title: "d7f46e554evXbrPrJPOY".tr,
        description: "3fc0f64bc3gdlTi8jBTe".tr,
        thumbnail:
            'assets/images/social_custom/fitness_video/fitness_dance.jpg',
        duration: '32:10',
        difficulty: FitnessDifficulty.beginner,
        calories: 320,
        category: FitnessCategory.cardio,
        trainer: "755e1c6a7akranIS0xD1".tr,
        rating: 4.4,
        views: 2345,
        likes: 178,
        equipment: ["2bed1777d84FLWzWzhZr".tr],
        tags: [
          "741016d919p0VNq9KXFR".tr,
          "acceb05257y6uBAKAXym".tr,
          "f6516efccea3xOa1AKw7".tr,
        ],
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
                  Expanded(
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : _buildVideoList(),
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
              "080fc404d3GrYvER5BUk".tr,
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
                Icons.filter_list,
                color: Colors.white,
                size: 20,
              ),
            ),
            onPressed: () {
              HapticFeedbackHelper.lightImpact();
              _showFilterDialog();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    final categories = [
      "5c55a67935B8gBweB5R4".tr,
      "acceb05257CBkgy58zG8".tr,
      "16b7568de4APascz3JXT".tr,
      "a1d0616381ob5BQPeNYX".tr,
      "bd4e166240vM4ke1cl3I".tr,
      "741016d9195XtufaohBi".tr,
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
        backgroundColor: Colors.green.withValues(alpha: 0.9),
        selectedColor: Colors.orange.withValues(alpha: 0.8),
        checkmarkColor: Colors.white,
        side: BorderSide(
          color: isSelected
              ? Colors.orange.withValues(alpha: 0.8)
              : Colors.green.withValues(alpha: 0.3),
        ),
      ),
    );
  }

  Widget _buildVideoList() {
    final filteredVideos = _selectedCategory == "5c55a67935jPrsM4r1xe".tr
        ? _fitnessVideos
        : _fitnessVideos
              .where(
                (video) =>
                    _getCategoryDisplayName(video.category) ==
                    _selectedCategory,
              )
              .toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredVideos.length,
      itemBuilder: (context, index) {
        final video = filteredVideos[index];
        return _buildVideoCard(video);
      },
    );
  }

  Widget _buildVideoCard(FitnessVideoItem video) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 视频缩略图区域
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: _getDifficultyColor(
                video.difficulty,
              ).withValues(alpha: 0.2),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Stack(
              children: [
                // 缩略图背景
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.asset(
                      video.thumbnail,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: _getDifficultyColor(
                            video.difficulty,
                          ).withValues(alpha: 0.2),
                          child: Center(
                            child: Icon(
                              Icons.image_not_supported,
                              color: _getDifficultyColor(video.difficulty),
                              size: 48,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // 半透明遮罩
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.01),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                  ),
                ),
                // 播放按钮
                Center(
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getDifficultyColor(video.difficulty),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _getDifficultyText(video.difficulty),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      video.duration,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 视频信息区域
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 标题和评分
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        video.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${video.rating}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // 描述
                Text(
                  video.description,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 12),
                // 训练师和分类
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.white.withValues(alpha: 0.6),
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      video.trainer,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.category,
                      color: Colors.white.withValues(alpha: 0.6),
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _getCategoryDisplayName(video.category),
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // 统计信息
                Row(
                  children: [
                    _buildStatItem(
                      Icons.local_fire_department,
                      '${video.calories}' + "62a37830a0p37Igl2kJ1".tr,
                      Colors.orange,
                    ),
                    const SizedBox(width: 16),
                    _buildStatItem(
                      Icons.remove_red_eye,
                      '${video.views}',
                      Colors.blue,
                    ),
                    const SizedBox(width: 16),
                    _buildStatItem(
                      Icons.favorite_border,
                      '${video.likes}',
                      Colors.red,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // 标签
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: video.tags.map((tag) => _buildTag(tag)).toList(),
                ),
                const SizedBox(height: 16),
                // 操作按钮
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          HapticFeedbackHelper.lightImpact();
                          _startWorkout(video);
                        },
                        icon: const Icon(Icons.play_arrow),
                        label: Text("b6b73f94d47lqXNVdNfT".tr),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange.withValues(alpha: 0.8),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      onPressed: () {
                        HapticFeedbackHelper.lightImpact();
                        _addToFavorites(video);
                      },
                      icon: Icon(
                        Icons.favorite_border,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        HapticFeedbackHelper.lightImpact();
                        _shareVideo(video);
                      },
                      icon: Icon(
                        Icons.share,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.orange.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: Colors.orange.shade300,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Color _getDifficultyColor(FitnessDifficulty difficulty) {
    switch (difficulty) {
      case FitnessDifficulty.beginner:
        return Colors.green;
      case FitnessDifficulty.intermediate:
        return Colors.orange;
      case FitnessDifficulty.advanced:
        return Colors.red;
    }
  }

  String _getDifficultyText(FitnessDifficulty difficulty) {
    switch (difficulty) {
      case FitnessDifficulty.beginner:
        return "cdff07650fEGOCgYask7".tr;
      case FitnessDifficulty.intermediate:
        return "da2a633854j8zzsl0zfz".tr;
      case FitnessDifficulty.advanced:
        return "d6e61888b0F8VpyYKsT1".tr;
    }
  }

  String _getCategoryDisplayName(FitnessCategory category) {
    switch (category) {
      case FitnessCategory.cardio:
        return "acceb05257s9dg06UaT8".tr;
      case FitnessCategory.strength:
        return "16b7568de4l9WYgqgRbD".tr;
      case FitnessCategory.flexibility:
        return "a1d06163812fVzY7biNX".tr;
      case FitnessCategory.yoga:
        return "bd4e166240d3BO78mxHi".tr;
      case FitnessCategory.dance:
        return "741016d919PpyRvzuTZA".tr;
    }
  }

  void _startWorkout(FitnessVideoItem video) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("eb8e95e9202NVllowsZl".tr + '${video.title}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("6beca037dd2SrnWsSkW5".tr + '${video.duration}'),
            Text(
              "d4f0526d1fpkO6oigxsk".tr +
                  '${video.calories}' +
                  "904c314d8ahnWeQZp02I".tr,
            ),
            Text(
              "ab1a6c505b8iNlCGg0Vh".tr +
                  '${_getDifficultyText(video.difficulty)}',
            ),
            const SizedBox(height: 8),
            Text("e51464a354FKqodsYDjn".tr + '${video.equipment.join(", ")}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("2cd0f3be87z7rkhKgbz4".tr),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: 开始训练
            },
            child: Text("d2bb025a2eCu0B2RnLYf".tr),
          ),
        ],
      ),
    );
  }

  void _addToFavorites(FitnessVideoItem video) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("373c43865098gRlwMF5g".tr + '${video.title}'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _shareVideo(FitnessVideoItem video) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("5bdfb8ce2aqiyXluz9Pn".tr),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("490a793cacKkY4f8zemR".tr),
        content: Text("091ba362a7Ei6eXfXyjp".tr),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("fac2a67ad8ScPws0hMub".tr),
          ),
        ],
      ),
    );
  }
}

class FitnessVideoItem {
  final String id;
  final String title;
  final String description;
  final String thumbnail;
  final String duration;
  final FitnessDifficulty difficulty;
  final int calories;
  final FitnessCategory category;
  final String trainer;
  final double rating;
  final int views;
  final int likes;
  final List<String> equipment;
  final List<String> tags;

  FitnessVideoItem({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.duration,
    required this.difficulty,
    required this.calories,
    required this.category,
    required this.trainer,
    required this.rating,
    required this.views,
    required this.likes,
    required this.equipment,
    required this.tags,
  });
}

enum FitnessDifficulty { beginner, intermediate, advanced }

enum FitnessCategory { cardio, strength, flexibility, yoga, dance }
