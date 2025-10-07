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
import 'fitness_video_hub_screen.dart';
import 'events_hub_screen.dart';
import 'knowledge_base_hub_screen.dart';
import 'expert_articles_hub_screen.dart';
import 'achievements_hub_screen.dart';
import 'exclusive_offers_hub_screen.dart';
import '../../../localization/app_localizations.dart';

class TreasureChestHubScreen extends StatefulWidget {
  const TreasureChestHubScreen({super.key});

  @override
  State<TreasureChestHubScreen> createState() => _TreasureChestHubScreenState();
}

class _TreasureChestHubScreenState extends State<TreasureChestHubScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late PageController _bannerPageController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late AnimationController _bannerEnterController;
  late Animation<Offset> _bannerEnterAnimation;

  int _currentBannerIndex = 0;

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

    _bannerEnterController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _bannerPageController = PageController(initialPage: 0);

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

    _bannerEnterAnimation =
        Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _bannerEnterController,
            curve: Curves.easeOutCubic,
          ),
        );
  }

  void _startAnimations() async {
    // 海报从上而下进入
    if (mounted) {
      _bannerEnterController.forward();
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
    _bannerEnterController.dispose();
    _bannerPageController.dispose();
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
        child: CustomScrollView(
          slivers: [
            // 海报区域（使用SliverAppBar）
            _buildSliverAppBar(),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            // 服务卡片区域
            _buildServiceCards(),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    final screenHeight = MediaQuery.of(context).size.height;
    final expandedHeight = screenHeight * 0.4;

    return SliverAppBar(
      expandedHeight: expandedHeight,
      floating: false,
      pinned: false, // 不固定在顶部，可以完全隐藏
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
        ),
        onPressed: () {
          HapticFeedbackHelper.lightImpact();
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.search, color: Colors.white, size: 20),
          ),
          onPressed: () {
            HapticFeedbackHelper.lightImpact();
            // TODO: 搜索功能
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: SlideTransition(
          position: _bannerEnterAnimation,
          child: Stack(children: [_buildBannerCarousel()]),
        ),
      ),
    );
  }

  Widget _buildBannerCarousel() {
    return Positioned.fill(
      child: Stack(
        children: [
          PageView.builder(
            controller: _bannerPageController,
            onPageChanged: (index) {
              setState(() {
                _currentBannerIndex = index;
              });
            },
            itemCount: _bannerItems.length,
            itemBuilder: (context, index) {
              return _buildBannerItem(_bannerItems[index]);
            },
          ),
          // 指示器
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _bannerItems.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentBannerIndex == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentBannerIndex == index
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerItem(BannerItem bannerItem) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // 背景图片
          Positioned.fill(
            child: Image.asset(bannerItem.backgroundImage, fit: BoxFit.cover),
          ),
          // 渐变遮罩
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.6),
                  ],
                ),
              ),
            ),
          ),
          // 内容
          Positioned(
            bottom: 80,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bannerItem.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  bannerItem.subtitle,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCards() {
    return SliverToBoxAdapter(
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: List.generate(_serviceItems.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: _buildStaggeredServiceCard(
                      _serviceItems[index],
                      index,
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStaggeredServiceCard(ServiceItem serviceItem, int index) {
    final isLeft = index % 2 == 0; // 偶数索引在左侧，奇数索引在右侧
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.75; // 卡片宽度为屏幕宽度的75%

    return Align(
      alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          HapticFeedbackHelper.lightImpact();
          _navigateToService(serviceItem);
        },
        child: Container(
          width: cardWidth,
          height: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                // 背景图片
                Positioned.fill(
                  child: Image.asset(
                    serviceItem.backgroundImage,
                    fit: BoxFit.cover,
                  ),
                ),
                // 渐变遮罩
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: isLeft
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        end: isLeft
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        colors: [
                          Colors.black.withValues(alpha: 0.8),
                          Colors.black.withValues(alpha: 0.4),
                        ],
                      ),
                    ),
                  ),
                ),
                // 内容
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      // 图标
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(35),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          serviceItem.icon,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 20),
                      // 文字内容
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              serviceItem.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              serviceItem.subtitle,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 箭头
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToService(ServiceItem serviceItem) {
    switch (serviceItem.type) {
      case ServiceType.fitnessVideo:
        Navigator.pushNamed(context, '/fitness_video_hub_screen');
        break;
      case ServiceType.events:
        Navigator.pushNamed(context, '/events_hub_screen');
        break;
      case ServiceType.knowledgeBase:
        Navigator.pushNamed(context, '/knowledge_base_hub_screen');
        break;
      case ServiceType.expertArticles:
        Navigator.pushNamed(context, '/expert_articles_hub_screen');
        break;
      case ServiceType.achievements:
        Navigator.pushNamed(context, '/achievements_hub_screen');
        break;
      case ServiceType.exclusiveOffers:
        Navigator.pushNamed(context, '/exclusive_offers_hub_screen');
        break;
    }
  }

  // 轮播图数据
  final List<BannerItem> _bannerItems = [
    BannerItem(
      title: "d93f9833b81DFFw0OeQi".tr,
      subtitle: "ecf1e3dc61edGnSiHFYv".tr,
      backgroundImage: 'assets/images/social_hub_card_bg/treasure_chest.jpg',
    ),
    BannerItem(
      title: "9852bb80afnxOtBPRyE7".tr,
      subtitle: "428efe38025kkiDTNHVt".tr,
      backgroundImage: 'assets/images/social_hub_card_bg/welcome.jpg',
    ),
    BannerItem(
      title: "3edf24223bmxdFPgaaT5".tr,
      subtitle: "afcbd625d3JhNiHoTAgi".tr,
      backgroundImage: 'assets/images/social_hub_card_bg/community.jpg',
    ),
  ];

  // 服务卡片数据
  final List<ServiceItem> _serviceItems = [
    ServiceItem(
      type: ServiceType.fitnessVideo,
      title: "080fc404d3uAzwCPv3Da".tr,
      subtitle: "aa012db965gVw15OE4rT".tr,
      icon: Icons.fitness_center,
      backgroundImage:
          'assets/images/social_custom/fitness_video/fitness_yoga.jpg',
    ),
    ServiceItem(
      type: ServiceType.events,
      title: "9e9bead814Lm0Ag1yah8".tr,
      subtitle: "54dc2f8ed1iy1I5u5que".tr,
      icon: Icons.event_outlined,
      backgroundImage: 'assets/images/social_custom/events/marathon.jpg',
    ),
    ServiceItem(
      type: ServiceType.knowledgeBase,
      title: "4419315bf4rtqUV61lty".tr,
      subtitle: "46a98a794bcjvwUBKWUt".tr,
      icon: Icons.school,
      backgroundImage: 'assets/images/social_custom/events/healthy_lecture.jpg',
    ),
    ServiceItem(
      type: ServiceType.expertArticles,
      title: "54c6f5deeaip4IGn82Jg".tr,
      subtitle: "a461f88866forQaPMamu".tr,
      icon: Icons.article,
      backgroundImage: 'assets/images/social_custom/events/healthy_diet.jpg',
    ),
    // ServiceItem(
    //   type: ServiceType.achievements,
    //   title: "d166ed9d31RUHQBF4dJZ".tr,
    //   subtitle: "769e8dc464sRnelBu7ha".tr,
    //   icon: Icons.emoji_events,
    //   backgroundImage: 'assets/images/social_custom/moments/fitness1.jpg',
    // ),
    ServiceItem(
      type: ServiceType.exclusiveOffers,
      title: "9852bb80afNF2u61JXOl".tr,
      subtitle: "556aba3779G6XfFLWaFT".tr,
      icon: Icons.local_offer,
      backgroundImage: 'assets/images/social_custom/moments/gym.jpg',
    ),
  ];
}

// 轮播图数据模型
class BannerItem {
  final String title;
  final String subtitle;
  final String backgroundImage;

  const BannerItem({
    required this.title,
    required this.subtitle,
    required this.backgroundImage,
  });
}

// 服务卡片数据模型
class ServiceItem {
  final ServiceType type;
  final String title;
  final String subtitle;
  final IconData icon;
  final String backgroundImage;

  const ServiceItem({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.backgroundImage,
  });
}

enum ServiceType {
  fitnessVideo,
  events,
  knowledgeBase,
  expertArticles,
  achievements,
  exclusiveOffers,
}
