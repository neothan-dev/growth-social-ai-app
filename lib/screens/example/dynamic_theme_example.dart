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
import 'package:provider/provider.dart';
import '../../theme/page_theme_manager.dart';
import '../../widgets/custom_bottom_navigation_bar.dart';

class DynamicThemeExample extends StatefulWidget {
  const DynamicThemeExample({Key? key}) : super(key: key);

  @override
  State<DynamicThemeExample> createState() => _DynamicThemeExampleState();
}

class _DynamicThemeExampleState extends State<DynamicThemeExample> {
  int _currentIndex = 0;
  late PageThemeProvider _themeProvider;
  bool _useGlassmorphism = false;

  @override
  void initState() {
    super.initState();
    _themeProvider = PageThemeProvider();
  }

  @override
  void dispose() {
    _themeProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _themeProvider,
      child: Scaffold(
        body: Stack(
          children: [
            _buildCurrentPage(),
            _buildBottomNavigationBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return _buildDashboardPage();
      case 1:
        return _buildSocietyPage();
      case 2:
        return _buildChatPage();
      case 3:
        return _buildImprovementPage();
      case 4:
        return _buildAgentPage();
      default:
        return _buildDashboardPage();
    }
  }

  Widget _buildBottomNavigationBar() {
    return Consumer<PageThemeProvider>(
      builder: (context, themeProvider, child) {
        if (_useGlassmorphism) {
          return AnimatedGlassmorphismBottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
              themeProvider.switchPage(index);
            },
            useDynamicTheme: true,
            blurRadius: 20.0,
            opacity: 0.8,
          );
        } else {
          return AnimatedCustomBottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
              themeProvider.switchPage(index);
            },
            useDynamicTheme: true,
          );
        }
      },
    );
  }

  Widget _buildDashboardPage() {
    return Consumer<PageThemeProvider>(
      builder: (context, themeProvider, child) {
        final theme = themeProvider.currentTheme;

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: theme.gradientColors,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildPageHeader('健康看板', theme),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '当前主题颜色',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildColorInfo('主色调', theme.primaryColor),
                        _buildColorInfo('辅助色', theme.secondaryColor),
                        _buildColorInfo('背景色', theme.backgroundColor),
                        const SizedBox(height: 20),
                        Text(
                          '导航栏颜色',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildColorInfo('导航栏背景色', theme.backgroundColor),
                        _buildColorInfo(
                          '选中颜色',
                          theme.navigationBarSelectedColor,
                        ),
                        _buildColorInfo(
                          '未选中颜色',
                          theme.navigationBarUnselectedColor,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.backgroundColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: theme.primaryColor.withValues(alpha: 0.3),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: theme.primaryColor,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  '导航栏背景色与页面背景色保持一致',
                                  style: TextStyle(
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildNavigationBarToggle(theme),
                        const SizedBox(height: 20),
                        _buildNavigationBarPreview(theme),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSocietyPage() {
    return Consumer<PageThemeProvider>(
      builder: (context, themeProvider, child) {
        final theme = themeProvider.currentTheme;

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: theme.gradientColors,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildPageHeader('社区', theme),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.groups, size: 80, color: theme.primaryColor),
                        const SizedBox(height: 16),
                        Text(
                          '社区页面',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '橙色主题 - 社交互动',
                          style: TextStyle(
                            fontSize: 16,
                            color: theme.secondaryColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildNavigationBarPreview(theme),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildChatPage() {
    return Consumer<PageThemeProvider>(
      builder: (context, themeProvider, child) {
        final theme = themeProvider.currentTheme;

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: theme.gradientColors,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildPageHeader('会话', theme),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.chat, size: 80, color: theme.primaryColor),
                        const SizedBox(height: 16),
                        Text(
                          '会话页面',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '绿色主题 - 沟通交流',
                          style: TextStyle(
                            fontSize: 16,
                            color: theme.secondaryColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildNavigationBarPreview(theme),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImprovementPage() {
    return Consumer<PageThemeProvider>(
      builder: (context, themeProvider, child) {
        final theme = themeProvider.currentTheme;

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: theme.gradientColors,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildPageHeader('进步', theme),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.trending_up,
                          size: 80,
                          color: theme.primaryColor,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '进步页面',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '紫色主题 - 成长进步',
                          style: TextStyle(
                            fontSize: 16,
                            color: theme.secondaryColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildNavigationBarPreview(theme),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAgentPage() {
    return Consumer<PageThemeProvider>(
      builder: (context, themeProvider, child) {
        final theme = themeProvider.currentTheme;

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: theme.gradientColors,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildPageHeader('客服', theme),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.support_agent,
                          size: 80,
                          color: theme.primaryColor,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '客服页面',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '红色主题 - 客户服务',
                          style: TextStyle(
                            fontSize: 16,
                            color: theme.secondaryColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildNavigationBarPreview(theme),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPageHeader(String title, PageTheme theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(Icons.arrow_back, color: Colors.white, size: 24),
          const SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Icon(Icons.settings, color: Colors.white, size: 24),
        ],
      ),
    );
  }

  Widget _buildColorInfo(String label, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Text(
            '#${color.value.toRadixString(16).toUpperCase().substring(2)}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationBarToggle(PageTheme theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.primaryColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '导航栏类型',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _useGlassmorphism = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: !_useGlassmorphism
                          ? theme.primaryColor.withValues(alpha: 0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: !_useGlassmorphism
                            ? theme.primaryColor
                            : Colors.grey.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.navigation,
                          color: !_useGlassmorphism
                              ? theme.primaryColor
                              : Colors.grey,
                          size: 24,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '普通导航栏',
                          style: TextStyle(
                            fontSize: 12,
                            color: !_useGlassmorphism
                                ? theme.primaryColor
                                : Colors.grey,
                            fontWeight: !_useGlassmorphism
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _useGlassmorphism = true;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _useGlassmorphism
                          ? theme.primaryColor.withValues(alpha: 0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _useGlassmorphism
                            ? theme.primaryColor
                            : Colors.grey.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.blur_on,
                          color: _useGlassmorphism
                              ? theme.primaryColor
                              : Colors.grey,
                          size: 24,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '毛玻璃导航栏',
                          style: TextStyle(
                            fontSize: 12,
                            color: _useGlassmorphism
                                ? theme.primaryColor
                                : Colors.grey,
                            fontWeight: _useGlassmorphism
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationBarPreview(PageTheme theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.primaryColor.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '导航栏预览',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItemPreview('看板', Icons.dashboard, false, theme),
              _buildNavItemPreview('社区', Icons.groups, false, theme),
              _buildNavItemPreview('会话', Icons.chat, false, theme),
              _buildNavItemPreview('进步', Icons.trending_up, false, theme),
              _buildNavItemPreview('客服', Icons.support_agent, false, theme),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '背景色: #${theme.backgroundColor.value.toRadixString(16).toUpperCase().substring(2)}',
            style: TextStyle(
              fontSize: 12,
              color: theme.primaryColor,
              fontFamily: 'monospace',
            ),
          ),
          if (_useGlassmorphism) ...[
            const SizedBox(height: 4),
            Text(
              '毛玻璃效果: 模糊半径 20.0, 透明度 0.8',
              style: TextStyle(
                fontSize: 12,
                color: theme.primaryColor,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNavItemPreview(
    String label,
    IconData icon,
    bool isSelected,
    PageTheme theme,
  ) {
    final color = isSelected
        ? theme.navigationBarSelectedColor
        : theme.navigationBarUnselectedColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: color,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
