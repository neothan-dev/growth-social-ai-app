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
import 'dart:ui';
import 'package:provider/provider.dart';
import '../../theme/page_theme_manager.dart';
import '../../widgets/custom_bottom_navigation_bar.dart';

class GlassmorphismNavigationExample extends StatefulWidget {
  const GlassmorphismNavigationExample({Key? key}) : super(key: key);

  @override
  State<GlassmorphismNavigationExample> createState() =>
      _GlassmorphismNavigationExampleState();
}

class _GlassmorphismNavigationExampleState
    extends State<GlassmorphismNavigationExample> {
  int _currentIndex = 0;
  late PageThemeProvider _themeProvider;

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
            _buildGlassmorphismNavigationBar(),
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

  Widget _buildGlassmorphismNavigationBar() {
    return Consumer<PageThemeProvider>(
      builder: (context, themeProvider, child) {
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
              colors: [
                theme.primaryColor,
                theme.secondaryColor,
                theme.backgroundColor,
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildPageHeader('健康看板', theme),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildGlassmorphismCard(
                          '毛玻璃效果',
                          '类似Apple Music的毛玻璃导航栏效果',
                          Icons.blur_on,
                          theme,
                        ),
                        const SizedBox(height: 16),
                        _buildGlassmorphismCard(
                          '背景延伸',
                          '页面背景可以延伸到导航栏下方',
                          Icons.extension,
                          theme,
                        ),
                        const SizedBox(height: 16),
                        _buildGlassmorphismCard(
                          '透明度渐变',
                          '越向上透明度越高，形成过渡效果',
                          Icons.opacity,
                          theme,
                        ),
                        const SizedBox(height: 16),
                        _buildFeatureList(theme),
                        const SizedBox(height: 100),
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
              colors: [
                theme.primaryColor,
                theme.secondaryColor,
                theme.backgroundColor,
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildPageHeader('社区', theme),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildGlassmorphismCard(
                          '社区互动',
                          '与其他用户分享健康心得',
                          Icons.groups,
                          theme,
                        ),
                        const SizedBox(height: 16),
                        _buildGlassmorphismCard(
                          '动态分享',
                          '分享你的健康进步历程',
                          Icons.share,
                          theme,
                        ),
                        const SizedBox(height: 16),
                        _buildGlassmorphismCard(
                          '话题讨论',
                          '参与健康话题的讨论',
                          Icons.forum,
                          theme,
                        ),
                        const SizedBox(height: 100),
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
              colors: [
                theme.primaryColor,
                theme.secondaryColor,
                theme.backgroundColor,
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildPageHeader('会话', theme),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildGlassmorphismCard(
                          'AI助手',
                          '与智能健康助手对话',
                          Icons.smart_toy,
                          theme,
                        ),
                        const SizedBox(height: 16),
                        _buildGlassmorphismCard(
                          '语音聊天',
                          '支持语音输入和输出',
                          Icons.mic,
                          theme,
                        ),
                        const SizedBox(height: 16),
                        _buildGlassmorphismCard(
                          '健康咨询',
                          '获取专业的健康建议',
                          Icons.medical_services,
                          theme,
                        ),
                        const SizedBox(height: 100),
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
              colors: [
                theme.primaryColor,
                theme.secondaryColor,
                theme.backgroundColor,
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildPageHeader('进步', theme),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildGlassmorphismCard(
                          '目标设定',
                          '设定个性化的健康目标',
                          Icons.flag,
                          theme,
                        ),
                        const SizedBox(height: 16),
                        _buildGlassmorphismCard(
                          '进度追踪',
                          '实时追踪健康进步情况',
                          Icons.trending_up,
                          theme,
                        ),
                        const SizedBox(height: 16),
                        _buildGlassmorphismCard(
                          '成就系统',
                          '获得健康成就徽章',
                          Icons.emoji_events,
                          theme,
                        ),
                        const SizedBox(height: 100),
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
              colors: [
                theme.primaryColor,
                theme.secondaryColor,
                theme.backgroundColor,
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildPageHeader('客服', theme),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildGlassmorphismCard(
                          '在线客服',
                          '24小时在线客服支持',
                          Icons.support_agent,
                          theme,
                        ),
                        const SizedBox(height: 16),
                        _buildGlassmorphismCard(
                          '问题反馈',
                          '快速反馈使用问题',
                          Icons.feedback,
                          theme,
                        ),
                        const SizedBox(height: 16),
                        _buildGlassmorphismCard(
                          '使用帮助',
                          '详细的使用指南',
                          Icons.help,
                          theme,
                        ),
                        const SizedBox(height: 100),
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

  Widget _buildGlassmorphismCard(
    String title,
    String description,
    IconData icon,
    PageTheme theme,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureList(PageTheme theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '毛玻璃导航栏特性',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          _buildFeatureItem('背景模糊效果', '使用BackdropFilter实现毛玻璃效果', theme),
          _buildFeatureItem('透明度渐变', '从透明到半透明的渐变过渡', theme),
          _buildFeatureItem('背景延伸', '页面背景延伸到导航栏下方', theme),
          _buildFeatureItem('动态主题', '根据页面主题自动调整颜色', theme),
          _buildFeatureItem('动画效果', '平滑的切换动画和缩放效果', theme),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String title, String description, PageTheme theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
