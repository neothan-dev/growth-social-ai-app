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

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import '../models/message.dart';

class ChatStorageSQLiteService {
  static const String _databaseName = 'chat_history.db';
  static const int _databaseVersion = 2;

  static final ChatStorageSQLiteService _instance =
      ChatStorageSQLiteService._internal();
  factory ChatStorageSQLiteService() => _instance;
  ChatStorageSQLiteService._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final dbDir = join(databasesPath, 'db');

    final dbDirectory = Directory(dbDir);
    if (!await dbDirectory.exists()) {
      await dbDirectory.create(recursive: true);
    }

    final path = join(dbDir, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE messages (
        id TEXT PRIMARY KEY,
        user_id INTEGER NOT NULL,
        content TEXT NOT NULL,
        sender_id TEXT NOT NULL,
        timestamp TEXT NOT NULL,
        is_user INTEGER NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE chat_sessions (
        id TEXT PRIMARY KEY,
        user_id INTEGER NOT NULL,
        title TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        message_count INTEGER DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE backups (
        id TEXT PRIMARY KEY,
        user_id INTEGER NOT NULL,
        filename TEXT NOT NULL,
        created_at TEXT NOT NULL,
        file_size INTEGER,
        message_count INTEGER
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      if (kDebugMode) {
        print('数据库从版本 $oldVersion 升级到 $newVersion');
      }

      if (oldVersion < 2) {
        await db.execute('DROP TABLE IF EXISTS messages');
        await db.execute('DROP TABLE IF EXISTS chat_sessions');
        await db.execute('DROP TABLE IF EXISTS backups');

        await _onCreate(db, newVersion);
      }
    }
  }

  Future<bool> saveChatHistory(List<Message> messages, int userId) async {
    try {
      final db = await database;
      await db.transaction((txn) async {
        await txn.delete('messages', where: 'user_id = ?', whereArgs: [userId]);

        for (final message in messages) {
          await txn.insert('messages', {
            'id': message.id,
            'user_id': userId,
            'content': message.content,
            'sender_id': message.senderId,
            'timestamp': message.timestamp.toIso8601String(),
            'is_user': message.isUser ? 1 : 0,
            'created_at': DateTime.now().toIso8601String(),
          });
        }
      });
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('保存聊天记录失败: $e');
      }
      return false;
    }
  }

  Future<List<Message>> loadChatHistory(int userId) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        'messages',
        where: 'user_id = ?',
        whereArgs: [userId],
        orderBy: 'timestamp ASC',
      );

      return maps
          .map(
            (map) => Message(
              id: map['id'],
              content: map['content'],
              senderId: map['sender_id'],
              timestamp: DateTime.parse(map['timestamp']),
              isUser: map['is_user'] == 1,
            ),
          )
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print('加载聊天记录失败: $e');
      }
      return [];
    }
  }

  Future<bool> addMessage(Message message, int userId) async {
    try {
      final db = await database;
      await db.insert('messages', {
        'id': message.id,
        'user_id': userId,
        'content': message.content,
        'sender_id': message.senderId,
        'timestamp': message.timestamp.toIso8601String(),
        'is_user': message.isUser ? 1 : 0,
        'created_at': DateTime.now().toIso8601String(),
      });
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('添加消息失败: $e');
      }
      return false;
    }
  }

  Future<bool> clearChatHistory(int userId) async {
    try {
      final db = await database;
      await db.delete('messages', where: 'user_id = ?', whereArgs: [userId]);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('清空聊天记录失败: $e');
      }
      return false;
    }
  }

  Future<int> getMessageCount(int userId) async {
    try {
      final db = await database;
      final result = await db.rawQuery(
        'SELECT COUNT(*) as count FROM messages WHERE user_id = ?',
        [userId],
      );
      return Sqflite.firstIntValue(result) ?? 0;
    } catch (e) {
      if (kDebugMode) {
        print('获取消息数量失败: $e');
      }
      return 0;
    }
  }

  Future<String> getDatabasePath() async {
    final databasesPath = await getDatabasesPath();
    final dbDir = join(databasesPath, 'db');
    return join(dbDir, _databaseName);
  }

  Future<int> getDatabaseSize() async {
    try {
      final db = await database;
      return await db.getVersion();
    } catch (e) {
      if (kDebugMode) {
        print('获取数据库大小失败: $e');
      }
      return 0;
    }
  }

  Future<bool> backupChatHistory(int userId) async {
    try {
      final db = await database;
      final messages = await loadChatHistory(userId);
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final backupId = 'backup_$timestamp';
      final backupFileName = 'chat_backup_$timestamp.db';

      await db.insert('backups', {
        'id': backupId,
        'user_id': userId,
        'filename': backupFileName,
        'created_at': DateTime.now().toIso8601String(),
        'file_size': await getDatabaseSize(),
        'message_count': messages.length,
      });

      final databasesPath = await getDatabasesPath();
      final dbDir = join(databasesPath, 'db');
      final backupDir = join(dbDir, 'backups');

      final backupDirectory = Directory(backupDir);
      if (!await backupDirectory.exists()) {
        await backupDirectory.create(recursive: true);
      }

      final backupPath = join(backupDir, backupFileName);

      final backupData = await db.rawQuery(
        'SELECT * FROM messages WHERE user_id = ?',
        [userId],
      );

      if (kDebugMode) {
        print('备份数据到: $backupPath');
        print('备份消息数量: ${backupData.length}');
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('备份聊天记录失败: $e');
      }
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getBackups(int userId) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> backups = await db.query(
        'backups',
        where: 'user_id = ?',
        whereArgs: [userId],
        orderBy: 'created_at DESC',
      );
      return backups;
    } catch (e) {
      if (kDebugMode) {
        print('获取备份列表失败: $e');
      }
      return [];
    }
  }

  Future<bool> deleteBackup(String backupId, int userId) async {
    try {
      final db = await database;
      await db.delete(
        'backups',
        where: 'id = ? AND user_id = ?',
        whereArgs: [backupId, userId],
      );
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('删除备份失败: $e');
      }
      return false;
    }
  }

  Future<List<Message>> searchMessages(String keyword, int userId) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        'messages',
        where: 'content LIKE ? AND user_id = ?',
        whereArgs: ['%$keyword%', userId],
        orderBy: 'timestamp DESC',
      );

      return maps
          .map(
            (map) => Message(
              id: map['id'],
              content: map['content'],
              senderId: map['sender_id'],
              timestamp: DateTime.parse(map['timestamp']),
              isUser: map['is_user'] == 1,
            ),
          )
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print('搜索消息失败: $e');
      }
      return [];
    }
  }

  Future<Map<String, dynamic>> getChatStatistics(int userId) async {
    try {
      final db = await database;

      final totalResult = await db.rawQuery(
        'SELECT COUNT(*) as count FROM messages WHERE user_id = ?',
        [userId],
      );
      final totalMessages = Sqflite.firstIntValue(totalResult) ?? 0;

      final userResult = await db.rawQuery(
        'SELECT COUNT(*) as count FROM messages WHERE is_user = 1 AND user_id = ?',
        [userId],
      );
      final userMessages = Sqflite.firstIntValue(userResult) ?? 0;

      final agentResult = await db.rawQuery(
        'SELECT COUNT(*) as count FROM messages WHERE is_user = 0 AND user_id = ?',
        [userId],
      );
      final agentMessages = Sqflite.firstIntValue(agentResult) ?? 0;

      final firstResult = await db.rawQuery(
        'SELECT timestamp FROM messages WHERE user_id = ? ORDER BY timestamp ASC LIMIT 1',
        [userId],
      );
      DateTime? firstMessageTime;
      if (firstResult.isNotEmpty) {
        firstMessageTime = DateTime.parse(
          firstResult.first['timestamp'] as String,
        );
      }

      final lastResult = await db.rawQuery(
        'SELECT timestamp FROM messages WHERE user_id = ? ORDER BY timestamp DESC LIMIT 1',
        [userId],
      );
      DateTime? lastMessageTime;
      if (lastResult.isNotEmpty) {
        lastMessageTime = DateTime.parse(
          lastResult.first['timestamp'] as String,
        );
      }

      return {
        'totalMessages': totalMessages,
        'userMessages': userMessages,
        'agentMessages': agentMessages,
        'firstMessageTime': firstMessageTime?.toIso8601String(),
        'lastMessageTime': lastMessageTime?.toIso8601String(),
        'databaseSize': await getDatabaseSize(),
        'databasePath': await getDatabasePath(),
      };
    } catch (e) {
      if (kDebugMode) {
        print('获取聊天统计信息失败: $e');
      }
      return {};
    }
  }

  Future<List<Message>> getRecentMessages(int limit, int userId) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        'messages',
        where: 'user_id = ?',
        whereArgs: [userId],
        orderBy: 'timestamp DESC',
        limit: limit,
      );

      return maps
          .map(
            (map) => Message(
              id: map['id'] as String,
              content: map['content'] as String,
              senderId: map['sender_id'] as String,
              timestamp: DateTime.parse(map['timestamp'] as String),
              isUser: map['is_user'] == 1,
            ),
          )
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print('获取最近消息失败: $e');
      }
      return [];
    }
  }

  Future<bool> deleteOldMessages(int daysOld) async {
    try {
      final db = await database;
      final cutoffDate = DateTime.now().subtract(Duration(days: daysOld));
      final cutoffString = cutoffDate.toIso8601String();

      await db.delete(
        'messages',
        where: 'timestamp < ?',
        whereArgs: [cutoffString],
      );
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('删除旧消息失败: $e');
      }
      return false;
    }
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
