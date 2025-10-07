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
import '../../models/message.dart';
import '../../widgets/background_container.dart';
import '../../utils/asset_manager.dart';
import '../../theme/app_theme.dart';
import '../../localization/app_localizations.dart';

class FriendChatScreen extends StatefulWidget {
  final Friend friend;

  const FriendChatScreen({super.key, required this.friend});

  @override
  State<FriendChatScreen> createState() => _FriendChatScreenState();
}

class _FriendChatScreenState extends State<FriendChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadMockMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BackgroundContainer(
        backgroundName: AppBackgrounds.friendChatBackground,
        overlayColor: Colors.black.withValues(alpha: 0.055),
        child: Column(
          children: [
            Expanded(child: _buildMessageList()),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black87),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Row(
        children: [
          _buildAvatar(size: 36),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.friend.displayName,
                  style: AppTheme.h4.copyWith(color: Colors.black87),
                ),
                if (widget.friend.chatType == ChatType.individual)
                  Text(
                    widget.friend.statusDisplay,
                    style: AppTheme.bodySmall.copyWith(
                      color: widget.friend.isOnline
                          ? AppTheme.success
                          : AppTheme.textSecondary,
                    ),
                  ),
                if (widget.friend.chatType == ChatType.group)
                  Text(
                    widget.friend.statusMessage ?? '',
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        if (widget.friend.chatType == ChatType.individual) ...[
          IconButton(
            icon: const Icon(Icons.phone, color: Colors.black87),
            onPressed: () => _startVoiceCall(),
          ),
          IconButton(
            icon: const Icon(Icons.videocam, color: Colors.black87),
            onPressed: () => _startVideoCall(),
          ),
        ],
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: Colors.black87),
          onSelected: _handleMenuAction,
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'info',
              child: Row(
                children: [
                  Icon(Icons.info_outline),
                  SizedBox(width: 8),
                  Text("5d9146e568VMKpCYYvni".tr),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'mute',
              child: Row(
                children: [
                  Icon(
                    widget.friend.isMuted ? Icons.volume_up : Icons.volume_off,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.friend.isMuted
                        ? "382cefa937QCUeXz5lSq".tr
                        : "9cabb21770M2Vk6XRLfX".tr,
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'pin',
              child: Row(
                children: [
                  Icon(
                    widget.friend.isPinned
                        ? Icons.push_pin
                        : Icons.push_pin_outlined,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.friend.isPinned
                        ? "c92179b74aoZeHro9xRS".tr
                        : "856e892a3eE52MxuZYIA".tr,
                  ),
                ],
              ),
            ),
            if (widget.friend.chatType == ChatType.individual)
              PopupMenuItem(
                value: 'clear',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, color: Colors.red),
                    SizedBox(width: 8),
                    Text(
                      "4ab794bf9ftbpyw4tcj1".tr,
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildAvatar({required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.friend.avatarUrl != null
            ? Colors.transparent
            : _getAvatarColor(),
        border: Border.all(
          color: widget.friend.isOnline ? AppTheme.success : Colors.transparent,
          width: 2,
        ),
      ),
      child: widget.friend.avatarUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(size / 2),
              child: Image.asset(
                widget.friend.avatarUrl!,
                width: size,
                height: size,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildAvatarPlaceholder(size),
              ),
            )
          : _buildAvatarPlaceholder(size),
    );
  }

  /// 构建当前用户头像
  Widget _buildCurrentUserAvatar({required double size}) {
    // 使用avatar3.jpg作为当前用户的头像
    const currentUserAvatar = 'assets/images/avatar/avatar3.jpg';

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppTheme.primary, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: Image.asset(
          currentUserAvatar,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: AppTheme.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  "我",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size * 0.4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// 构建头像占位符
  Widget _buildAvatarPlaceholder(double size) {
    return Center(
      child: Text(
        widget.friend.avatarPlaceholder,
        style: TextStyle(
          color: Colors.white,
          fontSize: size * 0.4,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getAvatarColor() {
    final colors = [
      AppTheme.primary,
      AppTheme.secondary,
      Colors.purple,
      Colors.green,
      Colors.orange,
      Colors.teal,
    ];
    return colors[widget.friend.id % colors.length];
  }

  Widget _buildMessageList() {
    if (_messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.friend.chatType == ChatType.group
                  ? Icons.group_outlined
                  : Icons.chat_outlined,
              size: 64,
              color: Colors.white.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              widget.friend.chatType == ChatType.group
                  ? "ee556fe0ce7N8h6Lj6oy".tr
                  : "e78bf9f1d3NKPGEYnadD".tr +
                        '${widget.friend.displayName} ' +
                        "bbfd50baf5sBTakv3dxX".tr,
              style: AppTheme.h4.copyWith(
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: AppTheme.paddingMd,
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        return _buildMessageBubble(message);
      },
    );
  }

  Widget _buildMessageBubble(Message message) {
    final isFromMe = message.senderId.toString() == 'me';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: isFromMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isFromMe) ...[_buildAvatar(size: 32), const SizedBox(width: 8)],
          Flexible(
            child: Container(
              padding: AppTheme.paddingMd,
              decoration: BoxDecoration(
                color: isFromMe
                    ? AppTheme.primary
                    : Colors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                boxShadow: AppTheme.shadowSm,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isFromMe && widget.friend.chatType == ChatType.group)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        message.senderName ?? '',
                        style: AppTheme.bodySmall.copyWith(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  Text(
                    message.content,
                    style: AppTheme.bodyMedium.copyWith(
                      color: isFromMe ? Colors.white : AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatMessageTime(message.timestamp),
                    style: AppTheme.caption.copyWith(
                      color: isFromMe
                          ? Colors.white.withValues(alpha: 0.8)
                          : AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isFromMe) ...[
            const SizedBox(width: 8),
            _buildCurrentUserAvatar(size: 32),
          ],
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: AppTheme.paddingMd,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppTheme.divider)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.add, color: AppTheme.primary),
              onPressed: () => _showMoreOptions(),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                ),
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: "5e7ed2e27dKi67Jy2znn".tr,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  maxLines: null,
                  textInputAction: TextInputAction.newline,
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.mic, color: AppTheme.primary),
              onPressed: () => _startVoiceMessage(),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: AppTheme.primary),
              onPressed: () => _sendMessage(),
            ),
          ],
        ),
      ),
    );
  }

  String _formatMessageTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inMinutes < 1) return "de6785d99evI8k9EkhPV".tr;
    if (diff.inHours < 1)
      return '${diff.inMinutes}' + "6c078d9cf0tbZ8YzDcVn".tr;
    if (diff.inDays < 1) return '${diff.inHours}' + "595c9daa17yFW7ufVYpm".tr;

    return '${time.month}/${time.day} ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  void _sendMessage() {
    final content = _messageController.text.trim();
    if (content.isEmpty) return;

    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: 'me',
      senderName: "b70bb4acc03cAyCs0bGc".tr,
      content: content,
      timestamp: DateTime.now(),
      type: MessageType.text,
    );

    setState(() {
      _messages.add(message);
      _messageController.clear();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _startVoiceMessage() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("6a6981e5e4WY0T7kKeKq".tr)));
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: AppTheme.paddingLg,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMoreOption(Icons.photo, "38793c1c1cIiHAKqXiAI".tr, () {}),
                _buildMoreOption(
                  Icons.camera_alt,
                  "6e3a10ade7y2euGZO0EB".tr,
                  () {},
                ),
                _buildMoreOption(
                  Icons.location_on,
                  "1fb4d574daHgOtyxABqZ".tr,
                  () {},
                ),
                _buildMoreOption(
                  Icons.attach_file,
                  "39932f24feR47fh2g6u6".tr,
                  () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMoreOption(
                  Icons.favorite,
                  "c762ed73d4Lfuxzn16wN".tr,
                  () {},
                ),
                _buildMoreOption(
                  Icons.videocam,
                  "613168135b7lm7Srx9UH".tr,
                  _startVideoCall,
                ),
                _buildMoreOption(
                  Icons.phone,
                  "ac52b279351nWUkodyXK".tr,
                  _startVoiceCall,
                ),
                _buildMoreOption(
                  Icons.more_horiz,
                  "38844b135cN0tPySa3so".tr,
                  () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoreOption(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: AppTheme.surface,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppTheme.primary),
          ),
          const SizedBox(height: 8),
          Text(label, style: AppTheme.bodySmall),
        ],
      ),
    );
  }

  void _startVoiceCall() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "c3d4978b52lkGlKL5pIY".tr +
              '${widget.friend.displayName}' +
              "ab5df625bcx2owSsWLH2".tr,
        ),
      ),
    );
  }

  void _startVideoCall() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "4dc044e5a3NB1lNTEDvz".tr +
              '${widget.friend.displayName}' +
              "ab5df625bcnSnG7gdp2f".tr,
        ),
      ),
    );
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'info':
        _showChatInfo();
        break;
      case 'mute':
        _toggleMute();
        break;
      case 'pin':
        _togglePin();
        break;
      case 'clear':
        _clearChatHistory();
        break;
    }
  }

  void _showChatInfo() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("06c2de9627BVLC6Ib2Y8".tr)));
  }

  void _toggleMute() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.friend.isMuted
              ? "6c04a74c0b1duYW9VFsm".tr
              : "d9b648722cY75ArFnDc2".tr,
        ),
      ),
    );
  }

  void _togglePin() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.friend.isPinned
              ? "b45a48730dcSj2gGOm4H".tr
              : "d57cac53d1mgEODTGJAF".tr,
        ),
      ),
    );
  }

  void _clearChatHistory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("4ab794bf9f2w4mu2C88J".tr),
        content: Text("06c2de9627BVLC6Ib2Y8".tr),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("2cd0f3be87Ea53YZ4NNx".tr),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _messages.clear();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("c39258448dcBhFJ0F3Z8".tr)),
              );
            },
            child: Text(
              "fac2a67ad8zYkbLhCMrj".tr,
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _loadMockMessages() {
    _messages.addAll([
      Message(
        id: '1',
        senderId: widget.friend.id.toString(),
        senderName: widget.friend.displayName,
        content: "ecde115cdc8dnEnxRTBI".tr,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        type: MessageType.text,
      ),
      Message(
        id: '2',
        senderId: 'me',
        senderName: "b70bb4acc08UIJcLmlLA".tr,
        content: "3cdb175a31jdEiPdzp9t".tr,
        timestamp: DateTime.now().subtract(
          const Duration(hours: 1, minutes: 30),
        ),
        type: MessageType.text,
      ),
      Message(
        id: '3',
        senderId: widget.friend.id.toString(),
        senderName: widget.friend.displayName,
        content: "8dc7070678c7QKD8mCMF".tr,
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        type: MessageType.text,
      ),
    ]);
  }
}
