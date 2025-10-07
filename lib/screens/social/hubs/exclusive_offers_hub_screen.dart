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

import 'dart:math';
import 'package:flutter/material.dart';
import '../../../utils/haptic_feedback_helper.dart';
import '../../../localization/app_localizations.dart';

class ExclusiveOffersHubScreen extends StatefulWidget {
  const ExclusiveOffersHubScreen({super.key});

  @override
  State<ExclusiveOffersHubScreen> createState() =>
      _ExclusiveOffersHubScreenState();
}

class _ExclusiveOffersHubScreenState extends State<ExclusiveOffersHubScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  // 已不再需要的分类显示名称函数移除

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<OfferItem> _offers = [];
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
    _offers.addAll([
      OfferItem(
        id: '1',
        title: "d254d14747X38q31vaCn".tr,
        description: "53e92b4988CCgGB6NnDE".tr,
        thumbnail: 'assets/images/social_custom/exclusive_offers/item-nike.jpg',
        brand: "Nike",
        originalPrice: 299,
        discountPrice: 199,
        discount: 33,
        category: OfferCategory.equipment,
        type: OfferType.discount,
        validUntil: DateTime.now().add(const Duration(days: 15)),
        isUsed: false,
        usageCount: 0,
        maxUsage: 1,
        tags: ["47845239deFz9loMwkre".tr, "349b21c03dc48oJ5RXur".tr, "Nike"],
      ),
      OfferItem(
        id: '2',
        title: "7aceea15307dInPIS1Jg".tr,
        description: "d2f8ee7415CBw4Cqa02A".tr,
        thumbnail:
            'assets/images/social_custom/exclusive_offers/item-premium.jpg',
        brand: "Keep",
        originalPrice: 0,
        discountPrice: 0,
        discount: 100,
        category: OfferCategory.service,
        type: OfferType.trial,
        validUntil: DateTime.now().add(const Duration(days: 30)),
        isUsed: false,
        usageCount: 0,
        maxUsage: 1,
        tags: [
          "7514256482EXA7asgZPc".tr,
          "0efb3a2095i3CcrXN1gt".tr,
          "dfdd0b8bf9Ek7QF8I8Pb".tr,
        ],
      ),
      OfferItem(
        id: '3',
        title: "29a08b9414hZ5ptiA32c".tr,
        description: "316164fc4bEaeV0lYfLQ".tr,
        thumbnail:
            'assets/images/social_custom/exclusive_offers/item-healthy_food_gift_pack.jpg',
        brand: "d5275a86916teJQS1B3I".tr,
        originalPrice: 158,
        discountPrice: 99,
        discount: 37,
        category: OfferCategory.food,
        type: OfferType.discount,
        validUntil: DateTime.now().add(const Duration(days: 20)),
        isUsed: false,
        usageCount: 0,
        maxUsage: 2,
        tags: [
          "e18854c413vFDQ00CgyB".tr,
          "cf6365151asIYvNigcad".tr,
          "fd8f627cc1Qpb26GHWmu".tr,
        ],
      ),
      OfferItem(
        id: '4',
        title: "636fc4637efM7bLAjgh2".tr,
        description: "9ae7b826dbDRxmh2MdOf".tr,
        thumbnail:
            'assets/images/social_custom/exclusive_offers/item-gym_trial.jpg',
        brand: "c765f827029kkwQdhKnT".tr,
        originalPrice: 0,
        discountPrice: 0,
        discount: 100,
        category: OfferCategory.service,
        type: OfferType.trial,
        validUntil: DateTime.now().add(const Duration(days: 45)),
        isUsed: false,
        usageCount: 0,
        maxUsage: 1,
        tags: [
          "ba08782b41qUbLFq751s".tr,
          "dfdd0b8bf9Ssy4iG34B0".tr,
          "e1a27c85d1n8hLwHzBBY".tr,
        ],
      ),
      OfferItem(
        id: '5',
        title: "d28ed3a778v7Bouew5lB".tr,
        description: "c6c9adffadZ51tfNuUYp".tr,
        thumbnail:
            'assets/images/social_custom/exclusive_offers/item-smart_watch.jpg',
        brand: "522d3edeb6osdHE98Uqe".tr,
        originalPrice: 199,
        discountPrice: 149,
        discount: 25,
        category: OfferCategory.equipment,
        type: OfferType.discount,
        validUntil: DateTime.now().add(const Duration(days: 10)),
        isUsed: false,
        usageCount: 0,
        maxUsage: 1,
        tags: [
          "e326e641b18V4aN2dxgU".tr,
          "08685556beTajCKBpSm7".tr,
          "522d3edeb6taF9ImZ8vU".tr,
        ],
      ),
      OfferItem(
        id: '6',
        title: "7d7c60769bPiW3Zcp24d".tr,
        description: "6acbef2e61KNGcoybTot".tr,
        thumbnail:
            'assets/images/social_custom/exclusive_offers/item-health_consultation.jpg',
        brand: "adfba1facbaz8Pxi16qB".tr,
        originalPrice: 200,
        discountPrice: 100,
        discount: 50,
        category: OfferCategory.service,
        type: OfferType.discount,
        validUntil: DateTime.now().add(const Duration(days: 25)),
        isUsed: false,
        usageCount: 0,
        maxUsage: 1,
        tags: [
          "06b5702477FSBcAXWVAk".tr,
          "e1202ad463S1FPUE6NYX".tr,
          "349b21c03d7NO6Qo6OpH".tr,
        ],
      ),
      OfferItem(
        id: '7',
        title: "96b090749cICCNJelE1Z".tr,
        description: "f727405eddznTThCyweV".tr,
        thumbnail: 'assets/images/social_custom/offers/yoga_class.jpg',
        brand: "9c73db9559ol5PnwL2aG".tr,
        originalPrice: 0,
        discountPrice: 0,
        discount: 100,
        category: OfferCategory.service,
        type: OfferType.trial,
        validUntil: DateTime.now().add(const Duration(days: 35)),
        isUsed: false,
        usageCount: 0,
        maxUsage: 1,
        tags: [
          "bd4e166240YjFG1Hu41b".tr,
          "60db1afb40bwu6dwfabz".tr,
          "dfdd0b8bf9MRgGnsxg8S".tr,
        ],
      ),
      OfferItem(
        id: '8',
        title: "cfef5a5a473oqeY4boNN".tr,
        description: "9ada0a45e2qji4YusPQY".tr,
        thumbnail:
            'assets/images/social_custom/exclusive_offers/category-food.jpg',
        brand: "85378cc7c7wwKCoNpDbR".tr,
        originalPrice: 299,
        discountPrice: 199,
        discount: 33,
        category: OfferCategory.food,
        type: OfferType.discount,
        validUntil: DateTime.now().add(const Duration(days: 12)),
        isUsed: false,
        usageCount: 0,
        maxUsage: 1,
        tags: [
          "435f5897b3nsojS5yLmp".tr,
          "5d925cc69dV6o5b5BOOz".tr,
          "fd8f627cc1lxfesgodf1".tr,
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
    // 采用浅色「Grocery」风格：白底、圆角搜索框、分类图标行、 featured cards、列表
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildHeader(theme)),
                SliverToBoxAdapter(child: _buildSearchField()),
                SliverToBoxAdapter(child: _buildGroceryCategories()),
                SliverToBoxAdapter(child: _buildFeaturedStores()),
                SliverToBoxAdapter(child: _buildResultsHeader()),
                _isLoading
                    ? const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      )
                    : _buildGroceryResultsList(),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              HapticFeedbackHelper.lightImpact();
              Navigator.of(context).maybePop();
            },
            icon: Image.asset(
              'assets/images/icons/dashboard_icon.png',
              width: 24,
              height: 24,
              color: Colors.black87,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.arrow_back, color: Colors.black87),
            ),
          ),
          const Spacer(),
          Text(
            "9852bb80afmTN8rU5V1D".tr,
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: _showMyOffers,
            borderRadius: BorderRadius.circular(24),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Image.asset(
                'assets/images/icons/improvement_icon.png',
                width: 20,
                height: 20,
                color: Colors.green,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.settings, color: Colors.green, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF0EDF4),
          borderRadius: BorderRadius.circular(28),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Image.asset(
              'assets/images/icons/dashboard_icon.png',
              width: 20,
              height: 20,
              color: Colors.black54,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.search, color: Colors.black54),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "aa24bf4654g51hlyRv5w".tr,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroceryCategories() {
    final items = [
      _CategoryItem(
        "61f96c6aacaZAjt2LpY6".tr,
        'assets/images/social_custom/exclusive_offers/category-store.jpg',
        const Color(0xFF9C7DF2),
      ),
      _CategoryItem(
        "abe69758fdVbtmqiXnkI".tr,
        'assets/images/social_custom/exclusive_offers/category-food.jpg',
        const Color(0xFF77D0A0),
      ),
      _CategoryItem(
        "4e98daedc28rdyhiIkNi".tr,
        'assets/images/social_custom/exclusive_offers/category-drinks.jpg',
        const Color(0xFF7EC8F3),
      ),
      _CategoryItem(
        "84c2f3c91ecs71ZzPduH".tr,
        'assets/images/social_custom/exclusive_offers/category-snacks.jpg',
        const Color(0xFFF7B3BA),
      ),
      _CategoryItem(
        "448cf8173fIaVUPXdCBi".tr,
        'assets/images/social_custom/exclusive_offers/category-meat.jpg',
        const Color(0xFFF59E8B),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 8, bottom: 12),
      child: SizedBox(
        height: 110,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final item = items[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: item.color.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      item.iconPath,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Icon(Icons.category, color: item.color, size: 36),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 80,
                  child: Text(
                    item.label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (_, __) => const SizedBox(width: 16),
          itemCount: items.length,
        ),
      ),
    );
  }

  Widget _buildFeaturedStores() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 0, 12),
      child: SizedBox(
        height: 180,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final backgroundImage = index.isEven
                ? 'assets/images/social_custom/exclusive_offers/co-op.jpg'
                : 'assets/images/social_custom/exclusive_offers/Iceland.jpg';
            final title = index.isEven ? "CO-OP" : "Iceland";
            final textColor = index.isEven
                ? const Color.fromARGB(255, 118, 207, 232)
                : const Color.fromARGB(255, 244, 151, 182);
            return Container(
              width: 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(backgroundImage),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {
                    // 如果图片加载失败，使用默认颜色
                  },
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.black.withOpacity(0.05),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            title,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 48,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 2,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        index.isEven ? "CO-OP" : "Iceland",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromARGB(
                            255,
                            255,
                            255,
                            255,
                          ).withOpacity(1),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 3,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "9623152ba728Lpy1aSaH".tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: const Color.fromARGB(
                            255,
                            255,
                            255,
                            255,
                          ).withOpacity(1),
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(width: 16),
          itemCount: 2,
        ),
      ),
    );
  }

  Widget _buildResultsHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ).copyWith(top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "04586a7eaaqWR8jeDzcf".tr,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 8),
          Text("b56273d3f4igHRIAwc0q".tr, style: TextStyle(fontSize: 15)),
        ],
      ),
    );
  }

  SliverList _buildGroceryResultsList() {
    // 用已有 _offers 构造两条示意数据
    final results = _offers.take(6).toList();
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final offer = results[index % results.length];
        return _buildResultRow(offer);
      }, childCount: results.length),
    );
  }

  Widget _buildResultRow(OfferItem offer) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(36),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              offer.thumbnail,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Center(
                child: Image.asset(
                  'assets/images/social_custom/community/option_health_monitoring.jpg',
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Icon(Icons.fastfood, color: Colors.orange.shade300),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  offer.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "907f8afa41yJpx1mIN81".tr,
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/images/icons/society_icon.png',
              width: 24,
              height: 24,
              color: Colors.black45,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.favorite_border, color: Colors.black45),
            ),
          ),
        ],
      ),
    );
  }

  // 旧版深色样式保留的组件（不再使用）已移除以减少警告。

  // 旧版转盘模块（不再使用）删除

  // 旧版网格模块（不再使用）删除

  // 原网格卡片实现已移除

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.purple.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.purple.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: Colors.purple.shade300,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Color _getCategoryColor(OfferCategory category) {
    switch (category) {
      case OfferCategory.equipment:
        return Colors.blue;
      case OfferCategory.food:
        return Colors.green;
      case OfferCategory.service:
        return Colors.orange;
    }
  }

  String _formatDate(DateTime date) {
    return "${date.month}/${date.day}";
  }

  void _useOffer(OfferItem offer) {
    if (offer.usageCount >= offer.maxUsage) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("3195076da9ILKN6YzQxU".tr),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      offer.usageCount++;
      if (offer.usageCount >= offer.maxUsage) {
        offer.isUsed = true;
      }
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("b1f0a95b83Ak2OjPT7kC".tr + "${offer.title}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("953189b28fhoIlCbwUct".tr + "${offer.brand}"),
            if (offer.type == OfferType.discount) ...[
              Text("2a6749233eV5wZU1N0EN".tr + "${offer.originalPrice}"),
              Text("b58d134265EvJ1pgxBJk".tr + "${offer.discountPrice}"),
            ] else ...[
              Text("6e8291c1ddJLFeYt27aB".tr),
            ],
            Text(
              "e3eb8a01624Nzjgj1wQ6".tr + "${_formatDate(offer.validUntil)}",
            ),
            const SizedBox(height: 16),
            Text(
              "c6250089cdZeJpK8qCMn".tr + "${_generateCouponCode(offer.id)}",
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "44f706f1d4K2TGpW52xk".tr,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("3fd47edce4Oy7zuBfA5T".tr),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("11c1902517Na4aQnfcA9".tr),
        backgroundColor: Colors.green,
      ),
    );
  }

  String _generateCouponCode(String offerId) {
    return "HEALTH${offerId.toUpperCase()}${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}";
  }

  void _shareOffer(OfferItem offer) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("e036f09ac7RJYKKRnVFT".tr + "${offer.title}"),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showMyOffers() {
    final usedOffers = _offers.where((offer) => offer.isUsed).toList();
    final availableOffers = _offers.where((offer) => !offer.isUsed).toList();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("4d9d18d106eSMUvECxfi".tr),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "098c81d35ckbwPsbFzaz".tr +
                    "${availableOffers.length}" +
                    "7aaf96ad52mUTJ5zr4Jf".tr,
              ),
              Text(
                "5df1463803gPYvTbAfmh".tr +
                    "${usedOffers.length}" +
                    "7aaf96ad52h66T9EVEt0".tr,
              ),
              const SizedBox(height: 16),
              if (availableOffers.isNotEmpty) ...[
                Text(
                  "098c81d35cY3cZ4eCO2q".tr,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ...availableOffers
                    .take(3)
                    .map(
                      (offer) => ListTile(
                        leading: Icon(
                          Icons.local_offer,
                          color: _getCategoryColor(offer.category),
                        ),
                        title: Text(offer.title),
                        subtitle: Text(
                          "5f4c6c9d91zIvS6f0OXF".tr +
                              "${_formatDate(offer.validUntil)}",
                        ),
                        dense: true,
                      ),
                    ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("3fd47edce4vslh7UU9C3".tr),
          ),
        ],
      ),
    );
  }
}

class _CategoryItem {
  final String label;
  final String iconPath;
  final Color color;
  const _CategoryItem(this.label, this.iconPath, this.color);
}

class OfferItem {
  final String id;
  final String title;
  final String description;
  final String thumbnail;
  final String brand;
  final int originalPrice;
  final int discountPrice;
  final int discount;
  final OfferCategory category;
  final OfferType type;
  final DateTime validUntil;
  bool isUsed;
  int usageCount;
  final int maxUsage;
  final List<String> tags;

  OfferItem({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.brand,
    required this.originalPrice,
    required this.discountPrice,
    required this.discount,
    required this.category,
    required this.type,
    required this.validUntil,
    required this.isUsed,
    required this.usageCount,
    required this.maxUsage,
    required this.tags,
  });
}

enum OfferCategory { equipment, food, service }

enum OfferType { discount, trial }

class WheelPainter extends CustomPainter {
  final List<OfferItem> offers;

  WheelPainter(this.offers);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paint = Paint()..style = PaintingStyle.fill;

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (int i = 0; i < offers.length; i++) {
      final startAngle = (i * 2 * 3.14159) / offers.length - 3.14159 / 2;
      final sweepAngle = 2 * 3.14159 / offers.length;

      // 绘制扇形
      final color = _getCategoryColor(offers[i].category);
      paint.color = color.withValues(alpha: 0.7);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      // 绘制分割线
      paint.color = Colors.white.withValues(alpha: 0.3);
      paint.strokeWidth = 2;
      paint.style = PaintingStyle.stroke;

      final endX = center.dx + radius * cos(startAngle + sweepAngle);
      final endY = center.dy + radius * sin(startAngle + sweepAngle);

      canvas.drawLine(center, Offset(endX, endY), paint);

      paint.style = PaintingStyle.fill;

      // 绘制文字
      final textAngle = startAngle + sweepAngle / 2;
      final textRadius = radius * 0.7;
      final textX = center.dx + textRadius * cos(textAngle);
      final textY = center.dy + textRadius * sin(textAngle);

      textPainter.text = TextSpan(
        text: offers[i].title.length > 4
            ? '${offers[i].title.substring(0, 4)}...'
            : offers[i].title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 8,
          fontWeight: FontWeight.bold,
        ),
      );

      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(textX - textPainter.width / 2, textY - textPainter.height / 2),
      );
    }
  }

  Color _getCategoryColor(OfferCategory category) {
    switch (category) {
      case OfferCategory.equipment:
        return Colors.blue;
      case OfferCategory.food:
        return Colors.green;
      case OfferCategory.service:
        return Colors.orange;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
