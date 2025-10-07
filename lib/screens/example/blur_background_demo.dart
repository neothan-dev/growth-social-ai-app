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
import '../../localization/app_localizations.dart';

class BlurBackgroundDemo extends StatefulWidget {
  const BlurBackgroundDemo({super.key});

  @override
  State<BlurBackgroundDemo> createState() => _BlurBackgroundDemoState();
}

class _BlurBackgroundDemoState extends State<BlurBackgroundDemo> {
  BlurStyle _currentBlurStyle = BlurStyle.normal;
  double _blurSigma = 10.0;
  double _glassOpacity = 0.2;
  bool _showOverlay = true;
  Color _overlayColor = Colors.black.withValues(alpha: 0.3);

  final List<Map<String, dynamic>> _demoPages = [
    {
      'title': '标准模糊效果',
      'background': AppBackgrounds.dashboardBackground,
      'description': '类似iPhone壁纸的标准模糊效果',
    },
    {
      'title': '毛玻璃效果',
      'background': AppBackgrounds.chatBackground,
      'description': 'iOS风格的毛玻璃背景效果',
    },
    {
      'title': '重度模糊',
      'background': AppBackgrounds.agentBackground,
      'description': '高强度的背景模糊效果',
    },
  ];

  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('模糊背景效果演示'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: _buildDemoContent(),
    );
  }

  Widget _buildDemoContent() {
    final currentPage = _demoPages[_currentPageIndex];

    return GlassmorphismBackgroundContainer(
      backgroundName: currentPage['background'],
      blurSigma: _blurSigma,
      glassOpacity: _glassOpacity,
      overlayColor: _showOverlay ? _overlayColor : null,
      child: Column(
        children: [
          _buildPageIndicator(),

          Expanded(child: _buildMainContent(currentPage)),

          _buildControlPanel(),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          _demoPages.length,
          (index) => GestureDetector(
            onTap: () => setState(() => _currentPageIndex = index),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPageIndex == index
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.5),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(Map<String, dynamic> currentPage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currentPage['title'],
              style: const TextStyle(
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
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            Text(
              currentPage['description'],
              style: const TextStyle(
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
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            _buildEffectCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildEffectCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          const Icon(Icons.blur_on, size: 48, color: Colors.white),
          const SizedBox(height: 16),
          Text(
            '当前模糊强度: ${_blurSigma.toStringAsFixed(1)}',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '毛玻璃透明度: ${(_glassOpacity * 100).toStringAsFixed(0)}%',
            style: const TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildControlPanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.3),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildBlurStyleSelector(),
          const SizedBox(height: 16),

          _buildBlurSigmaSlider(),
          const SizedBox(height: 16),

          _buildGlassOpacitySlider(),
          const SizedBox(height: 16),

          _buildOverlayControls(),
        ],
      ),
    );
  }

  Widget _buildBlurStyleSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '模糊样式',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: BlurStyle.values.map((style) {
            final isSelected = _currentBlurStyle == style;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentBlurStyle = style;
                  _blurSigma = BlurConfig.getSigma(style);
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.3)
                      : Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  _getBlurStyleName(style),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBlurSigmaSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '模糊强度',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              _blurSigma.toStringAsFixed(1),
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
        Slider(
          value: _blurSigma,
          min: 1.0,
          max: 30.0,
          divisions: 29,
          activeColor: Colors.white,
          inactiveColor: Colors.white.withValues(alpha: 0.3),
          onChanged: (value) {
            setState(() {
              _blurSigma = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildGlassOpacitySlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '毛玻璃透明度',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${(_glassOpacity * 100).toStringAsFixed(0)}%',
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
        Slider(
          value: _glassOpacity,
          min: 0.0,
          max: 0.5,
          divisions: 50,
          activeColor: Colors.white,
          inactiveColor: Colors.white.withValues(alpha: 0.3),
          onChanged: (value) {
            setState(() {
              _glassOpacity = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildOverlayControls() {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Checkbox(
                value: _showOverlay,
                onChanged: (value) {
                  setState(() {
                    _showOverlay = value ?? false;
                  });
                },
                activeColor: Colors.white,
                checkColor: Colors.black,
              ),
              const Text(
                '显示遮罩层',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ),
        if (_showOverlay)
          Expanded(
            child: Row(
              children: [
                const Text(
                  '透明度:',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Slider(
                    value: _overlayColor.opacity,
                    min: 0.0,
                    max: 0.8,
                    divisions: 16,
                    activeColor: Colors.white,
                    inactiveColor: Colors.white.withValues(alpha: 0.3),
                    onChanged: (value) {
                      setState(() {
                        _overlayColor = Colors.black.withValues(alpha: value);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  String _getBlurStyleName(BlurStyle style) {
    switch (style) {
      case BlurStyle.light:
        return '轻微';
      case BlurStyle.normal:
        return '标准';
      case BlurStyle.heavy:
        return '重度';
      case BlurStyle.ultra:
        return '超重';
    }
  }
}
