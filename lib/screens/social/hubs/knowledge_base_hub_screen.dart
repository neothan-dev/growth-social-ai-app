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

class KnowledgeBaseHubScreen extends StatefulWidget {
  const KnowledgeBaseHubScreen({super.key});

  @override
  State<KnowledgeBaseHubScreen> createState() => _KnowledgeBaseHubScreenState();
}

class _KnowledgeBaseHubScreenState extends State<KnowledgeBaseHubScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<CourseItem> _courses = [];
  bool _isLoading = true;
  String _selectedCategory = "5c55a67935kzfPr7yfOk".tr;

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
    _courses.addAll([
      CourseItem(
        id: '1',
        title: "a1a234e4909Gu5w0XwC1".tr,
        description: "0af9a4923fRSqdukwFrN".tr,
        thumbnail: 'assets/images/social_custom/knowledge/weight_loss.jpg',
        duration: "f0b2103286SR4iC6MGyw".tr,
        lessons: 10,
        difficulty: CourseDifficulty.beginner,
        category: CourseCategory.nutrition,
        instructor: "f2815dffacYmWyq1wwZM".tr,
        rating: 4.8,
        students: 123,
        price: 0,
        isCompleted: false,
        progress: 0,
        tags: [
          "4b15901183JAb3dXaGAe".tr,
          "fd8f627cc1geVms3aoxK".tr,
          "6a98237a920hdnBl78Kd".tr,
        ],
      ),
      CourseItem(
        id: '2',
        title: "425ab06ad2b9xB8xGTZJ".tr,
        description: "120df06e99yjJSYgPfM4".tr,
        thumbnail:
            'assets/images/social_custom/knowledge/stress_management.jpg',
        duration: "23495e7cf2vKTvxQGfTh".tr,
        lessons: 7,
        difficulty: CourseDifficulty.beginner,
        category: CourseCategory.mentalHealth,
        instructor: "20c872b5fcdiCiB0xfQc".tr,
        rating: 4.7,
        students: 856,
        price: 0,
        isCompleted: false,
        progress: 0,
        tags: [
          "30fe3f304cjB9r2Z657a".tr,
          "1986a8d194D1UYHMWVuC".tr,
          "bb6d99572498LvMClVNs".tr,
        ],
      ),
      CourseItem(
        id: '3',
        title: "e3df674e65G4ENjtY2V5".tr,
        description: "19eb585dc0nUsY3xkGiF".tr,
        thumbnail: 'assets/images/social_custom/knowledge/running_safe.jpg',
        duration: "27a023decao6Bu4a9drj".tr,
        lessons: 8,
        difficulty: CourseDifficulty.intermediate,
        category: CourseCategory.fitness,
        instructor: "d620b63421bCwwZEBCZB".tr,
        rating: 4.9,
        students: 2103,
        price: 0,
        isCompleted: false,
        progress: 0,
        tags: [
          "591052c733Sgo9msMR19".tr,
          "a9d130d7959nYvgebDRB".tr,
          "afb63a620boeF0S6qoq5".tr,
        ],
      ),
      CourseItem(
        id: '4',
        title: "feed2f43d4GqWmLJrKWw".tr,
        description: "a11215abc9FFamhBFtKl".tr,
        thumbnail:
            'assets/images/social_custom/knowledge/sleep_optimization.jpg',
        duration: "37ac85d00c6jJCTaCWkz".tr,
        lessons: 6,
        difficulty: CourseDifficulty.beginner,
        category: CourseCategory.lifestyle,
        instructor: "64301441daNiRtZiQkhN".tr,
        rating: 4.6,
        students: 987,
        price: 0,
        isCompleted: false,
        progress: 0,
        tags: [
          "01324e540dKwRwpApriv".tr,
          "aa18b6dcd8OtRkLe1Xse".tr,
          "15d208d1b40S8WJlP5Gx".tr,
        ],
      ),
      CourseItem(
        id: '5',
        title: "333a8378d4KzM2D5tQZ8".tr,
        description: "8f3e47d74bllcsi6IHxZ".tr,
        thumbnail: 'assets/images/social_custom/knowledge/nutrition_art.jpg',
        duration: "4e4f5f74b54mSHdK40Qb".tr,
        lessons: 12,
        difficulty: CourseDifficulty.intermediate,
        category: CourseCategory.nutrition,
        instructor: "acc0e50f69WlU3jnRyL4".tr,
        rating: 4.8,
        students: 856,
        price: 0,
        isCompleted: false,
        progress: 0,
        tags: [
          "fd8f627cc1ytju8cIfEf".tr,
          "1e97638b16lpr9s70XCu".tr,
          "fe60e205a1SFOSTUE0ly".tr,
        ],
      ),
      CourseItem(
        id: '6',
        title: "3c2d8e43eeoY0C0UaLug".tr,
        description: "83201302bfHOHZN0BBAj".tr,
        thumbnail: 'assets/images/social_custom/knowledge/office_fitness.jpg',
        duration: "248b65d374DoBvaFjk9x".tr,
        lessons: 5,
        difficulty: CourseDifficulty.beginner,
        category: CourseCategory.fitness,
        instructor: "d93587efbb3KPbvLqcjk".tr,
        rating: 4.5,
        students: 2341,
        price: 0,
        isCompleted: false,
        progress: 0,
        tags: [
          "e8bfbc191cUKHI84d0ww".tr,
          "5d925cc69dTPMA16M19P".tr,
          "aa1b957b80vS2wtI6Qke".tr,
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
                        : _buildCourseList(),
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
              "4419315bf4gozcY2ZnNq".tr,
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

  Widget _buildCategoryTabs() {
    final categories = [
      "5c55a67935ViUpxLNb0F".tr,
      "fd8f627cc1Hc9WSbbeX6".tr,
      "5d925cc69dCmvyqsAXsq".tr,
      "1986a8d194gQEC6ssVro".tr,
      "bd1d41319dwtGnifXCDe".tr,
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
        backgroundColor: isSelected
            ? Color.fromARGB(255, 65, 255, 87).withValues(alpha: 0.9)
            : Colors.blue.withValues(alpha: 0.9),
        selectedColor: const Color.fromARGB(
          255,
          33,
          192,
          19,
        ).withValues(alpha: 0.8),
        checkmarkColor: Colors.white,
        side: BorderSide(
          color: isSelected
              ? const Color.fromARGB(255, 86, 255, 70).withValues(alpha: 0.8)
              : Colors.blue.withValues(alpha: 0.3),
        ),
      ),
    );
  }

  Widget _buildCourseList() {
    final filteredCourses = _selectedCategory == "5c55a67935itaqkis43u".tr
        ? _courses
        : _courses
              .where(
                (course) =>
                    _getCategoryDisplayName(course.category) ==
                    _selectedCategory,
              )
              .toList();

    return CustomScrollView(
      slivers: [
        _buildFeaturedCourses(),
        _buildCourseListSliver(filteredCourses),
      ],
    );
  }

  Widget _buildFeaturedCourses() {
    final featuredCourses = _courses.take(3).toList();

    return SliverToBoxAdapter(
      child: Container(
        height: 200,
        margin: const EdgeInsets.all(16),
        child: PageView.builder(
          itemCount: featuredCourses.length,
          itemBuilder: (context, index) {
            final course = featuredCourses[index];
            return _buildFeaturedCourseCard(course);
          },
        ),
      ),
    );
  }

  Widget _buildFeaturedCourseCard(CourseItem course) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            _getDifficultyColor(course.difficulty).withValues(alpha: 0.8),
            _getDifficultyColor(course.difficulty).withValues(alpha: 0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: _getDifficultyColor(
              course.difficulty,
            ).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // 背景装饰
          Positioned(
            top: -30,
            right: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            left: -20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // 内容
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.school, color: Colors.white, size: 24),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _getDifficultyText(course.difficulty),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  course.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  course.description,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 12,
                    height: 1.3,
                  ),
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.play_lesson, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${course.lessons}' + "b175b93b53ba7l28bvqM".tr,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.access_time, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      course.duration,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
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

  Widget _buildCourseListSliver(List<CourseItem> courses) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      sliver: SliverList.separated(
        itemBuilder: (context, index) =>
            _buildHorizontalCourseCard(courses[index]),
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: courses.length,
      ),
    );
  }

  Widget _buildHorizontalCourseCard(CourseItem course) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withValues(alpha: 0.04),
                Colors.white.withValues(alpha: 0.02),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: InkWell(
            onTap: () {
              HapticFeedbackHelper.lightImpact();
              // _startCourse(course);
            },
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          width: 132,
                          height: 92,
                          color: _getDifficultyColor(
                            course.difficulty,
                          ).withValues(alpha: 0.18),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.asset(
                                  course.thumbnail,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: Icon(
                                        Icons.school,
                                        color: _getDifficultyColor(
                                          course.difficulty,
                                        ),
                                        size: 40,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.55),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    _getDifficultyText(course.difficulty),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.65),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    course.duration,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 132,
                        height: 40,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            HapticFeedbackHelper.lightImpact();
                            _startCourse(course);
                          },
                          icon: const Icon(Icons.play_arrow, size: 18),
                          label: Text(
                            course.isCompleted
                                ? "e55efe652cZ6YvST4ijl".tr
                                : "d2bb025a2eot2sVtvI9R".tr,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.withValues(
                              alpha: 0.85,
                            ),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 132,
                        height: 40,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            HapticFeedbackHelper.lightImpact();
                            // _showCourseMenu(course);
                          },
                          icon: const Icon(Icons.menu, size: 18),
                          label: Text("52daa71ebcvgclRp2GY0".tr),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              156,
                              53,
                              235,
                            ).withValues(alpha: 0.85),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                course.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  height: 1.15,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${course.rating}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          course.description,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 13,
                            height: 1.35,
                          ),
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildTag(_getCategoryDisplayName(course.category)),
                            ...course.tags.take(2).map((t) => _buildTag(t)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          course.instructor,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 218, 255, 137),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            _buildStatItem(
                              Icons.access_time,
                              course.duration,
                              Colors.orange,
                            ),
                            const SizedBox(width: 5),
                            _buildStatItem(
                              Icons.trending_up,
                              _getDifficultyText(course.difficulty),
                              _getDifficultyColor(course.difficulty),
                            ),
                            // const SizedBox(width: 5),
                            // _buildStatItem(
                            //   Icons.school,
                            //   '${course.lessons * 2}' +
                            //       "9413ee4b11X4uk4dFh3o".tr,
                            //   Colors.blue,
                            // ),
                          ],
                        ),
                        const SizedBox(height: 1),
                        Row(
                          children: [
                            _buildStatItem(
                              Icons.play_lesson,
                              '${course.lessons} ' + "b175b93b53X94nuXUTqc".tr,
                              Colors.blue,
                            ),
                            const SizedBox(width: 8),
                            _buildStatItem(
                              Icons.people,
                              '${course.students} ' + "1e42c5e723VqgAetOZtj".tr,
                              Colors.green,
                            ),
                            const SizedBox(width: 6),
                            IconButton(
                              onPressed: () {
                                HapticFeedbackHelper.lightImpact();
                                _addToFavorites(course);
                              },
                              icon: Icon(
                                Icons.favorite_border,
                                color: Colors.white.withValues(alpha: 0.75),
                              ),
                              iconSize: 20,
                              style: IconButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(35, 35),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                visualDensity: VisualDensity.compact,
                              ),
                            ),
                            const SizedBox(width: 6),
                            IconButton(
                              onPressed: () {
                                HapticFeedbackHelper.lightImpact();
                                _shareCourse(course);
                              },
                              icon: Icon(
                                Icons.share,
                                color: Colors.white.withValues(alpha: 0.75),
                              ),
                              iconSize: 20,
                              style: IconButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(35, 35),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                visualDensity: VisualDensity.compact,
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
          ),
        ),
      ),
    );
  }

  // 旧的两列网格布局方法已弃用

  // 旧的纵向卡片（上图下文）方法已移除

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
        color: Colors.blue.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.4), width: 1),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: Colors.blue.shade300,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Color _getDifficultyColor(CourseDifficulty difficulty) {
    switch (difficulty) {
      case CourseDifficulty.beginner:
        return Colors.green;
      case CourseDifficulty.intermediate:
        return Colors.orange;
      case CourseDifficulty.advanced:
        return Colors.red;
    }
  }

  String _getDifficultyText(CourseDifficulty difficulty) {
    switch (difficulty) {
      case CourseDifficulty.beginner:
        return "cdff07650fOsuB0SN1gm".tr;
      case CourseDifficulty.intermediate:
        return "da2a633854hEElsGJmiG".tr;
      case CourseDifficulty.advanced:
        return "d6e61888b0lyLLrwaBgc".tr;
    }
  }

  String _getCategoryDisplayName(CourseCategory category) {
    switch (category) {
      case CourseCategory.nutrition:
        return "fd8f627cc1POm4S8ZvR9".tr;
      case CourseCategory.fitness:
        return "5d925cc69d3cz6WeSfey".tr;
      case CourseCategory.mentalHealth:
        return "1986a8d194s53PIBb27X".tr;
      case CourseCategory.lifestyle:
        return "bd1d41319dlKyvGc1DxU".tr;
    }
  }

  void _startCourse(CourseItem course) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("408dca61ceJcp6z1c1lo".tr + "${course.title}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("02fb50595c26JLEPz8NB".tr + "${course.instructor}"),
            Text("dbfc1f8d10hPyK1bSLdg".tr + "${course.duration}"),
            Text(
              "e0186077ee9ycFQPfVah".tr +
                  '${course.lessons}' +
                  "b175b93b53X94nuXUTqc".tr,
            ),
            Text(
              "225e5d20c5IQB53OAwGv".tr + _getDifficultyText(course.difficulty),
            ),
            const SizedBox(height: 8),
            Text("f8d9590a03QO5VGuqNBm".tr + "${course.description}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("2cd0f3be87mzHupIV54d".tr),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: 开始学习课程
            },
            child: Text("851cbbda27VMsb7tMeOt".tr),
          ),
        ],
      ),
    );
  }

  void _addToFavorites(CourseItem course) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("a15e78b658hcBfGwKoLj".tr + "${course.title}"),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _shareCourse(CourseItem course) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("644939cabdTrCkjl0yL6".tr + "${course.title}"),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class CourseItem {
  final String id;
  final String title;
  final String description;
  final String thumbnail;
  final String duration;
  final int lessons;
  final CourseDifficulty difficulty;
  final CourseCategory category;
  final String instructor;
  final double rating;
  final int students;
  final int price;
  bool isCompleted;
  int progress;
  final List<String> tags;

  CourseItem({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.duration,
    required this.lessons,
    required this.difficulty,
    required this.category,
    required this.instructor,
    required this.rating,
    required this.students,
    required this.price,
    required this.isCompleted,
    required this.progress,
    required this.tags,
  });
}

enum CourseDifficulty { beginner, intermediate, advanced }

enum CourseCategory { nutrition, fitness, mentalHealth, lifestyle }
