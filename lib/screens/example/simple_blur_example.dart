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
import '../../widgets/blur_background_container.dart';
import '../../utils/asset_manager.dart';

class SimpleBlurExample extends StatelessWidget {
  const SimpleBlurExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('模糊背景示例'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return GlassmorphismBackgroundContainer(
      backgroundName: AppBackgrounds.dashboardBackground,
      blurSigma: 10.0,
      glassOpacity: 0.2,
      overlayColor: Colors.black.withValues(alpha: 0.3),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '模糊背景效果',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(2, 2),
                      blurRadius: 4,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                '这是一个简单的模糊背景效果示例，展示了如何使用毛玻璃效果来创建现代化的UI界面。',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 2,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              Expanded(
                child: ListView(
                  children: [
                    _buildFeatureCard(
                      icon: Icons.blur_on,
                      title: '基础模糊效果',
                      description: '使用 BlurBackgroundContainer 创建简单的模糊背景',
                      onTap: () => _showCodeExample('基础模糊效果'),
                    ),

                    const SizedBox(height: 16),

                    _buildFeatureCard(
                      icon: Icons.blur_circular,
                      title: '毛玻璃效果',
                      description:
                          '使用 GlassmorphismBackgroundContainer 创建iOS风格的毛玻璃效果',
                      onTap: () => _showCodeExample('毛玻璃效果'),
                    ),

                    const SizedBox(height: 16),

                    _buildFeatureCard(
                      icon: Icons.tune,
                      title: '高级模糊效果',
                      description:
                          '使用 AdvancedBlurBackgroundContainer 创建自定义模糊效果',
                      onTap: () => _showCodeExample('高级模糊效果'),
                    ),

                    const SizedBox(height: 16),

                    _buildFeatureCard(
                      icon: Icons.settings,
                      title: '自定义配置',
                      description: '调整模糊强度、透明度和遮罩层颜色',
                      onTap: () => _showCodeExample('自定义配置'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
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
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    description,
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white70,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _showCodeExample(String type) {
    String code = '';
    String title = '';

    switch (type) {
      case '基础模糊效果':
        title = '基础模糊效果代码示例';
        code = '''
BlurBackgroundContainer(
  backgroundName: AppBackgrounds.dashboardBackground,
  blurSigma: 10.0,
  overlayColor: Colors.black.withValues(alpha: 0.3),
  child: YourContent(),
)
''';
        break;

      case '毛玻璃效果':
        title = '毛玻璃效果代码示例';
        code = '''
GlassmorphismBackgroundContainer(
  backgroundName: AppBackgrounds.chatBackground,
  blurSigma: 15.0,
  glassOpacity: 0.2,
  overlayColor: Colors.black.withValues(alpha: 0.3),
  child: YourContent(),
)
''';
        break;

      case '高级模糊效果':
        title = '高级模糊效果代码示例';
        code = '''
AdvancedBlurBackgroundContainer(
  backgroundName: AppBackgrounds.agentBackground,
  blurStyle: BlurStyle.heavy,
  blurTintColor: Colors.white,
  blurTintOpacity: 0.1,
  child: YourContent(),
)
''';
        break;

      case '自定义配置':
        title = '自定义配置代码示例';
        code = '''
GlassmorphismBackgroundContainer(
  backgroundName: AppBackgrounds.dashboardBackground,
  blurSigma: 12.0,
  glassOpacity: 0.25,
  glassColor: Colors.white,
  borderRadius: BorderRadius.circular(16),
  overlayColor: Colors.black.withValues(alpha: 0.2),
  child: YourContent(),
)
''';
        break;
    }

    print('$title:\n$code');
  }
}
