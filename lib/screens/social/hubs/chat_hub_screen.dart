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
import '../../../models/friend.dart';
import '../../../services/friend_service.dart';

class ChatHubScreen extends StatefulWidget {
  const ChatHubScreen({super.key});

  @override
  State<ChatHubScreen> createState() => _ChatHubScreenState();
}

class _ChatHubScreenState extends State<ChatHubScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final FriendService _friendService = FriendService();

  List<Friend> _recentChats = [];
  List<Friend> _onlineFriends = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final futures = await Future.wait([
        _friendService.getChatList(),
        _friendService.getFriends(),
      ]);

      _recentChats = futures[0];
      _onlineFriends = futures[1].where((f) => f.isOnline).toList();
    } catch (e) {
      // 处理错误
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlassmorphismBackgroundContainer(
        backgroundName: AppBackgrounds.societyBackground,
        blurSigma: 7.0,
        glassOpacity: 0.01,
        overlayColor: Colors.black.withValues(alpha: 0.15),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              _buildTabBar(),
              const SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildRecentChatsTab(),
                    _buildOnlineFriendsTab(),
                    _buildChatFeaturesTab(),
                  ],
                ),
              ),
            ],
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
              "c742ae1049aOq1Z3osQb".tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
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
                Icons.add_circle_outline,
                color: Colors.white,
                size: 20,
              ),
            ),
            onPressed: () {
              HapticFeedbackHelper.lightImpact();
              Navigator.pushNamed(context, '/society_screen');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: Colors.blue.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(12),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withValues(alpha: 0.7),
        tabs: [
          Tab(text: "0a2fd6939eI04aCwWhci".tr),
          Tab(text: "f0d9a044efpUMYLw4bui".tr),
          Tab(text: "827f14e1f3BdvOQzu2WS".tr),
        ],
      ),
    );
  }

  Widget _buildRecentChatsTab() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    if (_recentChats.isEmpty) {
      return _buildEmptyState(
        icon: Icons.chat_bubble_outline,
        title: "eb815f5c8c7BkTedkovb".tr,
        subtitle: "999da82f6aM21iKXnf0W".tr,
        actionText: "fac9062e90hA0Hv4X70Z".tr,
        onAction: () {
          Navigator.pushNamed(context, '/society_screen');
        },
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _recentChats.length,
      itemBuilder: (context, index) {
        final friend = _recentChats[index];
        return _buildChatItem(friend);
      },
    );
  }

  Widget _buildOnlineFriendsTab() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    if (_onlineFriends.isEmpty) {
      return _buildEmptyState(
        icon: Icons.people_outline,
        title: "929e06a2fewvDHkVlU90".tr,
        subtitle: "2e395a4d1eXVoqv0NyWd".tr,
        actionText: "72055beeb8urjROFvsz2".tr,
        onAction: () {
          // TODO: 邀请好友功能
        },
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _onlineFriends.length,
      itemBuilder: (context, index) {
        final friend = _onlineFriends[index];
        return _buildOnlineFriendItem(friend);
      },
    );
  }

  Widget _buildChatFeaturesTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildFeatureCard(
          icon: Icons.voice_chat,
          title: "b03bba3614zwzRZQgEMC".tr,
          subtitle: "9da0bf5728yJ5pZZ2DRn".tr,
          color: Colors.green,
          onTap: () {
            HapticFeedbackHelper.lightImpact();
            // TODO: 导航到语音聊天
          },
        ),
        _buildFeatureCard(
          icon: Icons.group,
          title: "35b49ee58aVg8vJlrsTF".tr,
          subtitle: "28e1aa1b39ExtGc1MJO0".tr,
          color: Colors.blue,
          onTap: () {
            HapticFeedbackHelper.lightImpact();
            // TODO: 群聊功能
          },
        ),
        _buildFeatureCard(
          icon: Icons.video_call,
          title: "613168135bzflVjIPKGW".tr,
          subtitle: "7694733938IDqGs7Iv9h".tr,
          color: Colors.purple,
          onTap: () {
            HapticFeedbackHelper.lightImpact();
            // TODO: 视频通话功能
          },
        ),
        _buildFeatureCard(
          icon: Icons.translate,
          title: "9e483ab8c9frryE0UJUQ".tr,
          subtitle: "29baedf92f115mYLzoSN".tr,
          color: Colors.orange,
          onTap: () {
            HapticFeedbackHelper.lightImpact();
            // TODO: 翻译功能
          },
        ),
        _buildFeatureCard(
          icon: Icons.emoji_emotions,
          title: "4efaa366c9SmTTVPJrdH".tr,
          subtitle: "f309ff9b996ImMStQ4mp".tr,
          color: Colors.pink,
          onTap: () {
            HapticFeedbackHelper.lightImpact();
            // TODO: 表情包功能
          },
        ),
      ],
    );
  }

  Widget _buildChatItem(Friend friend) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Stack(
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
                child: friend.avatarUrl != null
                    ? Image.asset(
                        friend.avatarUrl!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.blue.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Icon(
                              Icons.person,
                              color: Colors.blue.shade300,
                              size: 25,
                            ),
                          );
                        },
                      )
                    : Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.blue.shade300,
                          size: 25,
                        ),
                      ),
              ),
            ),
            if (friend.isOnline)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          friend.displayName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          friend.lastMessage ?? "3148e57793f1bIV2tsH5".tr,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 14,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (friend.unreadCount > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  friend.unreadCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(height: 4),
            Text(
              _formatTime(friend.lastMessageTime),
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 12,
              ),
            ),
          ],
        ),
        onTap: () {
          HapticFeedbackHelper.lightImpact();
          Navigator.pushNamed(
            context,
            '/friend_chat_screen',
            arguments: friend,
          );
        },
      ),
    );
  }

  Widget _buildOnlineFriendItem(Friend friend) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.green.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.green.withValues(alpha: 0.5),
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(23),
            child: friend.avatarUrl != null
                ? Image.asset(
                    friend.avatarUrl!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.green.shade300,
                          size: 25,
                        ),
                      );
                    },
                  )
                : Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.green.shade300,
                      size: 25,
                    ),
                  ),
          ),
        ),
        title: Text(
          friend.displayName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          friend.statusMessage ?? "b9086662b1Guzz5O3jV3".tr,
          style: TextStyle(color: Colors.green.shade300, fontSize: 14),
        ),
        trailing: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.chat_bubble_outline,
              color: Colors.white,
              size: 16,
            ),
          ),
          onPressed: () {
            HapticFeedbackHelper.lightImpact();
            Navigator.pushNamed(
              context,
              '/friend_chat_screen',
              arguments: friend,
            );
          },
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(icon, color: color, size: 25),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 14,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white.withValues(alpha: 0.5),
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
    required String actionText,
    required VoidCallback onAction,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Icon(
              icon,
              color: Colors.white.withValues(alpha: 0.5),
              size: 40,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onAction,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.withValues(alpha: 0.8),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(actionText),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime? time) {
    if (time == null) return "";

    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inMinutes < 1) return "de6785d99eFSC6ldRxde".tr;
    if (diff.inHours < 1)
      return "${diff.inMinutes}" + "f8083e0152MXGMm1vMPA".tr;
    if (diff.inDays < 1) return "${diff.inHours}" + "9ebf77f67bMpOVyPH57N".tr;
    if (diff.inDays < 7) return "${diff.inDays}" + "5972982ce69YHmLLma69".tr;

    return "${time.month}/${time.day}";
  }
}
