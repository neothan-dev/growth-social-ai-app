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
import '../../widgets/circular_image_button.dart';

class CircularButtonDemo extends StatefulWidget {
  const CircularButtonDemo({super.key});

  @override
  State<CircularButtonDemo> createState() => _CircularButtonDemoState();
}

class _CircularButtonDemoState extends State<CircularButtonDemo> {
  int _tapCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('圆形按钮演示'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[100]!, Colors.purple[100]!],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('基础圆形按钮'),
              const SizedBox(height: 20),
              _buildBasicButtons(),

              const SizedBox(height: 40),
              _buildSectionTitle('带边框的圆形按钮'),
              const SizedBox(height: 20),
              _buildBorderedButtons(),

              const SizedBox(height: 40),
              _buildSectionTitle('渐变边框圆形按钮'),
              const SizedBox(height: 20),
              _buildGradientButtons(),

              const SizedBox(height: 40),
              _buildSectionTitle('不同尺寸的按钮'),
              const SizedBox(height: 20),
              _buildDifferentSizes(),

              const SizedBox(height: 40),
              _buildSectionTitle('旋转按钮演示'),
              const SizedBox(height: 20),
              _buildRotatingButtons(),

              const SizedBox(height: 40),
              _buildSectionTitle('点击统计'),
              const SizedBox(height: 20),
              _buildTapCounter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildBasicButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircularImageButton(
          imagePath: AssetManager.getIconPath(AppIcons.chat),
          size: 80,
          onTap: () => _showSnackBar('点击了聊天按钮'),
          fallbackIcon: Icons.chat,
          fallbackIconColor: Colors.blue,
        ),
        CircularImageButton(
          imagePath: AssetManager.getIconPath(AppIcons.mic),
          size: 80,
          onTap: () => _showSnackBar('点击了麦克风按钮'),
          fallbackIcon: Icons.mic,
          fallbackIconColor: Colors.red,
        ),
        CircularImageButton(
          imagePath: AssetManager.getIconPath(AppIcons.send),
          size: 80,
          onTap: () => _showSnackBar('点击了发送按钮'),
          fallbackIcon: Icons.send,
          fallbackIconColor: Colors.green,
        ),
      ],
    );
  }

  Widget _buildBorderedButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BorderedCircularImageButton(
          imagePath: AssetManager.getIconPath(AppIcons.voice),
          size: 80,
          onTap: () => _showSnackBar('点击了语音按钮'),
          borderColor: Colors.blue,
          borderWidth: 3,
        ),
        BorderedCircularImageButton(
          imagePath: AssetManager.getIconPath(AppIcons.settings),
          size: 80,
          onTap: () => _showSnackBar('点击了设置按钮'),
          borderColor: Colors.orange,
          borderWidth: 3,
        ),
        BorderedCircularImageButton(
          imagePath: AssetManager.getIconPath(AppIcons.user),
          size: 80,
          onTap: () => _showSnackBar('点击了用户按钮'),
          borderColor: Colors.purple,
          borderWidth: 3,
        ),
      ],
    );
  }

  Widget _buildGradientButtons() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GradientCircularImageButton(
              imagePath: AssetManager.getIconPath(AppIcons.agent),
              size: 80,
              onTap: () => _showSnackBar('点击了代理按钮'),
              gradientColors: [Colors.blue, Colors.purple],
              gradientDirection: GradientDirection.radial,
            ),
            GradientCircularImageButton(
              imagePath: AssetManager.getIconPath(AppIcons.emotion),
              size: 80,
              onTap: () => _showSnackBar('点击了情感按钮'),
              gradientColors: [Colors.orange, Colors.red],
              gradientDirection: GradientDirection.linear,
            ),
            GradientCircularImageButton(
              imagePath: AssetManager.getIconPath(AppIcons.stats),
              size: 80,
              onTap: () => _showSnackBar('点击了统计按钮'),
              gradientColors: [Colors.green, Colors.teal],
              gradientDirection: GradientDirection.sweep,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GradientCircularImageButton(
              imagePath: AssetManager.getIconPath(AppIcons.backup),
              size: 80,
              onTap: () => _showSnackBar('点击了备份按钮'),
              gradientColors: [Colors.pink, Colors.purple, Colors.blue],
              gradientDirection: GradientDirection.linear,
            ),
            GradientCircularImageButton(
              imagePath: AssetManager.getIconPath(AppIcons.restore),
              size: 80,
              onTap: () => _showSnackBar('点击了恢复按钮'),
              gradientColors: [Colors.yellow, Colors.orange, Colors.red],
              gradientDirection: GradientDirection.radial,
            ),
            GradientCircularImageButton(
              imagePath: AssetManager.getIconPath(AppIcons.clear),
              size: 80,
              onTap: () => _showSnackBar('点击了清除按钮'),
              gradientColors: [Colors.grey, Colors.black],
              gradientDirection: GradientDirection.linear,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDifferentSizes() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircularImageButton(
              imagePath: AssetManager.getIconPath(AppIcons.dashboard),
              size: 60,
              onTap: () => _showSnackBar('小尺寸按钮'),
              fallbackIcon: Icons.dashboard,
              fallbackIconColor: Colors.blue,
            ),
            CircularImageButton(
              imagePath: AssetManager.getIconPath(AppIcons.society),
              size: 80,
              onTap: () => _showSnackBar('中等尺寸按钮'),
              fallbackIcon: Icons.people,
              fallbackIconColor: Colors.green,
            ),
            CircularImageButton(
              imagePath: AssetManager.getIconPath(AppIcons.chatNav),
              size: 100,
              onTap: () => _showSnackBar('大尺寸按钮'),
              fallbackIcon: Icons.chat,
              fallbackIconColor: Colors.orange,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Center(
          child: CircularImageButton(
            imagePath: AssetManager.getIconPath(AppIcons.improvement),
            size: 120,
            onTap: () => _showSnackBar('超大尺寸按钮'),
            fallbackIcon: Icons.trending_up,
            fallbackIconColor: Colors.purple,
            shadowColor: Colors.black.withValues(alpha: 0.3),
            shadowOffset: const Offset(0, 4),
            shadowBlurRadius: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildRotatingButtons() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircularImageButton(
              imagePath: AssetManager.getIconPath(AppIcons.chat),
              size: 80,
              onTap: () => _showSnackBar('点击了旋转聊天按钮'),
              fallbackIcon: Icons.chat,
              fallbackIconColor: Colors.blue,
              enableRotation: true,
              rotationSpeed: 120.0,
              stopRotationOnPress: true,
            ),
            CircularImageButton(
              imagePath: AssetManager.getIconPath(AppIcons.mic),
              size: 80,
              onTap: () => _showSnackBar('点击了旋转麦克风按钮'),
              fallbackIcon: Icons.mic,
              fallbackIconColor: Colors.red,
              enableRotation: true,
              rotationSpeed: 60.0,
              stopRotationOnPress: false,
            ),
            CircularImageButton(
              imagePath: AssetManager.getIconPath(AppIcons.send),
              size: 80,
              onTap: () => _showSnackBar('点击了旋转发送按钮'),
              fallbackIcon: Icons.send,
              fallbackIconColor: Colors.green,
              enableRotation: true,
              rotationSpeed: 180.0,
              stopRotationOnPress: true,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GradientCircularImageButton(
              imagePath: AssetManager.getIconPath(AppIcons.agent),
              size: 80,
              onTap: () => _showSnackBar('点击了旋转代理按钮'),
              gradientColors: [Colors.blue, Colors.purple],
              gradientDirection: GradientDirection.radial,
              enableRotation: true,
              rotationSpeed: 90.0,
              stopRotationOnPress: true,
            ),
            BorderedCircularImageButton(
              imagePath: AssetManager.getIconPath(AppIcons.voice),
              size: 80,
              onTap: () => _showSnackBar('点击了旋转语音按钮'),
              borderColor: Colors.orange,
              borderWidth: 3,
              enableRotation: true,
              rotationSpeed: 45.0,
              stopRotationOnPress: true,
            ),
            GradientCircularImageButton(
              imagePath: AssetManager.getIconPath(AppIcons.emotion),
              size: 80,
              onTap: () => _showSnackBar('点击了旋转情感按钮'),
              gradientColors: [Colors.pink, Colors.purple],
              gradientDirection: GradientDirection.linear,
              enableRotation: true,
              rotationSpeed: 30.0,
              stopRotationOnPress: false,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTapCounter() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            '点击次数: $_tapCount',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _tapCount = 0;
                  });
                  _showSnackBar('计数器已重置');
                },
                child: const Text('重置'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _tapCount++;
                  });
                },
                child: const Text('增加'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
