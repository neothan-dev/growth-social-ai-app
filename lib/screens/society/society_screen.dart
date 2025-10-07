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
import '../../models/friend.dart';
import '../../services/friend_service.dart';
import '../../widgets/friend_list_item.dart';
import '../../theme/app_theme.dart';
import '../chat/friend_chat_screen.dart';
import 'package:vital_ai/localization/app_localizations.dart';

class SocietyScreen extends StatefulWidget {
  const SocietyScreen({super.key});

  @override
  State<SocietyScreen> createState() => _SocietyScreenState();
}

class _SocietyScreenState extends State<SocietyScreen>
    with TickerProviderStateMixin {
  final FriendService _friendService = FriendService();
  final TextEditingController _searchController = TextEditingController();

  late TabController _tabController;

  List<Friend> _allFriends = [];
  List<Friend> _chatList = [];
  List<ContactGroup> _contactGroups = [];
  List<Friend> _searchResults = [];

  bool _isLoading = true;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: _buildAppBar(),
      body: _isLoading
          ? _buildLoadingView()
          : TabBarView(
              controller: _tabController,
              children: [_buildChatListView(), _buildContactsView()],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddFriendDialog,
        backgroundColor: AppTheme.primary,
        child: const Icon(Icons.person_add, color: Colors.white),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text("fa2242835eWmLPWEGg4L".tr, style: AppTheme.h3),
      backgroundColor: Colors.white,
      elevation: 1,
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: AppTheme.textPrimary),
          onPressed: _toggleSearch,
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: AppTheme.textPrimary),
          onSelected: _handleMenuAction,
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'add_friend',
              child: Row(
                children: [
                  Icon(Icons.person_add),
                  SizedBox(width: 8),
                  Text("fac9062e90sgkhFSl1aV".tr),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'create_group',
              child: Row(
                children: [
                  Icon(Icons.group_add),
                  SizedBox(width: 8),
                  Text("675ee6eef7HyYJ56pFPY".tr),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'qr_scan',
              child: Row(
                children: [
                  Icon(Icons.qr_code_scanner),
                  SizedBox(width: 8),
                  Text("6415984a10IhkNnMSGGZ".tr),
                ],
              ),
            ),
          ],
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(_isSearching ? 112 : 48),
        child: Column(
          children: [
            if (_isSearching) _buildSearchBox(),
            TabBar(
              controller: _tabController,
              labelColor: AppTheme.primary,
              unselectedLabelColor: AppTheme.textSecondary,
              indicatorColor: AppTheme.primary,
              tabs: [
                Tab(text: "4b3510b8d8kMALrwsjT3".tr),
                Tab(text: "06657c2795HkIbde7NMc".tr),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return Container(
      padding: AppTheme.paddingMd,
      color: Colors.white,
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "c45e09e871YdnFoU7xbL".tr,
          prefixIcon: const Icon(Icons.search, color: AppTheme.textSecondary),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: AppTheme.textSecondary),
                  onPressed: () {
                    _searchController.clear();
                    _performSearch('');
                  },
                )
              : null,
          filled: true,
          fillColor: AppTheme.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusXl),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        onChanged: _performSearch,
        autofocus: true,
      ),
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppTheme.primary),
          SizedBox(height: 16),
          Text("9dc0825fbahSGhobRjm7".tr, style: AppTheme.bodyMedium),
        ],
      ),
    );
  }

  Widget _buildChatListView() {
    final displayList = _isSearching ? _searchResults : _chatList;

    if (displayList.isEmpty) {
      return EmptyFriendList(
        title: _isSearching
            ? "ccb0650b97FIl5LT88jq".tr
            : "eb815f5c8cwsL2GV8ylC".tr,
        subtitle: _isSearching
            ? "c2db6e8bb0aXVUss2k3T".tr
            : "87ec72611csDH3srqw8n".tr,
        icon: _isSearching ? Icons.search_off : Icons.chat_bubble_outline,
        onAction: _isSearching ? null : _showAddFriendDialog,
        actionText: _isSearching ? null : "fac9062e90dj9CZlDWWR".tr,
      );
    }

    return ListView.builder(
      itemCount: displayList.length,
      itemBuilder: (context, index) {
        final friend = displayList[index];
        return FriendListItem(
          friend: friend,
          onTap: () => _openChat(friend),
          onLongPress: () => _showChatOptions(friend),
          showLastMessage: true,
          showUnreadBadge: true,
        );
      },
    );
  }

  Widget _buildContactsView() {
    if (_isSearching) {
      return _buildSearchResultsView();
    }

    return ListView.builder(
      itemCount: _contactGroups.length,
      itemBuilder: (context, index) {
        final group = _contactGroups[index];
        return Column(
          children: [
            ContactGroupHeader(
              group: group,
              onToggle: () => _toggleGroup(index),
            ),
            if (group.isExpanded)
              ...group.friends.map(
                (friend) => FriendListItem(
                  friend: friend,
                  onTap: () => _openChat(friend),
                  onLongPress: () => _showFriendOptions(friend),
                  showLastMessage: false,
                  showUnreadBadge: false,
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildSearchResultsView() {
    if (_searchResults.isEmpty) {
      return EmptyFriendList(
        title: "ccb0650b970hzh4MaGyP".tr,
        subtitle: "c2db6e8bb074JVUONsQT".tr,
        icon: Icons.search_off,
      );
    }

    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final friend = _searchResults[index];
        return FriendListItem(
          friend: friend,
          onTap: () => _openChat(friend),
          onLongPress: () => _showFriendOptions(friend),
          showLastMessage: false,
          showUnreadBadge: false,
        );
      },
    );
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    try {
      final futures = await Future.wait([
        _friendService.getFriends(),
        _friendService.getChatList(),
      ]);

      _allFriends = futures[0];
      _chatList = futures[1];
      _contactGroups = _friendService.getContactGroups();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("08417baa06HlV7D2WNsk".tr + '$e')));
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        _searchResults.clear();
      }
    });
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() => _searchResults.clear());
      return;
    }

    setState(() {
      _searchResults = _allFriends
          .where(
            (friend) =>
                friend.displayName.toLowerCase().contains(
                  query.toLowerCase(),
                ) ||
                friend.username.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  void _toggleGroup(int index) {
    setState(() {
      _contactGroups[index] = _contactGroups[index].copyWith(
        isExpanded: !_contactGroups[index].isExpanded,
      );
    });
  }

  void _openChat(Friend friend) {
    Navigator.of(context).pushNamed('/friend_chat_screen', arguments: friend);
  }

  void _showChatOptions(Friend friend) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: AppTheme.paddingLg,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                friend.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
              ),
              title: Text(
                friend.isPinned
                    ? "c92179b74aXfBxDVs2sZ".tr
                    : "856e892a3exoHnvJdXTx".tr,
              ),
              onTap: () {
                Navigator.pop(context);
                _togglePin(friend);
              },
            ),
            ListTile(
              leading: Icon(
                friend.isMuted ? Icons.volume_up : Icons.volume_off,
              ),
              title: Text(
                friend.isMuted
                    ? "382cefa937xVwrW0SwOF".tr
                    : "9cabb21770vhcTYPzqYH".tr,
              ),
              onTap: () {
                Navigator.pop(context);
                _toggleMute(friend);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: Text(
                "c82f2a0fadD9Nv3QHrWN".tr,
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.pop(context);
                _deleteChat(friend);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showFriendOptions(Friend friend) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: AppTheme.paddingLg,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.chat),
              title: Text("008814832cLnKVkI2PDX".tr),
              onTap: () {
                Navigator.pop(context);
                _openChat(friend);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text("b871bfd1feDpSO3NIK7X".tr),
              onTap: () {
                Navigator.pop(context);
                _viewProfile(friend);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_remove, color: Colors.red),
              title: Text(
                "3cb3cff22bZ6lX6elofk".tr,
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.pop(context);
                _removeFriend(friend);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'add_friend':
        _showAddFriendDialog();
        break;
      case 'create_group':
        _createGroup();
        break;
      case 'qr_scan':
        _scanQRCode();
        break;
    }
  }

  void _showAddFriendDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("fac9062e90qFHOnNOmZ3".tr),
        content: TextField(
          decoration: InputDecoration(
            labelText: "fdd0cf0455uQMYAPw6rs".tr,
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("2cd0f3be87c5cX6C9SL5".tr),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("0dabbbf5beTELOEAjVwu".tr)),
              );
            },
            child: Text("7a8a11ead5motw6K4qHq".tr),
          ),
        ],
      ),
    );
  }

  void _createGroup() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("6dc03d546bCT6Q8KhQni".tr)));
  }

  void _scanQRCode() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("789142f199M93NVAzmo1".tr)));
  }

  void _togglePin(Friend friend) {
    _friendService.pinFriend(friend.id, !friend.isPinned);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          friend.isPinned
              ? "b45a48730dzWWthRRtj9".tr
              : "d57cac53d1b8GMwJShmv".tr,
        ),
      ),
    );
    _loadData();
  }

  void _toggleMute(Friend friend) {
    _friendService.muteFriend(friend.id, !friend.isMuted);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          friend.isMuted
              ? "6c04a74c0bmhu2y23KNr".tr
              : "d9b648722czfvEJsVgks".tr,
        ),
      ),
    );
    _loadData();
  }

  void _deleteChat(Friend friend) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("c82f2a0fad1rTM9ePb1k".tr),
        content: Text(
          "ab51e4040d5dMeWIRUvV".tr +
              '${friend.displayName} ' +
              "b6d3e9ba54pwbuIedz6c".tr,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("2cd0f3be878pFv4bzoqE".tr),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("6dfc540cbe9R47YQMLb9".tr)),
              );
              _loadData();
            },
            child: Text(
              "fac2a67ad8H0Pq6E3kDL".tr,
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _viewProfile(Friend friend) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "9ae8f7e304LgfQJ3TvZ3".tr +
              '${friend.displayName} ' +
              "2238511399scdBIvKzgt".tr,
        ),
      ),
    );
  }

  void _removeFriend(Friend friend) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("3cb3cff22bkhAghTfmE8".tr),
        content: Text(
          "f648e84816sL6SpV2bg0".tr +
              '${friend.displayName} ' +
              "9d45d89439nd6wSfWGlK".tr,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("2cd0f3be87YDSet60DGg".tr),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _friendService.removeFriend(friend.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("08499e2c76E8vDdAF8Iw".tr)),
              );
              _loadData();
            },
            child: Text(
              "fac2a67ad8mYjAFI4JZH".tr,
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
