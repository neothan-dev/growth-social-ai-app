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
import '../../utils/asset_manager.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/background_container.dart';

class MaterialDemo extends StatelessWidget {
  const MaterialDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UI 素材演示')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '图标按钮演示',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomIconButton(
                  iconName: AppIcons.chat,
                  onPressed: () => _showSnackBar(context, '聊天图标'),
                ),
                CustomIconButton(
                  iconName: AppIcons.mic,
                  onPressed: () => _showSnackBar(context, '麦克风图标'),
                  backgroundColor: Colors.red,
                ),
                CustomIconButton(
                  iconName: AppIcons.send,
                  onPressed: () => _showSnackBar(context, '发送图标'),
                  backgroundColor: Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 32),

            const Text(
              '背景容器演示',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackgroundContainer(
                  backgroundName: AppBackgrounds.chatBackground,
                  overlayColor: Colors.black.withValues(alpha: 0.3),
                  child: const Center(
                    child: Text(
                      '背景容器示例',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            const Text(
              '渐变背景演示',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: GradientBackgroundContainer(
                  colors: const [Colors.blue, Colors.purple],
                  child: const Center(
                    child: Text(
                      '渐变背景容器',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            const Text(
              '素材路径演示',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('图标路径: ${AssetManager.getIconPath(AppIcons.chat)}'),
                  Text(
                    '背景路径: ${AssetManager.getBackgroundPath(AppBackgrounds.chatBackground)}',
                  ),
                  Text(
                    '动画路径: ${AssetManager.getAnimationPath(AppAnimations.loading)}',
                  ),
                  Text(
                    '音频路径: ${AssetManager.getAudioPath(AppAudio.notification)}',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
