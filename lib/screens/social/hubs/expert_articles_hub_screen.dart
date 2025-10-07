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

class ExpertArticlesHubScreen extends StatefulWidget {
  const ExpertArticlesHubScreen({super.key});

  @override
  State<ExpertArticlesHubScreen> createState() =>
      _ExpertArticlesHubScreenState();
}

class _ExpertArticlesHubScreenState extends State<ExpertArticlesHubScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<ArticleItem> _articles = [];
  final List<QaItem> _qaItems = [];
  bool _isLoading = true;
  String _selectedTab = "7d5a89f6b1G5XZpK5hNI".tr;
  String _selectedCategory = "5c55a67935dD5mMScPRU".tr;

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
    _articles.addAll([
      ArticleItem(
        id: '1',
        title: "bc1b25ab5926OANZSspC".tr,
        summary: "756fe2e004R4lvnzBEjl".tr,
        thumbnail: 'assets/images/social_custom/articles/sleep_health.jpg',
        customBackgroundImage:
            'assets/images/social_custom/expert_article/Article4.jpg', // 自定义背景图片
        author: "75dfc105d2EWlY7CSLVZ".tr,
        authorTitle: "ea9ae281a9TkXap1wqnb".tr,
        publishTime: DateTime.now().subtract(const Duration(days: 10)),
        readTime: "df84f9da1cOX5kkAIgju".tr,
        category: ArticleCategory.lifestyle,
        tags: [
          "01324e540drEiEJVdHcb".tr,
          "aa18b6dcd87jC3RjTJbR".tr,
          "15d208d1b48eZlE1f7OE".tr,
        ],
        likes: 156,
        views: 834,
        isLiked: false,
      ),
      ArticleItem(
        id: '2',
        title: "adaadec2b6y9fgu4EIik".tr,
        summary: "c67d51a119wjYJLr0AzX".tr,
        thumbnail:
            'assets/images/social_custom/articles/post_workout_nutrition.jpg',
        customBackgroundImage:
            'assets/images/social_custom/expert_article/Article2.jpg', // 自定义背景图片

        author: "b9304ad4dfxRVvyJCUpV".tr,
        authorTitle: "1419f10399TnIlGQLmlf".tr,
        publishTime: DateTime.now().subtract(const Duration(days: 5)),
        readTime: "79d6e05aceOfZp6OIgDz".tr,
        category: ArticleCategory.fitness,
        tags: [
          "a9d130d795CifpBbwQWY".tr,
          "fd8f627cc1v836wR5HpK".tr,
          "e0534b8a4ejC5yRvqIAP".tr,
        ],
        likes: 189,
        views: 987,
        isLiked: false,
      ),
      ArticleItem(
        id: '3',
        title: "943bea1a90o7LHphyzbX".tr,
        summary: "fd8f1323f884gjuctXYm".tr,
        thumbnail: 'assets/images/social_custom/articles/weight_loss_plan.jpg',
        customBackgroundImage:
            'assets/images/social_custom/expert_article/Article1.jpg', // 自定义背景图片
        author: "8a3cbcee2dtmFaYQRGzk".tr,
        authorTitle: "7c8d7b91e4EovU4g1IkD".tr,
        publishTime: DateTime.now().subtract(const Duration(days: 2)),
        readTime: "d9c028b0a7zMWcYCvi40".tr,
        category: ArticleCategory.nutrition,
        tags: [
          "4b15901183dOywsmfPNg".tr,
          "fd8f627cc1U1HQVL7gJ8".tr,
          "0f6b1949b0dS1fF795tz".tr,
        ],
        likes: 234,
        views: 1234,
        isLiked: false,
      ),
      ArticleItem(
        id: '4',
        title: "af4f201634M2VgVv5Y0r".tr,
        summary: "547db92f55932p0TYzlk".tr,
        thumbnail: 'assets/images/social_custom/articles/stress_management.jpg',
        customBackgroundImage:
            'assets/images/social_custom/expert_article/Article3.jpg', // 自定义背景图片
        author: "a486371e3fc0g8ZtdJD4".tr,
        authorTitle: "152ca0f8ecYn6OJ9Lkd7".tr,
        publishTime: DateTime.now().subtract(const Duration(days: 7)),
        readTime: "4ede975934SQFYwExIzh".tr,
        category: ArticleCategory.mentalHealth,
        tags: [
          "30fe3f304cFFsEZUoIyE".tr,
          "1986a8d194yPIfNqXjAe".tr,
          "bb6d995724vInfh2QTnN".tr,
        ],
        likes: 312,
        views: 1567,
        isLiked: false,
      ),
    ]);

    _qaItems.addAll([
      QaItem(
        id: '1',
        question: "02802dff9eDexLMCxY41".tr,
        answer: "946353318eGavn3Mf72O".tr,
        expert: "8a3cbcee2d89X4M1Yi3a".tr,
        expertTitle: "7c8d7b91e4NgqniNjKL4".tr,
        category: QaCategory.nutrition,
        publishTime: DateTime.now().subtract(const Duration(days: 1)),
        likes: 45,
        isLiked: false,
      ),
      QaItem(
        id: '2',
        question: "37a08f0776j0Ckr9MnYz".tr,
        answer: "230b0adbb7Gg2VuUl4FG".tr,
        expert: "1ddcab5c34gx38IrVAY8".tr,
        expertTitle: "bc04e39ad9OMgu1cjjkU".tr,
        category: QaCategory.fitness,
        publishTime: DateTime.now().subtract(const Duration(days: 3)),
        likes: 67,
        isLiked: false,
      ),
      QaItem(
        id: '3',
        question: "cbc45d28b6v1RSiizF05".tr,
        answer: "2b6b224ae8PQaNg84jNa".tr,
        expert: "34758ff2eepcD5U2si9S".tr,
        expertTitle: "ba4891d410zyRjlm4NmF".tr,
        category: QaCategory.mentalHealth,
        publishTime: DateTime.now().subtract(const Duration(days: 5)),
        likes: 89,
        isLiked: false,
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
                  _buildTabBar(),
                  _buildCategoryTabs(),
                  Expanded(
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : _buildContent(),
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
              "54c6f5deea2HIk9AnuZM".tr,
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
              // TODO: 搜索功能
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTabButton(
              "7d5a89f6b1WYFaBMejT1".tr,
              _selectedTab == "7d5a89f6b199mmAhJqm8".tr,
            ),
          ),
          Expanded(
            child: _buildTabButton(
              "8d987a560dBeSeAXCpY2".tr,
              _selectedTab == "8d987a560dO38DGkiLr1".tr,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, bool isSelected) {
    return GestureDetector(
      onTap: () {
        HapticFeedbackHelper.lightImpact();
        setState(() {
          _selectedTab = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.green.withValues(alpha: 0.8)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : Colors.white.withValues(alpha: 0.7),
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    final categories = _selectedTab == "7d5a89f6b1eYkgTSV3nh".tr
        ? [
            "5c55a67935pe2C9T43Iz".tr,
            "fd8f627cc18NqY0Q2YZc".tr,
            "5d925cc69d6F0nPzL2kL".tr,
            "1986a8d194o77UWB5fH2".tr,
            "bd1d41319dodylibaWvH".tr,
          ]
        : [
            "5c55a67935n2CvqLQ7xg".tr,
            "fd8f627cc1NwB7MpILmE".tr,
            "5d925cc69dGqNHbQnBPO".tr,
            "1986a8d194XZkl6YmKmO".tr,
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
        selectedColor: Colors.green.withValues(alpha: 0.8),
        checkmarkColor: Colors.white,
        side: BorderSide(
          color: isSelected
              ? Colors.green.withValues(alpha: 0.8)
              : Colors.green.withValues(alpha: 0.3),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_selectedTab == "7d5a89f6b1rbS5bLxI3r".tr) {
      return _buildArticleList();
    } else {
      return _buildQaList();
    }
  }

  Widget _buildArticleList() {
    final filteredArticles = _selectedCategory == "5c55a67935gskPk90aKq".tr
        ? _articles
        : _articles
              .where(
                (article) =>
                    _getCategoryDisplayName(article.category) ==
                    _selectedCategory,
              )
              .toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredArticles.length,
      itemBuilder: (context, index) {
        final article = filteredArticles[index];
        return _buildArticleCard(article);
      },
    );
  }

  Widget _buildQaList() {
    final filteredQas = _selectedCategory == "5c55a67935bvMQEupR5l".tr
        ? _qaItems
        : _qaItems
              .where(
                (qa) =>
                    _getQaCategoryDisplayName(qa.category) == _selectedCategory,
              )
              .toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredQas.length,
      itemBuilder: (context, index) {
        final qa = filteredQas[index];
        return _buildQaCard(qa);
      },
    );
  }

  Widget _buildArticleCard(ArticleItem article) {
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
          // 文章缩略图
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: _getCategoryColor(article.category).withValues(alpha: 0.2),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Stack(
              children: [
                // 自定义背景图片层
                if (article.customBackgroundImage != null)
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.asset(
                        article.customBackgroundImage!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: _getCategoryColor(
                              article.category,
                            ).withValues(alpha: 0.2),
                          );
                        },
                      ),
                    ),
                  ),
                // 主缩略图层
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        image: article.customBackgroundImage != null
                            ? null
                            : DecorationImage(
                                image: AssetImage(article.thumbnail),
                                fit: BoxFit.cover,
                                onError: (exception, stackTrace) {
                                  // 错误处理在errorBuilder中处理
                                },
                              ),
                      ),
                      child: article.customBackgroundImage == null
                          ? Image.asset(
                              article.thumbnail,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: _getCategoryColor(
                                    article.category,
                                  ).withValues(alpha: 0.2),
                                  child: Center(
                                    child: Icon(
                                      Icons.article,
                                      color: _getCategoryColor(
                                        article.category,
                                      ),
                                      size: 32,
                                    ),
                                  ),
                                );
                              },
                            )
                          : null,
                    ),
                  ),
                ),
                // 渐变遮罩层（当有自定义背景时）
                if (article.customBackgroundImage != null)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.3),
                            Colors.black.withValues(alpha: 0.01),
                          ],
                        ),
                      ),
                    ),
                  ),
                // 阅读时间标签
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      article.readTime,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 文章信息
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  article.summary,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 14,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.white.withValues(alpha: 0.6),
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      article.author,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "· ${article.authorTitle}",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      _formatTime(article.publishTime),
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildStatItem(
                      Icons.remove_red_eye,
                      '${article.views}',
                      Colors.blue,
                    ),
                    const SizedBox(width: 16),
                    _buildStatItem(
                      Icons.favorite_border,
                      '${article.likes}',
                      Colors.red,
                    ),
                    const Spacer(),
                    _buildTag(_getCategoryDisplayName(article.category)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          HapticFeedbackHelper.lightImpact();
                          _readArticle(article);
                        },
                        icon: const Icon(Icons.article),
                        label: Text("5030b7480eHc5yETyVw5".tr),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.withValues(alpha: 0.8),
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
                        _toggleLike(article);
                      },
                      icon: Icon(
                        article.isLiked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: article.isLiked
                            ? Colors.red
                            : Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        HapticFeedbackHelper.lightImpact();
                        _shareArticle(article);
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

  Widget _buildQaCard(QaItem qa) {
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.help_outline, color: Colors.blue, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    qa.question,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.green.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "3c87dd4dadflYoASP6CH".tr,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    qa.answer,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.white.withValues(alpha: 0.6),
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  qa.expert,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  "· ${qa.expertTitle}",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                Text(
                  _formatTime(qa.publishTime),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildTag(_getQaCategoryDisplayName(qa.category)),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    HapticFeedbackHelper.lightImpact();
                    _toggleQaLike(qa);
                  },
                  icon: Icon(
                    qa.isLiked ? Icons.favorite : Icons.favorite_border,
                    color: qa.isLiked
                        ? Colors.red
                        : Colors.white.withValues(alpha: 0.7),
                  ),
                ),
                Text(
                  '${qa.likes}',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
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
        color: Colors.green.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.green.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: Colors.green.shade300,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Color _getCategoryColor(ArticleCategory category) {
    switch (category) {
      case ArticleCategory.nutrition:
        return Colors.orange;
      case ArticleCategory.fitness:
        return Colors.blue;
      case ArticleCategory.mentalHealth:
        return Colors.purple;
      case ArticleCategory.lifestyle:
        return Colors.green;
    }
  }

  String _getCategoryDisplayName(ArticleCategory category) {
    switch (category) {
      case ArticleCategory.nutrition:
        return "fd8f627cc1fYPUy5XoWl".tr;
      case ArticleCategory.fitness:
        return "5d925cc69dQlKXk9aItd".tr;
      case ArticleCategory.mentalHealth:
        return "1986a8d194pvVwIWTzQf".tr;
      case ArticleCategory.lifestyle:
        return "bd1d41319dbpsmZqiwPh".tr;
    }
  }

  String _getQaCategoryDisplayName(QaCategory category) {
    switch (category) {
      case QaCategory.nutrition:
        return "fd8f627cc1qWobXPCiHk".tr;
      case QaCategory.fitness:
        return "5d925cc69dmAZnAzVFHz".tr;
      case QaCategory.mentalHealth:
        return "1986a8d194uVUHq7bH4L".tr;
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return '${difference.inDays}' + "798440e7e9dTIXkBqX0g".tr;
    } else if (difference.inHours > 0) {
      return '${difference.inHours}' + "d0473c168eXIttzNFBPl".tr;
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}' + "7ece922500154AucBSnT".tr;
    } else {
      return "de6785d99eCRHrO6dz8I".tr;
    }
  }

  void _readArticle(ArticleItem article) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(article.title),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "82c0db872cl3nzGN7PxF".tr +
                    "${article.author} · ${article.authorTitle}",
              ),
              Text(
                "fe0f0c22535rOA8dGKBI".tr +
                    "${_formatTime(article.publishTime)}",
              ),
              Text("eaff58078fbmGybzSF6o".tr + "${article.readTime}"),
              const SizedBox(height: 16),
              Text(article.summary),
              const SizedBox(height: 16),
              Text("dd6d8167a1Z7yyMDKPpc".tr),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("3fd47edce4SRW6ZX3o9N".tr),
          ),
        ],
      ),
    );
  }

  void _toggleLike(ArticleItem article) {
    setState(() {
      article.isLiked = !article.isLiked;
      if (article.isLiked) {
        article.likes++;
      } else {
        article.likes--;
      }
    });
  }

  void _toggleQaLike(QaItem qa) {
    setState(() {
      qa.isLiked = !qa.isLiked;
      if (qa.isLiked) {
        qa.likes++;
      } else {
        qa.likes--;
      }
    });
  }

  void _shareArticle(ArticleItem article) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("764ebafe23zzEXVN0SnG".tr + "${article.title}"),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class ArticleItem {
  final String id;
  final String title;
  final String summary;
  final String thumbnail;
  final String? customBackgroundImage; // 自定义背景图片
  final String author;
  final String authorTitle;
  final DateTime publishTime;
  final String readTime;
  final ArticleCategory category;
  final List<String> tags;
  int likes;
  final int views;
  bool isLiked;

  ArticleItem({
    required this.id,
    required this.title,
    required this.summary,
    required this.thumbnail,
    this.customBackgroundImage, // 可选的自定义背景图片
    required this.author,
    required this.authorTitle,
    required this.publishTime,
    required this.readTime,
    required this.category,
    required this.tags,
    required this.likes,
    required this.views,
    required this.isLiked,
  });
}

class QaItem {
  final String id;
  final String question;
  final String answer;
  final String expert;
  final String expertTitle;
  final QaCategory category;
  final DateTime publishTime;
  int likes;
  bool isLiked;

  QaItem({
    required this.id,
    required this.question,
    required this.answer,
    required this.expert,
    required this.expertTitle,
    required this.category,
    required this.publishTime,
    required this.likes,
    required this.isLiked,
  });
}

enum ArticleCategory { nutrition, fitness, mentalHealth, lifestyle }

enum QaCategory { nutrition, fitness, mentalHealth }
