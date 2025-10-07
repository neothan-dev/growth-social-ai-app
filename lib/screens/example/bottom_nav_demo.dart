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
import '../../widgets/custom_bottom_navigation_bar.dart';
import '../../widgets/background_container.dart';
import '../../utils/asset_manager.dart';

class BottomNavDemo extends StatefulWidget {
  const BottomNavDemo({super.key});

  @override
  State<BottomNavDemo> createState() => _BottomNavDemoState();
}

class _BottomNavDemoState extends State<BottomNavDemo> {
  int _currentIndex = 0;
  int _navType = 0;

  final List<String> _navTypes = [
    '普通导航栏',
    '动画导航栏',
    '透明浮起导航栏',
    '缺口导航栏',
    '图片风格导航栏',
  ];

  final List<String> _pages = ['看板页面', '社区页面', '会话页面', '进步页面', '客服页面'];

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onNavTypeChanged(int type) {
    setState(() {
      _navType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        backgroundName: AppBackgrounds.dashboardBackground,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      '底部导航栏演示',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '当前页面: ${_pages[_currentIndex]}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '导航栏类型: ${_navTypes[_navType]}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _navTypes.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: ElevatedButton(
                              onPressed: () => _onNavTypeChanged(index),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _navType == index
                                    ? Colors.blue
                                    : Colors.white.withValues(alpha: 0.2),
                                foregroundColor: _navType == index
                                    ? Colors.white
                                    : Colors.white70,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                _navTypes[index],
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getPageIcon(_currentIndex),
                          size: 80,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _pages[_currentIndex],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '这是 ${_navTypes[_navType]} 的演示',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Text(
                                '导航栏特性',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              _buildFeatureItem('透明背景设计'),
                              _buildFeatureItem('浮起动画效果'),
                              _buildFeatureItem('缺口平滑过渡'),
                              _buildFeatureItem('点击跳转功能'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(Icons.check_circle, size: 16, color: Colors.green),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  IconData _getPageIcon(int index) {
    switch (index) {
      case 0:
        return Icons.dashboard;
      case 1:
        return Icons.groups;
      case 2:
        return Icons.chat;
      case 3:
        return Icons.trending_up;
      case 4:
        return Icons.support_agent;
      default:
        return Icons.circle;
    }
  }

  Widget _buildBottomNavigationBar() {
    switch (_navType) {
      case 0:
        return CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onNavTap,
          selectedColor: Colors.blue,
          unselectedColor: Colors.grey,
          backgroundColor: Colors.grey,
        );
      case 1:
        return AnimatedCustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onNavTap,
          selectedColor: Colors.blue,
          unselectedColor: Colors.grey,
          backgroundColor: Colors.grey,
        );
      case 2:
        return CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onNavTap,
          selectedColor: Colors.blue,
          unselectedColor: Colors.grey,
          backgroundColor: Colors.grey,
        );
      case 3:
        return CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onNavTap,
          selectedColor: Colors.blue,
          unselectedColor: Colors.grey,
          backgroundColor: Colors.grey,
        );
      case 4:
        return CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onNavTap,
          selectedColor: Colors.blue,
          unselectedColor: Colors.grey,
          backgroundColor: Colors.grey,
        );
      default:
        return CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onNavTap,
        );
    }
  }
}
