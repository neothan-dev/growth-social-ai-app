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

class VideoShareHubScreen extends StatefulWidget {
  const VideoShareHubScreen({super.key});

  @override
  State<VideoShareHubScreen> createState() => _VideoShareHubScreenState();
}

class _VideoShareHubScreenState extends State<VideoShareHubScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<VideoItem> _videos = [];
  bool _isLoading = true;

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
    _videos.addAll([
      VideoItem(
        id: '1',
        title: "73d3ff6a74TQ65pDZByj".tr,
        description: "75249902e9ge8zc20H9h".tr,
        thumbnail: 'assets/images/social_custom/video_share/breakfast.jpg',
        duration: '5:32',
        views: 1240,
        likes: 89,
        author: "4225b3a2b5HwODNMeelf".tr,
        category: VideoCategory.food,
        uploadTime: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      VideoItem(
        id: '2',
        title: "4cdf9c8c4cRXphMmtdoH".tr,
        description: "066faeb4c7yJBFIYlObM".tr,
        thumbnail: 'assets/images/social_custom/video_share/home_fitness.jpg',
        duration: '28:15',
        views: 2156,
        likes: 156,
        author: "399f1a619e9EsznXcw4c".tr,
        category: VideoCategory.fitness,
        uploadTime: DateTime.now().subtract(const Duration(hours: 4)),
      ),
      VideoItem(
        id: '3',
        title: "259a2b7680ryrDJrNqTH".tr,
        description: "aead1d2fcaqVe1iMQlH5".tr,
        thumbnail:
            'assets/images/social_custom/video_share/yoga_meditation.jpg',
        duration: '15:42',
        views: 892,
        likes: 67,
        author: "bb469e95b5Inhqdig3fm".tr,
        category: VideoCategory.yoga,
        uploadTime: DateTime.now().subtract(const Duration(hours: 6)),
      ),
      VideoItem(
        id: '4',
        title: "a8fb9a716dkiChOnDcAv".tr,
        description: "c1ed2984c3W3z82YiAOF".tr,
        thumbnail:
            'assets/images/social_custom/video_share/running_technique.jpg',
        duration: '12:18',
        views: 1567,
        likes: 123,
        author: "640583cb84pjT3jrw0mC".tr,
        category: VideoCategory.running,
        uploadTime: DateTime.now().subtract(const Duration(hours: 8)),
      ),
      VideoItem(
        id: '5',
        title: "b06b37b57fruHp56OaId".tr,
        description: "7d3fda65afAZVsY0jgPg".tr,
        thumbnail: 'assets/images/social_custom/video_share/healthy_recipe.jpg',
        duration: '8:45',
        views: 987,
        likes: 78,
        author: "f4a5499c62t66j4FGJ6A".tr,
        category: VideoCategory.food,
        uploadTime: DateTime.now().subtract(const Duration(hours: 12)),
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
                        : _buildVideoGrid(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HapticFeedbackHelper.lightImpact();
          _showCreateVideoDialog();
        },
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        child: const Icon(Icons.videocam, color: Colors.white),
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
              "06e0ae6214cvQZRgjSMr".tr,
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
              child: const Icon(Icons.search, color: Colors.white, size: 20),
            ),
            onPressed: () {
              HapticFeedbackHelper.lightImpact();
              _showSearchDialog();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCategoryChip("5c55a679352WAGeaQhHs".tr, null, true),
          _buildCategoryChip(
            "5d925cc69dtUBa9iumyX".tr,
            VideoCategory.fitness,
            false,
          ),
          _buildCategoryChip(
            "5fa29a4e55qv3GOyFQvw".tr,
            VideoCategory.food,
            false,
          ),
          _buildCategoryChip(
            "bd4e166240Pmzw2mp35k".tr,
            VideoCategory.yoga,
            false,
          ),
          _buildCategoryChip(
            "591052c733p1DTJs8bP9".tr,
            VideoCategory.running,
            false,
          ),
          _buildCategoryChip(
            "aa18b6dcd8NhR5MFZj5C".tr,
            VideoCategory.health,
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(
    String label,
    VideoCategory? category,
    bool isSelected,
  ) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(
          label,
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
          // TODO: 筛选视频
        },
        backgroundColor: Colors.green.withValues(alpha: 0.9),
        selectedColor: Colors.red.withValues(alpha: 0.8),
        checkmarkColor: Colors.white,
        side: BorderSide(
          color: isSelected
              ? Colors.red.withValues(alpha: 0.8)
              : Colors.green.withValues(alpha: 0.3),
        ),
      ),
    );
  }

  Widget _buildVideoGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _videos.length,
      itemBuilder: (context, index) {
        final video = _videos[index];
        return _buildVideoCard(video);
      },
    );
  }

  Widget _buildVideoCard(VideoItem video) {
    return GestureDetector(
      onTap: () {
        HapticFeedbackHelper.lightImpact();
        _playVideo(video);
      },
      child: Container(
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
            // 视频缩略图
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: _getCategoryColor(
                    video.category,
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
                              color: _getCategoryColor(
                                video.category,
                              ).withValues(alpha: 0.2),
                              child: Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  color: _getCategoryColor(video.category),
                                  size: 32,
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
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.4),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(4),
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
            ),
            // 视频信息
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      video.author,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 10,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.remove_red_eye,
                          color: Colors.white.withValues(alpha: 0.6),
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${video.views}',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.6),
                            fontSize: 12,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.favorite_border,
                          color: Colors.white.withValues(alpha: 0.6),
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${video.likes}',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.6),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(VideoCategory category) {
    switch (category) {
      case VideoCategory.fitness:
        return Colors.blue;
      case VideoCategory.food:
        return Colors.orange;
      case VideoCategory.yoga:
        return Colors.purple;
      case VideoCategory.running:
        return Colors.green;
      case VideoCategory.health:
        return Colors.teal;
    }
  }

  void _playVideo(VideoItem video) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(video.title),
        content: Text("760c68e5bdmSIdCqMHAI".tr + '${video.description}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("3fd47edce4rVB2dqOdJo".tr),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: 实现视频播放
            },
            child: Text("c3396195e92GeAv29vz2".tr),
          ),
        ],
      ),
    );
  }

  void _showCreateVideoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("2d2abd08cbLjmPMObWyh".tr),
        content: Text("7067e7f6f7uTNkhvMxq5".tr),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("fac2a67ad8dbqHMxE6xo".tr),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("ba533544101pXZe9sLfl".tr),
        content: Text("091ca097deJQEeFBw2we".tr),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("fac2a67ad8xcioQaGJ7M".tr),
          ),
        ],
      ),
    );
  }
}

class VideoItem {
  final String id;
  final String title;
  final String description;
  final String thumbnail;
  final String duration;
  final int views;
  final int likes;
  final String author;
  final VideoCategory category;
  final DateTime uploadTime;

  VideoItem({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.duration,
    required this.views,
    required this.likes,
    required this.author,
    required this.category,
    required this.uploadTime,
  });
}

enum VideoCategory { fitness, food, yoga, running, health }
