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

import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';

class DatabaseManager {
  static const String _dbDirName = 'db';
  static const String _backupDirName = 'backups';

  static Future<String> getDatabaseDirectory() async {
    final databasesPath = await getDatabasesPath();
    return join(databasesPath, _dbDirName);
  }

  static Future<String> getBackupDirectory() async {
    final dbDir = await getDatabaseDirectory();
    return join(dbDir, _backupDirName);
  }

  static Future<List<FileSystemEntity>> listDatabaseFiles() async {
    try {
      final dbDir = await getDatabaseDirectory();
      final directory = Directory(dbDir);

      if (!await directory.exists()) {
        return [];
      }

      return await directory.list().toList();
    } catch (e) {
      if (kDebugMode) {
        print('列出数据库文件失败: $e');
      }
      return [];
    }
  }

  static Future<List<FileSystemEntity>> listBackupFiles() async {
    try {
      final backupDir = await getBackupDirectory();
      final directory = Directory(backupDir);

      if (!await directory.exists()) {
        return [];
      }

      return await directory.list().toList();
    } catch (e) {
      if (kDebugMode) {
        print('列出备份文件失败: $e');
      }
      return [];
    }
  }

  static Future<Map<String, dynamic>> getDatabaseInfo() async {
    try {
      final dbDir = await getDatabaseDirectory();
      final backupDir = await getBackupDirectory();

      final dbDirectory = Directory(dbDir);
      final backupDirectory = Directory(backupDir);

      final dbExists = await dbDirectory.exists();
      final backupExists = await backupDirectory.exists();

      int dbFileCount = 0;
      int backupFileCount = 0;
      int totalSize = 0;

      if (dbExists) {
        final dbFiles = await dbDirectory.list().toList();
        dbFileCount = dbFiles.length;

        for (final file in dbFiles) {
          if (file is File) {
            totalSize += await file.length();
          }
        }
      }

      if (backupExists) {
        final backupFiles = await backupDirectory.list().toList();
        backupFileCount = backupFiles.length;

        for (final file in backupFiles) {
          if (file is File) {
            totalSize += await file.length();
          }
        }
      }

      return {
        'databaseDirectory': dbDir,
        'backupDirectory': backupDir,
        'databaseExists': dbExists,
        'backupExists': backupExists,
        'databaseFileCount': dbFileCount,
        'backupFileCount': backupFileCount,
        'totalSize': totalSize,
        'totalSizeKB': (totalSize / 1024).toStringAsFixed(2),
      };
    } catch (e) {
      if (kDebugMode) {
        print('获取数据库信息失败: $e');
      }
      return {};
    }
  }

  static Future<bool> cleanupOldBackups(int daysOld) async {
    try {
      final backupDir = await getBackupDirectory();
      final directory = Directory(backupDir);

      if (!await directory.exists()) {
        return true;
      }

      final files = await directory.list().toList();
      final cutoffTime = DateTime.now().subtract(Duration(days: daysOld));
      int deletedCount = 0;

      for (final file in files) {
        if (file is File) {
          final stat = await file.stat();
          if (stat.modified.isBefore(cutoffTime)) {
            await file.delete();
            deletedCount++;
          }
        }
      }

      if (kDebugMode) {
        print('清理了 $deletedCount 个旧备份文件');
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('清理旧备份文件失败: $e');
      }
      return false;
    }
  }

  static Future<String> exportDatabaseInfo() async {
    try {
      final info = await getDatabaseInfo();
      final dbFiles = await listDatabaseFiles();
      final backupFiles = await listBackupFiles();

      String report = '=== 数据库信息报告 ===\n';
      report += '数据库目录: ${info['databaseDirectory']}\n';
      report += '备份目录: ${info['backupDirectory']}\n';
      report += '数据库文件数量: ${info['databaseFileCount']}\n';
      report += '备份文件数量: ${info['backupFileCount']}\n';
      report += '总大小: ${info['totalSizeKB']} KB\n\n';

      report += '=== 数据库文件 ===\n';
      for (final file in dbFiles) {
        if (file is File) {
          final stat = await file.stat();
          report +=
              '${file.path} (${(stat.size / 1024).toStringAsFixed(2)} KB)\n';
        }
      }

      report += '\n=== 备份文件 ===\n';
      for (final file in backupFiles) {
        if (file is File) {
          final stat = await file.stat();
          report +=
              '${file.path} (${(stat.size / 1024).toStringAsFixed(2)} KB)\n';
        }
      }

      return report;
    } catch (e) {
      if (kDebugMode) {
        print('导出数据库信息失败: $e');
      }
      return '导出失败: $e';
    }
  }
}
