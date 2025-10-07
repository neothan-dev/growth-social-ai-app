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
import '../../widgets/background_container.dart';
import '../../utils/asset_manager.dart';

class BackgroundDemo extends StatefulWidget {
  const BackgroundDemo({super.key});

  @override
  State<BackgroundDemo> createState() => _BackgroundDemoState();
}

class _BackgroundDemoState extends State<BackgroundDemo> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'title': '健康看板',
      'background': AppBackgrounds.dashboardBackground,
      'icon': Icons.dashboard,
      'description': '展示健康数据和卡片',
    },
    {
      'title': '社区',
      'background': AppBackgrounds.societyBackground,
      'icon': Icons.groups,
      'description': '健身视频、跑步等社区功能',
    },
    {
      'title': '会话',
      'background': AppBackgrounds.chatBackground,
      'icon': Icons.chat,
      'description': '与AI助手对话',
    },
    {
      'title': '进步分析',
      'background': AppBackgrounds.improvementBackground,
      'icon': Icons.trending_up,
      'description': '健康数据进步分析',
    },
    {
      'title': '人工客服',
      'background': AppBackgrounds.agentBackground,
      'icon': Icons.support_agent,
      'description': '人工客服对话',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('面板背景演示'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () => _showInfo(),
          ),
        ],
      ),
      body: BackgroundContainer(
        backgroundName: _pages[_currentIndex]['background'],
        overlayColor: Colors.black.withValues(alpha: 0.3),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _pages[_currentIndex]['icon'],
                      size: 100,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      _pages[_currentIndex]['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _pages[_currentIndex]['description'],
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            '背景特性',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildFeatureItem('🎨 自定义背景图片'),
                          _buildFeatureItem('🌫️ 半透明遮罩层'),
                          _buildFeatureItem('📱 响应式适配'),
                          _buildFeatureItem('⚡ 高性能渲染'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _currentIndex > 0
                        ? () => setState(() => _currentIndex--)
                        : null,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('上一个'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _currentIndex < _pages.length - 1
                        ? () => setState(() => _currentIndex++)
                        : null,
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('下一个'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }

  void _showInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('背景系统说明'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• 每个面板都有独特的背景图片'),
            Text('• 背景图片存储在 assets/images/backgrounds/'),
            Text('• 支持半透明遮罩层调整对比度'),
            Text('• 自动适配不同屏幕尺寸'),
            Text('• 支持渐变和纯色背景'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}
