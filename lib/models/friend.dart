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

import 'package:vital_ai/localization/app_localizations.dart';

class Friend {
  final int id;
  final String username;
  final String displayName;
  final String? avatarUrl;
  final String? status;
  final String? statusMessage;
  final DateTime? lastSeen;
  final bool isOnline;
  final ChatType chatType;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final int unreadCount;
  final bool isMuted;
  final bool isBlocked;
  final bool isPinned;

  Friend({
    required this.id,
    required this.username,
    required this.displayName,
    this.avatarUrl,
    this.status = 'offline',
    this.statusMessage,
    this.lastSeen,
    this.isOnline = false,
    this.chatType = ChatType.individual,
    this.lastMessage,
    this.lastMessageTime,
    this.unreadCount = 0,
    this.isMuted = false,
    this.isBlocked = false,
    this.isPinned = false,
  });

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      id: json['id']?.toInt() ?? 0,
      username: json['username'] ?? '',
      displayName: json['display_name'] ?? json['username'] ?? '',
      avatarUrl: json['avatar_url'],
      status: json['status'] ?? 'offline',
      statusMessage: json['status_message'],
      lastSeen: json['last_seen'] != null
          ? DateTime.parse(json['last_seen'])
          : null,
      isOnline: json['is_online'] ?? false,
      chatType: ChatType.values.firstWhere(
        (e) => e.name == json['chat_type'],
        orElse: () => ChatType.individual,
      ),
      lastMessage: json['last_message'],
      lastMessageTime: json['last_message_time'] != null
          ? DateTime.parse(json['last_message_time'])
          : null,
      unreadCount: json['unread_count']?.toInt() ?? 0,
      isMuted: json['is_muted'] ?? false,
      isBlocked: json['is_blocked'] ?? false,
      isPinned: json['is_pinned'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'display_name': displayName,
      'avatar_url': avatarUrl,
      'status': status,
      'status_message': statusMessage,
      'last_seen': lastSeen?.toIso8601String(),
      'is_online': isOnline,
      'chat_type': chatType.name,
      'last_message': lastMessage,
      'last_message_time': lastMessageTime?.toIso8601String(),
      'unread_count': unreadCount,
      'is_muted': isMuted,
      'is_blocked': isBlocked,
      'is_pinned': isPinned,
    };
  }

  Friend copyWith({
    int? id,
    String? username,
    String? displayName,
    String? avatarUrl,
    String? status,
    String? statusMessage,
    DateTime? lastSeen,
    bool? isOnline,
    ChatType? chatType,
    String? lastMessage,
    DateTime? lastMessageTime,
    int? unreadCount,
    bool? isMuted,
    bool? isBlocked,
    bool? isPinned,
  }) {
    return Friend(
      id: id ?? this.id,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      status: status ?? this.status,
      statusMessage: statusMessage ?? this.statusMessage,
      lastSeen: lastSeen ?? this.lastSeen,
      isOnline: isOnline ?? this.isOnline,
      chatType: chatType ?? this.chatType,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      unreadCount: unreadCount ?? this.unreadCount,
      isMuted: isMuted ?? this.isMuted,
      isBlocked: isBlocked ?? this.isBlocked,
      isPinned: isPinned ?? this.isPinned,
    );
  }

  String get statusDisplay {
    if (isOnline) return "b9086662b171xq5ZbC4l".tr;
    if (status == 'away') return "7345ed45ceRq5mUVWQA0".tr;
    if (status == 'busy') return "2e260a37cb8AQZ5P6t9C".tr;
    if (lastSeen != null) {
      final now = DateTime.now();
      final difference = now.difference(lastSeen!);
      if (difference.inMinutes < 1) return "1fed3d54e9Dh9VgKmtgy".tr;
      if (difference.inHours < 1)
        return '${difference.inMinutes}' + "ce64419748ZnDmm03MR8".tr;
      if (difference.inDays < 1)
        return '${difference.inHours}' + "950e354813mOHAIRpi4Y".tr;
      return '${difference.inDays}' + "cd27dc1583gx53I43mTf".tr;
    }
    return "be1b4f3c6ceLtfiMxN72".tr;
  }

  String get lastMessageTimeDisplay {
    if (lastMessageTime == null) return '';

    final now = DateTime.now();
    final difference = now.difference(lastMessageTime!);

    if (difference.inMinutes < 1) return "de6785d99elsPzIdsUeO".tr;
    if (difference.inHours < 1)
      return '${difference.inMinutes}' + "6c078d9cf0lS0nV4BT0M".tr;
    if (difference.inDays < 1)
      return '${difference.inHours}' + "595c9daa17mvFIyqMbnk".tr;
    if (difference.inDays < 7)
      return '${difference.inDays}' + "ad841f709dX7KlYnYQQg".tr;

    return '${lastMessageTime!.month}/${lastMessageTime!.day}';
  }

  String get avatarPlaceholder {
    if (displayName.isNotEmpty) {
      return displayName.substring(0, 1).toUpperCase();
    }
    return username.substring(0, 1).toUpperCase();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Friend && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class GroupChat {
  final int id;
  final String name;
  final String? description;
  final String? avatarUrl;
  final List<Friend> members;
  final Friend? admin;
  final DateTime createdAt;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final int unreadCount;
  final bool isMuted;
  final bool isPinned;

  GroupChat({
    required this.id,
    required this.name,
    this.description,
    this.avatarUrl,
    required this.members,
    this.admin,
    required this.createdAt,
    this.lastMessage,
    this.lastMessageTime,
    this.unreadCount = 0,
    this.isMuted = false,
    this.isPinned = false,
  });

  factory GroupChat.fromJson(Map<String, dynamic> json) {
    return GroupChat(
      id: json['id']?.toInt() ?? 0,
      name: json['name'] ?? '',
      description: json['description'],
      avatarUrl: json['avatar_url'],
      members:
          (json['members'] as List<dynamic>?)
              ?.map((e) => Friend.fromJson(e))
              .toList() ??
          [],
      admin: json['admin'] != null ? Friend.fromJson(json['admin']) : null,
      createdAt: DateTime.parse(json['created_at']),
      lastMessage: json['last_message'],
      lastMessageTime: json['last_message_time'] != null
          ? DateTime.parse(json['last_message_time'])
          : null,
      unreadCount: json['unread_count']?.toInt() ?? 0,
      isMuted: json['is_muted'] ?? false,
      isPinned: json['is_pinned'] ?? false,
    );
  }

  Friend toFriend() {
    return Friend(
      id: id,
      username: name,
      displayName: name,
      avatarUrl: avatarUrl,
      status: 'group',
      statusMessage: '${members.length}' + "50f5d65d57S9crcMIQSF".tr,
      isOnline: false,
      chatType: ChatType.group,
      lastMessage: lastMessage,
      lastMessageTime: lastMessageTime,
      unreadCount: unreadCount,
      isMuted: isMuted,
      isPinned: isPinned,
    );
  }

  String get memberCountDisplay => '${members.length}人';

  String get avatarPlaceholder {
    if (name.isNotEmpty) {
      return name.substring(0, 1).toUpperCase();
    }
    return 'G';
  }
}

enum ChatType {
  individual,
  group,
}

class ContactGroup {
  final String title;
  final List<Friend> friends;
  final bool isExpanded;

  ContactGroup({
    required this.title,
    required this.friends,
    this.isExpanded = true,
  });

  ContactGroup copyWith({
    String? title,
    List<Friend>? friends,
    bool? isExpanded,
  }) {
    return ContactGroup(
      title: title ?? this.title,
      friends: friends ?? this.friends,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}
