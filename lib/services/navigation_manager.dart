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

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'network_service.dart';

class NavigationManager {
  static final NavigationManager _instance = NavigationManager._internal();
  factory NavigationManager() => _instance;
  NavigationManager._internal();

  static NavigationManager get instance => _instance;

  Future<void> handleVoiceNavigation(
    Map<String, dynamic> navigationData,
    BuildContext context,
  ) async {
    print('=== 开始处理AI语音导航 ===');
    print('导航数据: $navigationData');

    try {
      final result = NavigationResult.fromJson(navigationData);
      print('解析后的导航结果: $result');

      if (result.confidence < 0.5) {
        print('导航置信度过低: ${result.confidence}');
        return;
      }

      handleNavigationResult(result, context);
    } catch (e) {
      print('处理导航数据失败: $e');
    }
    print('=== AI语音导航处理完成 ===');
  }

  void handleNavigationResult(NavigationResult result, BuildContext context) {
    print('=== 开始处理导航结果 ===');
    print('导航类型: ${result.type}');
    print('目标页面: ${result.name}');
    print('路由: ${result.route}');
    print('Screen类: ${result.screenClass}');
    print('置信度: ${result.confidence}');

    _showNavigationMessage(result.message, context);

    if (result.isPageNavigation && result.route != null) {
      print('检测到页面导航意图');
      // 根据route进行导航
      print('使用route导航: ${result.route}');
      _navigateToScreen(result.route!, context);
      print('导航到页面: ${result.route} (${result.route})');
    } else if (result.isAction) {
      print('检测到动作意图: ${result.action}');
      _executeAction(result.action!, result.parameters, context);
      print('执行动作: ${result.action}');
    } else if (result.isAction) {
      print('检测到动作意图: ${result.action}');
      _executeAction(result.action!, result.parameters, context);
      print('执行动作: ${result.action}');
    } else {
      print('NavigationResult不是有效的导航意图: $result');
    }
    print('=== 导航处理完成 ===');
  }

  void _showNavigationMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(seconds: 2)),
    );
  }

  void _navigateToScreen(String route, BuildContext context) {
    print('=== 开始页面导航 ===');
    print('目标路由: $route');
    Navigator.pushNamed(context, route);
    print('=== 导航处理完成 ===');
  }

  void _executeAction(
    String action,
    Map<String, dynamic>? parameters,
    BuildContext context,
  ) {
    switch (action) {
      case 'back':
        Navigator.pop(context);
        print('返回上一页');
        break;
      case 'home':
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/dashboard_screen',
          (route) => false,
        );
        break;
      case 'search':
        final query = parameters?['query'] ?? '';
        print('执行搜索: $query');
        break;
      case 'share':
        final content = parameters?['content'] ?? '';
        print('分享内容: $content');
        break;
      case 'exit':
        SystemNavigator.pop();
        break;
      case 'help':
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('帮助'),
            content: Text('这是帮助信息'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('确定'),
              ),
            ],
          ),
        );
        break;
      default:
        print('未知动作: $action');
        break;
    }
  }

  Future<List<PageInfo>> getAvailablePages() async {
    try {
      final response = await HTTPManager.get('/navigation/pages');
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => PageInfo.fromJson(json)).toList();
      }
    } catch (e) {
      print('获取页面列表失败: $e');
    }
    return [];
  }

  Future<NavigationResult> detectNavigationIntent(
    String text, {
    String lang = 'zh',
  }) async {
    try {
      final response = await HTTPManager.post(
        '/navigation/detect',
        body: json.encode({'text': text, 'lang': lang}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return NavigationResult.fromJson(data);
      }
    } catch (e) {
      print('检测导航意图失败: $e');
    }

    return NavigationResult.none();
  }
}

class NavigationResult {
  final String type;
  final String? action;
  final int? target;
  final String? route;
  final String? name;
  final String? screenClass;
  final double confidence;
  final String message;
  final Map<String, dynamic>? parameters;

  NavigationResult({
    required this.type,
    this.action,
    this.target,
    this.route,
    this.name,
    this.screenClass,
    required this.confidence,
    required this.message,
    this.parameters,
  });

  factory NavigationResult.fromJson(Map<String, dynamic> json) {
    return NavigationResult(
      type: json['type'] ?? 'none',
      action: json['action'],
      target: json['target']?.toInt(),
      route: json['route'],
      name: json['name'],
      screenClass: json['screen_class'],
      confidence: (json['confidence'] ?? 0.0).toDouble(),
      message: json['message'] ?? '',
      parameters: json['parameters'] != null
          ? Map<String, dynamic>.from(json['parameters'])
          : null,
    );
  }

  factory NavigationResult.none() {
    return NavigationResult(type: 'none', confidence: 0.0, message: '未识别到导航意图');
  }

  bool get isPageNavigation => type == 'page_navigation';
  bool get isAction => type == 'action';
  bool get isNone => type == 'none';
  bool get isError => type == 'error';

  @override
  String toString() {
    return 'NavigationResult(type: $type, action: $action, route: $route, confidence: $confidence, message: $message)';
  }
}

class PageInfo {
  final String id;
  final String name;
  final String route;
  final String screenClass;
  final String description;
  final String icon;
  final String category;

  PageInfo({
    required this.id,
    required this.name,
    required this.route,
    required this.screenClass,
    required this.description,
    required this.icon,
    required this.category,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) {
    return PageInfo(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      route: json['route'] ?? '',
      screenClass: json['screen_class'] ?? '',
      description: json['description'] ?? '',
      icon: json['icon'] ?? '',
      category: json['category'] ?? '',
    );
  }

  @override
  String toString() {
    return 'PageInfo(id: $id, name: $name, route: $route, screenClass: $screenClass)';
  }
}
