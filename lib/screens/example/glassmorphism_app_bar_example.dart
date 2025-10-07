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
import '../../widgets/glassmorphism_app_bar.dart';

class GlassmorphismAppBarExample extends StatefulWidget {
  const GlassmorphismAppBarExample({Key? key}) : super(key: key);

  @override
  State<GlassmorphismAppBarExample> createState() =>
      _GlassmorphismAppBarExampleState();
}

class _GlassmorphismAppBarExampleState
    extends State<GlassmorphismAppBarExample> {
  bool _useAnimated = true;
  double _blurRadius = 20.0;
  double _opacity = 0.8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          _buildPageContent(),
          _buildGlassmorphismAppBar(),
        ],
      ),
    );
  }

  Widget _buildPageContent() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue, Colors.purple, Colors.pink, Colors.orange],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 100),
              _buildControlPanel(),
              const SizedBox(height: 20),
              _buildFeatureCards(),
              const SizedBox(height: 20),
              _buildInfoSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGlassmorphismAppBar() {
    if (_useAnimated) {
      return AnimatedGlassmorphismAppBar(
        leading: _buildAvatarButton(),
        title: _buildTitle(),
        actions: [_buildSettingsButton()],
        backgroundColor: Colors.white.withValues(alpha: 0.1),
        blurRadius: _blurRadius,
        opacity: _opacity,
      );
    } else {
      return GlassmorphismAppBar(
        leading: _buildAvatarButton(),
        title: _buildTitle(),
        actions: [_buildSettingsButton()],
        backgroundColor: Colors.white.withValues(alpha: 0.1),
        blurRadius: _blurRadius,
        opacity: _opacity,
      );
    }
  }

  Widget _buildAvatarButton() {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('点击了头像')));
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white.withValues(alpha: 0.2),
          child: const Icon(Icons.person, size: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      children: [
        const Icon(Icons.blur_on, color: Colors.white, size: 24),
        const SizedBox(width: 8),
        const Text(
          '毛玻璃App Bar',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsButton() {
    return IconButton(
      onPressed: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('点击了设置')));
      },
      icon: const Icon(Icons.settings, color: Colors.white, size: 24),
    );
  }

  Widget _buildControlPanel() {
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
          const Text(
            '控制面板',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                '使用动画效果',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const Spacer(),
              Switch(
                value: _useAnimated,
                onChanged: (value) {
                  setState(() {
                    _useAnimated = value;
                  });
                },
                activeColor: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '模糊半径: ${_blurRadius.toStringAsFixed(1)}',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Slider(
            value: _blurRadius,
            min: 5.0,
            max: 50.0,
            divisions: 45,
            onChanged: (value) {
              setState(() {
                _blurRadius = value;
              });
            },
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          Text(
            '透明度: ${_opacity.toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Slider(
            value: _opacity,
            min: 0.1,
            max: 1.0,
            divisions: 90,
            onChanged: (value) {
              setState(() {
                _opacity = value;
              });
            },
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCards() {
    return Column(
      children: [
        _buildFeatureCard('毛玻璃效果', '使用BackdropFilter实现真正的毛玻璃效果', Icons.blur_on),
        const SizedBox(height: 16),
        _buildFeatureCard('背景延伸', '页面背景可以延伸到App Bar上方', Icons.extension),
        const SizedBox(height: 16),
        _buildFeatureCard('透明度渐变', '上面透明度低，下面透明度高，形成过渡效果', Icons.opacity),
        const SizedBox(height: 16),
        _buildFeatureCard('动画效果', '平滑的淡入动画和透明度变化', Icons.animation),
      ],
    );
  }

  Widget _buildFeatureCard(String title, String description, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
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
                    fontSize: 16,
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
    );
  }

  Widget _buildInfoSection() {
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
          const Text(
            '技术特性',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoItem('背景模糊', '使用BackdropFilter实现'),
          _buildInfoItem('透明度渐变', '从透明到半透明的渐变过渡'),
          _buildInfoItem('背景延伸', '页面背景延伸到App Bar上方'),
          _buildInfoItem('动画支持', '可选的淡入动画效果'),
          _buildInfoItem('高度自适应', '自动适配不同设备的安全区域'),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.white,
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
                  style: const TextStyle(
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
