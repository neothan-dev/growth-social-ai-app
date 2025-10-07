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

class MomentsHubScreen extends StatefulWidget {
  const MomentsHubScreen({super.key});

  @override
  State<MomentsHubScreen> createState() => _MomentsHubScreenState();
}

class _MomentsHubScreenState extends State<MomentsHubScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<MomentItem> _moments = [];
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
    _moments.addAll([
      MomentItem(
        id: '1',
        userName: "91c2f3fd302uwCq70f2o".tr,
        userAvatar: 'assets/images/avatar/avatar1.jpg',
        content: "ecc45ff0b1xoN5t2cA60".tr,
        images: [
          'assets/images/social_custom/moments/fitness1.jpg',
          'assets/images/social_custom/moments/running1.jpg',
        ],
        likes: 24,
        comments: 8,
        time: DateTime.now().subtract(const Duration(hours: 2)),
        type: MomentType.fitness,
      ),
      MomentItem(
        id: '2',
        userName: "4225b3a2b5OGTJZtg1ru".tr,
        userAvatar: 'assets/images/avatar/avatar2.jpg',
        content: "4c50cf33cc2DJ1LUNGlp".tr,
        images: ['assets/images/social_custom/moments/breakfast.jpg'],
        likes: 18,
        comments: 5,
        time: DateTime.now().subtract(const Duration(hours: 4)),
        type: MomentType.food,
      ),
      MomentItem(
        id: '3',
        userName: "b3933aa686tWLhAfK6xF".tr,
        userAvatar: 'assets/images/avatar/avatar3.jpg',
        content: "590be8caf2H3MB4vfAPh".tr,
        images: [
          'assets/images/social_custom/moments/yoga1.jpg',
          'assets/images/social_custom/moments/yoga2.jpg',
          'assets/images/social_custom/moments/yoga3.jpg',
        ],
        likes: 32,
        comments: 12,
        time: DateTime.now().subtract(const Duration(hours: 6)),
        type: MomentType.yoga,
      ),
      MomentItem(
        id: '4',
        userName: "7fa2537e83aevTmbY1hc".tr,
        userAvatar: 'assets/images/avatar/avatar1.jpg',
        content: "75413f52eePLqmgqHOTl".tr,
        images: ['assets/images/social_custom/moments/gym.jpg'],
        likes: 15,
        comments: 6,
        time: DateTime.now().subtract(const Duration(hours: 8)),
        type: MomentType.fitness,
      ),
      MomentItem(
        id: '5',
        userName: "196361005dcj7SdSvXEv".tr,
        userAvatar: 'assets/images/avatar/avatar2.jpg',
        content: "fea5c931365MDXrvqpnD".tr,
        images: [
          'assets/images/social_custom/moments/marathon1.jpg',
          'assets/images/social_custom/moments/marathon2.jpg',
        ],
        likes: 45,
        comments: 15,
        time: DateTime.now().subtract(const Duration(hours: 12)),
        type: MomentType.running,
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
                  Expanded(
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : _buildMomentsList(),
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
          _showCreateMomentDialog();
        },
        backgroundColor: Colors.green.withValues(alpha: 0.8),
        child: const Icon(Icons.add, color: Colors.white),
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
              "c08aacda14YN1Ce49t49".tr,
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
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
            onPressed: () {
              HapticFeedbackHelper.lightImpact();
              _showCreateMomentDialog();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMomentsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _moments.length,
      itemBuilder: (context, index) {
        final moment = _moments[index];
        return _buildMomentCard(moment);
      },
    );
  }

  Widget _buildMomentCard(MomentItem moment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
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
            // 用户信息
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(23),
                    child: Image.asset(
                      moment.userAvatar,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: _getMomentTypeColor(
                              moment.type,
                            ).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Icon(
                            Icons.person,
                            color: _getMomentTypeColor(moment.type),
                            size: 25,
                          ),
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
                        moment.userName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        _formatTime(moment.time),
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_horiz,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                  onPressed: () {
                    HapticFeedbackHelper.lightImpact();
                    _showMomentOptions(moment);
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            // 内容
            Text(
              moment.content,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            // 图片网格
            if (moment.images.isNotEmpty) _buildImageGrid(moment.images),
            const SizedBox(height: 16),
            // 互动按钮
            Row(
              children: [
                _buildInteractionButton(
                  icon: Icons.favorite_border,
                  label: '${moment.likes}',
                  onTap: () {
                    HapticFeedbackHelper.lightImpact();
                    _toggleLike(moment);
                  },
                ),
                const SizedBox(width: 24),
                _buildInteractionButton(
                  icon: Icons.chat_bubble_outline,
                  label: '${moment.comments}',
                  onTap: () {
                    HapticFeedbackHelper.lightImpact();
                    _showComments(moment);
                  },
                ),
                const SizedBox(width: 24),
                _buildInteractionButton(
                  icon: Icons.share_outlined,
                  label: "7e564575ebs583OfO6h5".tr,
                  onTap: () {
                    HapticFeedbackHelper.lightImpact();
                    _shareMoment(moment);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageGrid(List<String> images) {
    if (images.length == 1) {
      return Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            images[0],
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.white.withValues(alpha: 0.1),
                child: Center(
                  child: Icon(
                    Icons.image_not_supported,
                    color: Colors.white.withValues(alpha: 0.5),
                    size: 40,
                  ),
                ),
              );
            },
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: images.length == 2 ? 2 : 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: images.length > 9 ? 9 : images.length,
      itemBuilder: (context, index) {
        if (index == 8 && images.length > 9) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '+${images.length - 9}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              images[index],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.white.withValues(alpha: 0.1),
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported,
                      color: Colors.white.withValues(alpha: 0.5),
                      size: 24,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildInteractionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: Colors.white.withValues(alpha: 0.7), size: 18),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Color _getMomentTypeColor(MomentType type) {
    switch (type) {
      case MomentType.fitness:
        return Colors.blue;
      case MomentType.food:
        return Colors.orange;
      case MomentType.yoga:
        return Colors.purple;
      case MomentType.running:
        return Colors.green;
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inMinutes < 1) return "de6785d99eWTHZdLByxR".tr;
    if (diff.inHours < 1)
      return "${diff.inMinutes}" + "f8083e0152NKwZsv5Vtd".tr;
    if (diff.inDays < 1) return "${diff.inHours}" + "9ebf77f67bgCMOBni6Jf".tr;
    if (diff.inDays < 7) return "${diff.inDays}" + "5972982ce61nFAorZtiO".tr;

    return "${time.month}/${time.day}";
  }

  void _toggleLike(MomentItem moment) {
    setState(() {
      if (moment.isLiked) {
        moment.likes--;
        moment.isLiked = false;
      } else {
        moment.likes++;
        moment.isLiked = true;
      }
    });
  }

  void _showComments(MomentItem moment) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    "98b75d51d3rXG6hJ7Jit".tr + "(${moment.comments})",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildCommentItem(
                    "f0fa0cc172Yv8gXeCzLN".tr,
                    "100ad953b5SyF7IS8gzM".tr,
                    "a25c6a13dbZkN5XIyUd9".tr,
                    0,
                  ),
                  _buildCommentItem(
                    "4225b3a2b5Tg1jllmkMX".tr,
                    "1eca104265amBFH5jaeg".tr,
                    "2561772ef6MR8V6b2ZYM".tr,
                    1,
                  ),
                  _buildCommentItem(
                    "b7d327d9bdmx4c7tRGEC".tr,
                    "66decb34cck5pcMZ59JI".tr,
                    "1c01535c9ekxUoTewwWP".tr,
                    2,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "dcdaf26dbcMBNu7wIjFI".tr,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      // TODO: 发送评论
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentItem(
    String name,
    String content,
    String time,
    int index,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.grey.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/images/avatar/avatar${(index % 3) + 1}.jpg',
                width: 32,
                height: 32,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.blue.shade300,
                      size: 16,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(content, style: const TextStyle(fontSize: 14)),
                Text(
                  time,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showMomentOptions(MomentItem moment) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: Text("05183656991ZWkgKhpOq".tr),
              onTap: () {
                Navigator.pop(context);
                // TODO: 编辑动态
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: Text(
                "2f9daa8289eUlIAtZSnG".tr,
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.pop(context);
                _deleteMoment(moment);
              },
            ),
            ListTile(
              leading: const Icon(Icons.report),
              title: Text("d2433b5adckT8Ar5ZPwG".tr),
              onTap: () {
                Navigator.pop(context);
                // TODO: 举报功能
              },
            ),
          ],
        ),
      ),
    );
  }

  void _deleteMoment(MomentItem moment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("9ea22e0becXuUbCR9JKQ".tr),
        content: Text("4bf008c5d0mz4tTVJvrF".tr),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("2cd0f3be875bv09KUMtW".tr),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _moments.remove(moment);
              });
              Navigator.pop(context);
            },
            child: Text(
              "2f9daa8289JDkP91YbSt".tr,
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _shareMoment(MomentItem moment) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("5bdfb8ce2apk4dvFFQ1H".tr),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showCreateMomentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("bab9970c67AizVqSB9kb".tr),
        content: Text("b9dd9b1d43a7vaiKr5to".tr),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("fac2a67ad8VxM4BkCGdD".tr),
          ),
        ],
      ),
    );
  }
}

class MomentItem {
  final String id;
  final String userName;
  final String userAvatar;
  final String content;
  final List<String> images;
  int likes;
  final int comments;
  final DateTime time;
  final MomentType type;
  bool isLiked;

  MomentItem({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.content,
    required this.images,
    required this.likes,
    required this.comments,
    required this.time,
    required this.type,
    this.isLiked = false,
  });
}

enum MomentType { fitness, food, yoga, running }
