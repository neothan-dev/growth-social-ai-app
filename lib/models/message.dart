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

enum MessageType { text, image, voice, video, file, location, system }

class Message {
  final String id;
  final String content;
  final String senderId;
  final String? senderName;
  final DateTime timestamp;
  final bool isUser;
  final MessageType type;
  final Map<String, dynamic>? metadata;

  Message({
    required this.id,
    required this.content,
    required this.senderId,
    this.senderName,
    required this.timestamp,
    this.isUser = false,
    this.type = MessageType.text,
    this.metadata,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] ?? '',
      content: json['content'] ?? '',
      senderId: json['sender_id'] ?? '',
      senderName: json['sender_name'],
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
      isUser: json['is_user'] ?? false,
      type: MessageType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => MessageType.text,
      ),
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'sender_id': senderId,
      'sender_name': senderName,
      'timestamp': timestamp.toIso8601String(),
      'is_user': isUser,
      'type': type.name,
      'metadata': metadata,
    };
  }

  Message copyWith({
    String? id,
    String? content,
    String? senderId,
    String? senderName,
    DateTime? timestamp,
    bool? isUser,
    MessageType? type,
    Map<String, dynamic>? metadata,
  }) {
    return Message(
      id: id ?? this.id,
      content: content ?? this.content,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      timestamp: timestamp ?? this.timestamp,
      isUser: isUser ?? this.isUser,
      type: type ?? this.type,
      metadata: metadata ?? this.metadata,
    );
  }
}
