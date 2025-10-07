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
import '../../utils/haptic_feedback_helper.dart';
import '../../widgets/blur_background_container.dart';
import '../../utils/asset_manager.dart';
import 'hubs/chat_hub_screen.dart';
import 'hubs/moments_hub_screen.dart';
import 'hubs/video_share_hub_screen.dart';
import 'hubs/treasure_chest_hub_screen.dart';
import 'hubs/community_hub_screen.dart';
import 'hubs/events_hub_screen.dart';

class SocialHubScreen extends StatefulWidget {
  const SocialHubScreen({super.key});

  @override
  State<SocialHubScreen> createState() => _SocialHubScreenState();
}

class _SocialHubScreenState extends State<SocialHubScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late AnimationController _appBarEnterController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _appBarEnterAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
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

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _appBarEnterController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOutCubic),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _appBarEnterAnimation =
        Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _appBarEnterController,
            curve: Curves.easeOutCubic,
          ),
        );
  }

  void _startAnimations() async {
    // AppBar从上而下进入
    if (mounted) {
      _appBarEnterController.forward();
    }

    // 下方内容延迟进入
    await Future.delayed(const Duration(milliseconds: 400));
    if (mounted) {
      _fadeController.forward();
      _slideController.forward();
      _scaleController.forward();
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    _appBarEnterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlassmorphismBackgroundContainer(
        backgroundName: AppBackgrounds.societyBackground,
        blurSigma: 3.0,
        glassOpacity: 0.01,
        overlayColor: Colors.black.withValues(alpha: 0.1),
        child: CustomScrollView(
          slivers: [
            // 可收缩的顶部区域，不参与进入动画
            _buildSliverAppBar(),
            // 内容区域，参与进入动画
            SliverToBoxAdapter(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        _buildQuickActionsContent(),
                        _buildHubGridContent(),
                        _buildFullWidthCardsContent(),
                        _buildRecentActivityContent(),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建可收缩的顶部欢迎区域
  Widget _buildSliverAppBar() {
    const String welcomeBackgroundImage =
        "assets/images/social_hub_card_bg/welcome.jpg";

    return SliverAppBar(
      expandedHeight: 200, // 展开时的最大高度
      floating: false,
      pinned: false, // 不固定在顶部，可以完全隐藏
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: SlideTransition(
          position: _appBarEnterAnimation,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.withValues(alpha: 0.8),
                  Colors.purple.withValues(alpha: 0.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                // 背景图片
                Positioned.fill(
                  child: Image.asset(
                    welcomeBackgroundImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // 图片加载失败时返回空容器，使用渐变背景
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                // 背景遮罩
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withValues(alpha: 0.4),
                        Colors.black.withValues(alpha: 0.2),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                // 内容
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 5), // 增加顶部间距
                        Text(
                          "3a8d3edbc3CCKCB9GC2S".tr,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26, // 稍微增大字体
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "1bf497042cVIZcoHYUBx".tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 18, // 稍微增大字体
                          ),
                        ),
                        const SizedBox(height: 40), // 增加底部间距
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionsContent() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Row(
        children: [
          Expanded(
            child: _buildQuickActionButton(
              icon: Icons.add_circle_outline,
              label: "bab9970c67h0gozETJy6".tr,
              color: Colors.green,
              onTap: () {
                HapticFeedbackHelper.lightImpact();
                // TODO: 发布动态
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildQuickActionButton(
              icon: Icons.camera_alt_outlined,
              label: "e2040c558dFplvEdhxy7".tr,
              color: Colors.orange,
              onTap: () {
                HapticFeedbackHelper.lightImpact();
                // TODO: 拍照分享
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildQuickActionButton(
              icon: Icons.video_library_outlined,
              label: "39ee71261brnio9x3UJB".tr,
              color: Colors.red,
              onTap: () {
                HapticFeedbackHelper.lightImpact();
                // TODO: 视频创作
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFullWidthCardsContent() {
    final fullWidthItems = _hubItems.where((item) => item.isFullWidth).toList();
    if (fullWidthItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: fullWidthItems.map((item) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: _buildHubCard(item, isFullWidth: true),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHubGridContent() {
    final regularItems = _hubItems.where((item) => !item.isFullWidth).toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 25, 16, 16),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: regularItems.length,
        itemBuilder: (context, index) {
          return _buildHubCard(regularItems[index]);
        },
      ),
    );
  }

  Widget _buildHubCard(SocialHubItem hubItem, {bool isFullWidth = false}) {
    return GestureDetector(
      onTap: () {
        HapticFeedbackHelper.lightImpact();
        _navigateToHub(hubItem);
      },
      child: Container(
        height: isFullWidth ? 120 : null,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hubItem.primaryColor.withValues(alpha: 0.8),
              hubItem.secondaryColor.withValues(alpha: 0.6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: hubItem.primaryColor.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            // 背景图片
            if (hubItem.backgroundImage != null)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    hubItem.backgroundImage!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // 图片加载失败时返回空容器，使用渐变背景
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            // 背景遮罩（当有背景图片时）
            if (hubItem.backgroundImage != null)
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withValues(alpha: 0.5),
                      Colors.black.withValues(alpha: 0.01),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            // 背景装饰
            Positioned(
              top: -20,
              right: -20,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
            // 内容
            Padding(
              padding: EdgeInsets.all(isFullWidth ? 24 : 20),
              child: isFullWidth
                  ? Row(
                      children: [
                        Icon(hubItem.icon, color: Colors.white, size: 40),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                hubItem.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                hubItem.subtitle,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white.withValues(alpha: 0.7),
                          size: 16,
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(hubItem.icon, color: Colors.white, size: 32),
                        const Spacer(),
                        Text(
                          hubItem.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          hubItem.subtitle,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white.withValues(alpha: 0.7),
                              size: 10,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "f88182fcd5mFapGz2gax".tr,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.7),
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivityContent() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "6bac827144IDCBW2uAqQ".tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  HapticFeedbackHelper.lightImpact();
                  // TODO: 查看更多
                },
                child: Text(
                  "92b2b2dec2n1FOJWAQD3".tr,
                  style: TextStyle(color: Colors.blue.shade300, fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          _buildActivityItem(
            avatar: "assets/images/avatar/avatar1.jpg",
            name: "91c2f3fd30XPRf1zHKGd".tr,
            action: "b85be5d648AaEEo7cf9j".tr,
            time: "a25c6a13db50u1bwaxZi".tr,
            color: Colors.green,
          ),
          _buildActivityItem(
            avatar: "assets/images/avatar/avatar2.jpg",
            name: "4225b3a2b5xu1azQ5zdo".tr,
            action: "4ad1662401MHLLk87wp0".tr,
            time: "f7baf09c21QGXqWnmcqn".tr,
            color: Colors.orange,
          ),
          _buildActivityItem(
            avatar: "assets/images/avatar/avatar3.jpg",
            name: "27d36024c90nHBnoWExn".tr,
            action: "803e1a5345vyM6LQC4BR".tr,
            time: "330284137f4BOnbnoeok".tr,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem({
    required String avatar,
    required String name,
    required String action,
    required String time,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          // 主要内容
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        avatar,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // 图片加载失败时显示默认图标
                          return Icon(Icons.person, color: color, size: 20);
                        },
                      ),
                    ),
                  ),
                  // 红点指示器
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      action,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                time,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToHub(SocialHubItem hubItem) {
    switch (hubItem.type) {
      case SocialHubType.chat:
        Navigator.pushNamed(context, '/chat_hub_screen');
        break;
      case SocialHubType.moments:
        Navigator.pushNamed(context, '/moments_hub_screen');
        break;
      case SocialHubType.videoShare:
        Navigator.pushNamed(context, '/video_share_hub_screen');
        break;
      case SocialHubType.treasureChest:
        Navigator.pushNamed(context, '/treasure_chest_hub_screen');
        break;
      case SocialHubType.community:
        Navigator.pushNamed(context, '/community_hub_screen');
        break;
      case SocialHubType.events:
        Navigator.pushNamed(context, '/events_hub_screen');
        break;
    }
  }

  final List<SocialHubItem> _hubItems = [
    SocialHubItem(
      type: SocialHubType.chat,
      title: "4b3510b8d81KA58oaVx1".tr,
      subtitle: "503e9ebcc1K79qKWebDw".tr,
      icon: Icons.chat_bubble_outline,
      primaryColor: Colors.blue,
      secondaryColor: Colors.lightBlue,
      backgroundImage: "assets/images/social_hub_card_bg/chat.jpg",
    ),
    SocialHubItem(
      type: SocialHubType.community,
      title: "5bcd0ddcddqN3YNTiLIg".tr,
      subtitle: "4db974e2a3mdxNQzfqkk".tr,
      icon: Icons.people_outline,
      primaryColor: Colors.purple,
      secondaryColor: Colors.deepPurple,
      backgroundImage: "assets/images/social_hub_card_bg/community.jpg",
    ),
    SocialHubItem(
      type: SocialHubType.videoShare,
      title: "06e0ae6214BWTN82ZLI7".tr,
      subtitle: "7f137cc940vqB434VhMP".tr,
      icon: Icons.video_library_outlined,
      primaryColor: Colors.red,
      secondaryColor: Colors.pink,
      backgroundImage: "assets/images/social_hub_card_bg/video.jpg",
    ),
    SocialHubItem(
      type: SocialHubType.moments,
      title: "c08aacda14HbjtVBedYl".tr,
      subtitle: "4ceb2bfd0eSzv5ghywXr".tr,
      icon: Icons.photo_library_outlined,
      primaryColor: Colors.green,
      secondaryColor: Colors.lightGreen,
      backgroundImage: "assets/images/social_custom/moments/fitness1.jpg",
    ),
    SocialHubItem(
      type: SocialHubType.treasureChest,
      title: "63a9d95616ksdwecnOf8".tr,
      subtitle: "94d0e199a7RB1ePJjFRd".tr,
      icon: Icons.auto_awesome,
      primaryColor: Colors.amber,
      secondaryColor: Colors.orange,
      backgroundImage: "assets/images/social_hub_card_bg/treasure_chest.jpg",
      isFullWidth: true,
    ),
  ];
}

class SocialHubItem {
  final SocialHubType type;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color primaryColor;
  final Color secondaryColor;
  final String? backgroundImage;
  final bool isFullWidth;

  const SocialHubItem({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.primaryColor,
    required this.secondaryColor,
    this.backgroundImage,
    this.isFullWidth = false,
  });
}

enum SocialHubType {
  chat,
  moments,
  videoShare,
  treasureChest,
  community,
  events,
}
