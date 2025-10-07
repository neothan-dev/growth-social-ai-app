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
import '../models/friend.dart';
import '../theme/app_theme.dart';

class FriendListItem extends StatelessWidget {
  final Friend friend;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool showLastMessage;
  final bool showUnreadBadge;

  const FriendListItem({
    super.key,
    required this.friend,
    this.onTap,
    this.onLongPress,
    this.showLastMessage = true,
    this.showUnreadBadge = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        padding: AppTheme.paddingMd,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: AppTheme.divider.withValues(alpha: 0.5),
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            _buildAvatar(),
            const SizedBox(width: 12),
            Expanded(child: _buildInfoArea()),
            _buildTrailingInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: friend.avatarUrl != null
                ? Colors.transparent
                : _getAvatarColor(),
            border: Border.all(
              color: friend.isOnline ? AppTheme.success : Colors.transparent,
              width: 2,
            ),
          ),
          child: friend.avatarUrl != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    friend.avatarUrl!,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildAvatarPlaceholder(),
                  ),
                )
              : _buildAvatarPlaceholder(),
        ),
        if (friend.isOnline && friend.chatType == ChatType.individual)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: AppTheme.success,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
        if (friend.isPinned)
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: AppTheme.warning,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.push_pin, size: 10, color: Colors.white),
            ),
          ),
      ],
    );
  }

  Widget _buildAvatarPlaceholder() {
    return Center(
      child: Text(
        friend.avatarPlaceholder,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
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
    return colors[friend.id % colors.length];
  }

  Widget _buildInfoArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                friend.displayName,
                style: AppTheme.h4.copyWith(
                  fontSize: 16,
                  color: AppTheme.textPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (friend.isMuted)
              const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Icon(
                  Icons.volume_off,
                  size: 16,
                  color: AppTheme.textSecondary,
                ),
              ),
            if (friend.chatType == ChatType.group)
              const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Icon(
                  Icons.group,
                  size: 16,
                  color: AppTheme.textSecondary,
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        if (showLastMessage && friend.lastMessage != null)
          Text(
            friend.lastMessage!,
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.textSecondary,
              fontSize: 13,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          )
        else if (friend.chatType == ChatType.individual)
          Text(
            friend.statusDisplay,
            style: AppTheme.bodySmall.copyWith(
              color: friend.isOnline
                  ? AppTheme.success
                  : AppTheme.textSecondary,
            ),
          )
        else
          Text(
            friend.statusMessage ?? '',
            style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary),
          ),
      ],
    );
  }

  Widget _buildTrailingInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (showLastMessage && friend.lastMessageTime != null)
          Text(
            friend.lastMessageTimeDisplay,
            style: AppTheme.caption.copyWith(color: AppTheme.textSecondary),
          ),
        const SizedBox(height: 4),
        if (showUnreadBadge && friend.unreadCount > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: friend.isMuted ? AppTheme.textSecondary : AppTheme.error,
              borderRadius: BorderRadius.circular(10),
            ),
            constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
            child: Text(
              friend.unreadCount > 99 ? '99+' : friend.unreadCount.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}

class ContactGroupHeader extends StatelessWidget {
  final ContactGroup group;
  final VoidCallback? onToggle;

  const ContactGroupHeader({super.key, required this.group, this.onToggle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onToggle,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: AppTheme.surface,
        child: Row(
          children: [
            Icon(
              group.isExpanded
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_right,
              color: AppTheme.textSecondary,
            ),
            const SizedBox(width: 8),
            Text(
              group.title,
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyFriendList extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onAction;
  final String? actionText;

  const EmptyFriendList({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onAction,
    this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppTheme.paddingXl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: AppTheme.textDisabled),
            const SizedBox(height: 24),
            Text(
              title,
              style: AppTheme.h3.copyWith(color: AppTheme.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (onAction != null && actionText != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(onPressed: onAction, child: Text(actionText!)),
            ],
          ],
        ),
      ),
    );
  }
}
