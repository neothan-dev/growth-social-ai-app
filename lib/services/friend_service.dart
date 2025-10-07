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

import 'dart:async';
import '../models/friend.dart';
import '../localization/app_localizations.dart';

class FriendService {
  static final FriendService _instance = FriendService._internal();
  factory FriendService() => _instance;
  FriendService._internal();

  List<Friend> _friends = [];
  List<GroupChat> _groups = [];

  final StreamController<List<Friend>> _friendsController =
      StreamController<List<Friend>>.broadcast();
  final StreamController<List<GroupChat>> _groupsController =
      StreamController<List<GroupChat>>.broadcast();

  Stream<List<Friend>> get friendsStream => _friendsController.stream;

  Stream<List<GroupChat>> get groupsStream => _groupsController.stream;

  Future<List<Friend>> getFriends() async {
    try {
      await _loadMockData();
      _friendsController.add(_friends);
      return _friends;
    } catch (e) {
      print('获取好友列表失败: $e');
      return [];
    }
  }

  Future<List<GroupChat>> getGroups() async {
    try {
      await _loadMockGroupData();
      _groupsController.add(_groups);
      return _groups;
    } catch (e) {
      print('获取群聊列表失败: $e');
      return [];
    }
  }

  Future<List<Friend>> getChatList() async {
    try {
      await getFriends();
      await getGroups();

      List<Friend> chatList = [];

      chatList.addAll(_friends);

      chatList.addAll(_groups.map((group) => group.toFriend()));

      chatList.sort((a, b) {
        if (a.isPinned && !b.isPinned) return -1;
        if (!a.isPinned && b.isPinned) return 1;

        if (a.lastMessageTime == null && b.lastMessageTime == null) return 0;
        if (a.lastMessageTime == null) return 1;
        if (b.lastMessageTime == null) return -1;

        return b.lastMessageTime!.compareTo(a.lastMessageTime!);
      });

      return chatList;
    } catch (e) {
      print('获取聊天列表失败: $e');
      return [];
    }
  }

  Future<List<Friend>> searchFriends(String query) async {
    if (query.isEmpty) return _friends;

    return _friends
        .where(
          (friend) =>
              friend.displayName.toLowerCase().contains(query.toLowerCase()) ||
              friend.username.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  List<ContactGroup> getContactGroups() {
    List<ContactGroup> groups = [];

    final pinned = _friends.where((f) => f.isPinned).toList();
    if (pinned.isNotEmpty) {
      groups.add(
        ContactGroup(title: "da36660b9dBn2ojXfFC3".tr, friends: pinned),
      );
    }

    final online = _friends.where((f) => f.isOnline && !f.isPinned).toList();
    if (online.isNotEmpty) {
      groups.add(
        ContactGroup(
          title: "40d5b34dd7XUrzfknZNV".tr + '${online.length}' + ')',
          friends: online,
        ),
      );
    }

    final offline = _friends.where((f) => !f.isOnline && !f.isPinned).toList();
    if (offline.isNotEmpty) {
      groups.add(
        ContactGroup(
          title: "93e31285ac7Ym9y3Otha".tr + '${offline.length}' + ')',
          friends: offline,
        ),
      );
    }

    return groups;
  }

  Future<bool> addFriend(int userId) async {
    try {

      await Future.delayed(const Duration(milliseconds: 500));

      await getFriends();

      return true;
    } catch (e) {
      print('添加好友失败: $e');
      return false;
    }
  }

  Future<bool> removeFriend(int friendId) async {
    try {

      _friends.removeWhere((friend) => friend.id == friendId);
      _friendsController.add(_friends);

      return true;
    } catch (e) {
      print('删除好友失败: $e');
      return false;
    }
  }

  Future<bool> pinFriend(int friendId, bool isPinned) async {
    try {
      final index = _friends.indexWhere((friend) => friend.id == friendId);
      if (index != -1) {
        _friends[index] = _friends[index].copyWith(isPinned: isPinned);
        _friendsController.add(_friends);
        return true;
      }
      return false;
    } catch (e) {
      print('设置置顶失败: $e');
      return false;
    }
  }

  Future<bool> muteFriend(int friendId, bool isMuted) async {
    try {
      final index = _friends.indexWhere((friend) => friend.id == friendId);
      if (index != -1) {
        _friends[index] = _friends[index].copyWith(isMuted: isMuted);
        _friendsController.add(_friends);
        return true;
      }
      return false;
    } catch (e) {
      print('设置免打扰失败: $e');
      return false;
    }
  }

  void updateUnreadCount(int friendId, int count) {
    final index = _friends.indexWhere((friend) => friend.id == friendId);
    if (index != -1) {
      _friends[index] = _friends[index].copyWith(unreadCount: count);
      _friendsController.add(_friends);
    }
  }

  void updateLastMessage(int friendId, String message, DateTime time) {
    final index = _friends.indexWhere((friend) => friend.id == friendId);
    if (index != -1) {
      _friends[index] = _friends[index].copyWith(
        lastMessage: message,
        lastMessageTime: time,
      );
      _friendsController.add(_friends);
    }
  }

  Future<void> _loadMockData() async {
    await Future.delayed(const Duration(milliseconds: 300));

    _friends = [
      Friend(
        id: 1,
        username: 'alice_123',
        displayName: "69a629f4943FnVFVJ9sE".tr,
        avatarUrl: 'assets/images/avatar/avatar1.jpg',
        status: 'online',
        statusMessage: "44a22b5108Bl4H25tb4O".tr,
        isOnline: true,
        lastMessage: "3cdb175a31EFeshib1Vf".tr,
        lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
        unreadCount: 2,
        isPinned: true,
      ),
      Friend(
        id: 2,
        username: 'bob_456',
        displayName: "df3ea25a433m5W5tGfn2".tr,
        avatarUrl: 'assets/images/avatar/avatar2.jpg',
        status: 'away',
        statusMessage: "a214643ca6p0QcCSLHX5".tr,
        isOnline: false,
        lastSeen: DateTime.now().subtract(const Duration(hours: 2)),
        lastMessage: "483aecd627i1rAb0xPKs".tr,
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
        unreadCount: 0,
      ),
      Friend(
        id: 3,
        username: 'charlie_789',
        displayName: "73b784d6bfX8wXeDkRJk".tr,
        avatarUrl: 'assets/images/avatar/avatar3.jpg',
        status: 'busy',
        statusMessage: "dc03b1aebbw05JHFQpqq".tr,
        isOnline: true,
        lastMessage: "ac8beffdc1ToHf6NtvEx".tr,
        lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
        unreadCount: 1,
      ),
      Friend(
        id: 4,
        username: 'david_012',
        displayName: "0a0212636eOcGE1A60FC".tr,
        avatarUrl: 'assets/images/avatar/avatar4.jpg',
        status: 'offline',
        isOnline: false,
        lastSeen: DateTime.now().subtract(const Duration(days: 3)),
        lastMessage: "44cb4b7aa41tekj0VxQF".tr,
        lastMessageTime: DateTime.now().subtract(const Duration(days: 2)),
        unreadCount: 0,
      ),
      Friend(
        id: 5,
        username: 'emma_345',
        displayName: "570764f969oFVeBH4Eno".tr,
        avatarUrl: 'assets/images/avatar/avatar5.jpg',
        status: 'online',
        statusMessage: "a60caac6a6bbNwdYNSwo".tr,
        isOnline: true,
        lastMessage: "cc4266776brZgr2NyynJ".tr,
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 3)),
        unreadCount: 3,
      ),
    ];
  }

  Future<void> _loadMockGroupData() async {
    await Future.delayed(const Duration(milliseconds: 200));

    _groups = [
      GroupChat(
        id: 101,
        name: "08c3393cd6bUDNdwAFTf".tr,
        description: "f055253921omX3FjD05n".tr,
        avatarUrl: 'assets/images/avatar/avatar6.jpg',
        members: _friends.take(3).toList(),
        admin: _friends.first,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        lastMessage: "14df56fbffbGHdxtpZCh".tr,
        lastMessageTime: DateTime.now().subtract(const Duration(minutes: 30)),
        unreadCount: 5,
        isPinned: true,
      ),
      GroupChat(
        id: 102,
        name: "3fe2500012zSPKF0JoLr".tr,
        description: "78fb5575b6i5IRaqDacw".tr,
        avatarUrl: 'assets/images/avatar/avatar7.jpg',
        members: _friends.skip(1).take(4).toList(),
        admin: _friends[1],
        createdAt: DateTime.now().subtract(const Duration(days: 60)),
        lastMessage: "96ea86a9d5tFyzhOPK5e".tr,
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 4)),
        unreadCount: 0,
      ),
      GroupChat(
        id: 103,
        name: "4c8dc2d8aa2ckpx44lay".tr,
        description: "1fe5b872a7KsVN215yGO".tr,
        avatarUrl: 'assets/images/avatar/avatar1.jpg',
        members: _friends,
        admin: _friends[2],
        createdAt: DateTime.now().subtract(const Duration(days: 90)),
        lastMessage: "aa3cc2853cJFrEVwI4MS".tr,
        lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
        unreadCount: 2,
      ),
    ];
  }

  void dispose() {
    _friendsController.close();
    _groupsController.close();
  }
}
