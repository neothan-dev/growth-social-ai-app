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
import '../../../localization/app_localizations.dart';

class CommunityHubScreen extends StatefulWidget {
  const CommunityHubScreen({super.key});

  @override
  State<CommunityHubScreen> createState() => _CommunityHubScreenState();
}

class _CommunityHubScreenState extends State<CommunityHubScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // 服务类型选择
  int _selectedServiceType = 0; // 0: 健康咨询, 1: 运动指导, 2: 营养建议
  final List<String> _serviceTypes = [
    "adfba1facbQvCGpzDqND".tr,
    "4c66daadc2tc8Bq6VW02".tr,
    "2e7b1548a2QRmCaBbNs5".tr,
  ];

  // 分类数据
  final List<CategoryItem> _categories = [];
  final List<HealthServiceItem> _healthServices = [];
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
    // 加载分类数据
    _categories.addAll([
      CategoryItem(
        id: '1',
        name: "7cf0ce0d37f8SbkrlAtt".tr,
        icon: Icons.fitness_center,
        color: Colors.orange,
        backgroundImage:
            'assets/images/social_custom/community/option_exercise.jpg',
      ),
      CategoryItem(
        id: '2',
        name: "f13cf732f0E5XbydM2Ci".tr,
        icon: Icons.restaurant,
        color: Colors.green,
        backgroundImage: 'assets/images/social_custom/events/healthy_diet.jpg',
      ),
      CategoryItem(
        id: '3',
        name: "1986a8d194pxafDMdnCE".tr,
        icon: Icons.psychology,
        color: Colors.purple,
        backgroundImage:
            'assets/images/social_custom/events/healthy_lecture.jpg',
      ),
      CategoryItem(
        id: '4',
        name: "bc37becaa1mvj9EuKh36".tr,
        icon: Icons.bedtime,
        color: Colors.blue,
        backgroundImage:
            'assets/images/social_custom/community/option_sleep.jpg',
      ),
      CategoryItem(
        id: '5',
        name: "5acef958f2WnrlmUiZJP".tr,
        icon: Icons.medical_services,
        color: Colors.red,
        backgroundImage:
            'assets/images/social_custom/community/option_chronic.jpg',
      ),
      CategoryItem(
        id: '6',
        name: "08685556be7q1PHzdtZi".tr,
        icon: Icons.monitor_heart,
        color: Colors.teal,
        backgroundImage:
            'assets/images/social_custom/community/option_health_monitoring.jpg',
      ),
    ]);

    // 加载健康服务数据
    _healthServices.addAll([
      HealthServiceItem(
        id: '1',
        name: "50818ab866B0E6PFAgu9".tr,
        image: 'assets/images/health_fitness.jpg',
        serviceFee: "5b7f3e050ac5DVtVBZTR".tr,
        serviceTime: "445e8f9cd4R5RmJQ7w2p".tr,
        rating: 4.8,
        isSponsored: true,
        isFavorite: false,
        description: "3c7c491016sMFMGGfqKW".tr,
        cardBackgroundImage:
            'assets/images/social_custom/community/fitness_coach.jpg',
      ),
      HealthServiceItem(
        id: '2',
        name: "60a8ac1170OD8TX6bge9".tr,
        image: 'assets/images/health_nutrition.jpg',
        serviceFee: "8a9ec7adaeujlGH4SGPl".tr,
        serviceTime: "144be2bd19YIZDju618C".tr,
        rating: 4.6,
        isSponsored: false,
        isFavorite: true,
        description: "22336957f6HUPJbnafTI".tr,
        cardBackgroundImage:
            'assets/images/social_custom/video_share/healthy_recipe.jpg',
      ),
      HealthServiceItem(
        id: '3',
        name: "dac2d1e061kKva45VKLn".tr,
        image: 'assets/images/health_mental.jpg',
        serviceFee: "22c75d99f1bK0sJcaaCW".tr,
        serviceTime: "a881037cb5hzL2AiekEY".tr,
        rating: 4.9,
        isSponsored: false,
        isFavorite: false,
        description: "93fd8a9d8961F96Q7d6H".tr,
        cardBackgroundImage:
            'assets/images/social_custom/community/mental_consultation.jpg',
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
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              children: [
                _buildTopBar(),
                _buildLocationBar(),
                _buildSearchBar(),
                Expanded(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.orange,
                          ),
                        )
                      : _buildScrollableContent(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // 左侧返回按钮
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 20,
              ),
            ),
            onPressed: () {
              HapticFeedbackHelper.lightImpact();
              Navigator.pop(context);
            },
          ),
          const SizedBox(width: 8),
          // 服务类型选择
          Expanded(
            child: Row(
              children: _serviceTypes.asMap().entries.map((entry) {
                int index = entry.key;
                String serviceType = entry.value;
                bool isSelected = _selectedServiceType == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedServiceType = index;
                    });
                    HapticFeedbackHelper.lightImpact();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.orange
                                : Colors.grey[400],
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          serviceType,
                          style: TextStyle(
                            color: isSelected ? Colors.black : Colors.grey[600],
                            fontSize: 14,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // 右侧设置按钮
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.green, size: 24),
            onPressed: () {
              HapticFeedbackHelper.lightImpact();
              // TODO: 打开设置
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLocationBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text(
            "b47c858f8cGRr85Pdmaw".tr,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 20),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          hintText: "8125671f9czXNKXdOnZu".tr,
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
          suffixIcon: Icon(Icons.tune, color: Colors.grey[500]),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.orange, width: 2),
          ),
        ),
        style: const TextStyle(color: Colors.black),
        onChanged: (value) {
          // TODO: 搜索功能
        },
      ),
    );
  }

  Widget _buildCategoryGrid() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return _buildCategoryCard(category);
        },
      ),
    );
  }

  Widget _buildCategoryCard(CategoryItem category) {
    return GestureDetector(
      onTap: () {
        HapticFeedbackHelper.lightImpact();
        // TODO: 处理分类点击
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
          image: category.backgroundImage != null
              ? DecorationImage(
                  image: AssetImage(category.backgroundImage!),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.darken,
                  ),
                )
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: category.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(category.icon, color: category.color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              category.name,
              style: TextStyle(
                color: category.backgroundImage != null
                    ? Colors.white
                    : Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                shadows: category.backgroundImage != null
                    ? [
                        Shadow(
                          offset: const Offset(0, 1),
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ]
                    : null,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollableContent() {
    return CustomScrollView(
      slivers: [
        // 分类网格
        SliverToBoxAdapter(child: _buildCategoryGrid()),
        // 健康服务列表
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final healthService = _healthServices[index];
              return _buildHealthServiceCard(healthService);
            }, childCount: _healthServices.length),
          ),
        ),
      ],
    );
  }

  Widget _buildHealthServiceCard(HealthServiceItem healthService) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 服务图片
          Stack(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  color: Colors.grey[300],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.asset(
                    healthService.cardBackgroundImage ?? healthService.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.medical_services,
                          size: 50,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ),
              // 收藏按钮
              Positioned(
                top: 12,
                right: 12,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      healthService.isFavorite = !healthService.isFavorite;
                    });
                    HapticFeedbackHelper.lightImpact();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      healthService.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: healthService.isFavorite
                          ? Colors.red
                          : Colors.grey,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // 服务信息
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 服务名称和赞助标签
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        healthService.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (healthService.isSponsored) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "1452deafc6LpT9brXqMk".tr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 8),
                // 服务描述
                Text(
                  healthService.description,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                // 服务费用和服务时间
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.attach_money,
                            color: Colors.orange,
                            size: 12,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            healthService.serviceFee,
                            style: const TextStyle(
                              color: Colors.orange,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.access_time, color: Colors.grey[600], size: 12),
                    const SizedBox(width: 2),
                    Text(
                      healthService.serviceTime,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    const Spacer(),
                    // 评分
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 14),
                        const SizedBox(width: 2),
                        Text(
                          healthService.rating.toString(),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
}

class CategoryItem {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final String? backgroundImage;

  CategoryItem({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    this.backgroundImage,
  });
}

class HealthServiceItem {
  final String id;
  final String name;
  final String image;
  final String serviceFee;
  final String serviceTime;
  final double rating;
  final bool isSponsored;
  bool isFavorite;
  final String description;
  final String? cardBackgroundImage;

  HealthServiceItem({
    required this.id,
    required this.name,
    required this.image,
    required this.serviceFee,
    required this.serviceTime,
    required this.rating,
    required this.isSponsored,
    required this.isFavorite,
    required this.description,
    this.cardBackgroundImage,
  });
}
