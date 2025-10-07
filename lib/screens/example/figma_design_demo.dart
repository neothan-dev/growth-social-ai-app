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
import '../../theme/app_theme.dart';
import '../../widgets/design_system/figma_button.dart';

class FigmaDesignDemo extends StatefulWidget {
  const FigmaDesignDemo({super.key});

  @override
  State<FigmaDesignDemo> createState() => _FigmaDesignDemoState();
}

class _FigmaDesignDemoState extends State<FigmaDesignDemo> {
  int _currentSection = 0;

  final List<Map<String, dynamic>> _sections = [
    {'title': '颜色系统', 'icon': Icons.palette, 'color': AppTheme.primary},
    {'title': '字体系统', 'icon': Icons.text_fields, 'color': AppTheme.secondary},
    {'title': '按钮组件', 'icon': Icons.touch_app, 'color': AppTheme.success},
    {'title': '间距系统', 'icon': Icons.space_bar, 'color': AppTheme.warning},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Figma 设计系统演示'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMd),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _sections.length,
              itemBuilder: (context, index) {
                final section = _sections[index];
                final isSelected = _currentSection == index;

                return GestureDetector(
                  onTap: () => setState(() => _currentSection = index),
                  child: Container(
                    margin: const EdgeInsets.only(right: AppTheme.spacingSm),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingMd,
                      vertical: AppTheme.spacingSm,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? section['color'] : Colors.transparent,
                      borderRadius: AppTheme.borderRadiusMd,
                      border: Border.all(
                        color: isSelected ? section['color'] : AppTheme.divider,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          section['icon'],
                          color: isSelected ? Colors.white : section['color'],
                          size: 16,
                        ),
                        const SizedBox(width: AppTheme.spacingSm),
                        Text(
                          section['title'],
                          style: TextStyle(
                            color: isSelected ? Colors.white : section['color'],
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Expanded(child: _buildSectionContent()),
        ],
      ),
    );
  }

  Widget _buildSectionContent() {
    switch (_currentSection) {
      case 0:
        return _buildColorSystem();
      case 1:
        return _buildTypographySystem();
      case 2:
        return _buildButtonSystem();
      case 3:
        return _buildSpacingSystem();
      default:
        return const SizedBox();
    }
  }

  Widget _buildColorSystem() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('颜色系统', style: AppTheme.h2),
          const SizedBox(height: AppTheme.spacingLg),

          _buildColorSection('主色调', [
            {'name': 'Primary', 'color': AppTheme.primary},
            {'name': 'Primary Light', 'color': AppTheme.primaryLight},
            {'name': 'Primary Dark', 'color': AppTheme.primaryDark},
          ]),

          const SizedBox(height: AppTheme.spacingLg),

          _buildColorSection('辅助色', [
            {'name': 'Secondary', 'color': AppTheme.secondary},
            {'name': 'Secondary Light', 'color': AppTheme.secondaryLight},
            {'name': 'Secondary Dark', 'color': AppTheme.secondaryDark},
          ]),

          const SizedBox(height: AppTheme.spacingLg),

          _buildColorSection('功能色', [
            {'name': 'Success', 'color': AppTheme.success},
            {'name': 'Warning', 'color': AppTheme.warning},
            {'name': 'Error', 'color': AppTheme.error},
            {'name': 'Info', 'color': AppTheme.info},
          ]),

          const SizedBox(height: AppTheme.spacingLg),

          _buildColorSection('中性色', [
            {'name': 'Background', 'color': AppTheme.background},
            {'name': 'Surface', 'color': AppTheme.surface},
            {'name': 'Text Primary', 'color': AppTheme.textPrimary},
            {'name': 'Text Secondary', 'color': AppTheme.textSecondary},
          ]),
        ],
      ),
    );
  }

  Widget _buildColorSection(String title, List<Map<String, dynamic>> colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTheme.h4),
        const SizedBox(height: AppTheme.spacingMd),
        Wrap(
          spacing: AppTheme.spacingMd,
          runSpacing: AppTheme.spacingMd,
          children: colors.map((colorInfo) {
            return Container(
              width: 120,
              height: 80,
              decoration: BoxDecoration(
                color: colorInfo['color'],
                borderRadius: AppTheme.borderRadiusMd,
                boxShadow: AppTheme.shadowSm,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    colorInfo['name'],
                    style: TextStyle(
                      color: _getContrastColor(colorInfo['color']),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '#${colorInfo['color'].value.toRadixString(16).substring(2)}',
                    style: TextStyle(
                      color: _getContrastColor(colorInfo['color']),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Color _getContrastColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  Widget _buildTypographySystem() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('字体系统', style: AppTheme.h2),
          const SizedBox(height: AppTheme.spacingLg),

          _buildTypographySection('标题字体', [
            {'name': 'H1', 'style': AppTheme.h1, 'text': '标题一级'},
            {'name': 'H2', 'style': AppTheme.h2, 'text': '标题二级'},
            {'name': 'H3', 'style': AppTheme.h3, 'text': '标题三级'},
            {'name': 'H4', 'style': AppTheme.h4, 'text': '标题四级'},
          ]),

          const SizedBox(height: AppTheme.spacingLg),

          _buildTypographySection('正文字体', [
            {'name': 'Body Large', 'style': AppTheme.bodyLarge, 'text': '正文大号'},
            {
              'name': 'Body Medium',
              'style': AppTheme.bodyMedium,
              'text': '正文中号',
            },
            {'name': 'Body Small', 'style': AppTheme.bodySmall, 'text': '正文小号'},
            {'name': 'Caption', 'style': AppTheme.caption, 'text': '说明文字'},
          ]),

          const SizedBox(height: AppTheme.spacingLg),

          _buildTypographySection('按钮字体', [
            {
              'name': 'Button Large',
              'style': AppTheme.buttonLarge,
              'text': '按钮大号',
            },
            {
              'name': 'Button Medium',
              'style': AppTheme.buttonMedium,
              'text': '按钮中号',
            },
            {
              'name': 'Button Small',
              'style': AppTheme.buttonSmall,
              'text': '按钮小号',
            },
          ]),
        ],
      ),
    );
  }

  Widget _buildTypographySection(
    String title,
    List<Map<String, dynamic>> styles,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTheme.h4),
        const SizedBox(height: AppTheme.spacingMd),
        ...styles.map((styleInfo) {
          return Container(
            margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: AppTheme.borderRadiusMd,
              boxShadow: AppTheme.shadowXs,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(styleInfo['name'], style: AppTheme.bodySmall),
                const SizedBox(height: AppTheme.spacingXs),
                Text(styleInfo['text'], style: styleInfo['style']),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildButtonSystem() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('按钮组件', style: AppTheme.h2),
          const SizedBox(height: AppTheme.spacingLg),

          _buildButtonSection('按钮类型', [
            {
              'name': '主要按钮',
              'button': FigmaButtons.primary(text: '主要按钮', onPressed: () {}),
            },
            {
              'name': '次要按钮',
              'button': FigmaButtons.secondary(text: '次要按钮', onPressed: () {}),
            },
            {
              'name': '轮廓按钮',
              'button': FigmaButtons.outline(text: '轮廓按钮', onPressed: () {}),
            },
            {
              'name': '文本按钮',
              'button': FigmaButtons.text(text: '文本按钮', onPressed: () {}),
            },
          ]),

          const SizedBox(height: AppTheme.spacingLg),

          _buildButtonSection('按钮尺寸', [
            {
              'name': '小尺寸',
              'button': FigmaButtons.primary(
                text: '小按钮',
                onPressed: () {},
                size: FigmaButtonSize.small,
              ),
            },
            {
              'name': '中尺寸',
              'button': FigmaButtons.primary(
                text: '中按钮',
                onPressed: () {},
                size: FigmaButtonSize.medium,
              ),
            },
            {
              'name': '大尺寸',
              'button': FigmaButtons.primary(
                text: '大按钮',
                onPressed: () {},
                size: FigmaButtonSize.large,
              ),
            },
          ]),

          const SizedBox(height: AppTheme.spacingLg),

          _buildButtonSection('按钮状态', [
            {
              'name': '正常状态',
              'button': FigmaButtons.primary(text: '正常按钮', onPressed: () {}),
            },
            {
              'name': '加载状态',
              'button': FigmaButtons.primary(
                text: '加载按钮',
                onPressed: () {},
                isLoading: true,
              ),
            },
            {
              'name': '禁用状态',
              'button': FigmaButtons.primary(text: '禁用按钮', onPressed: null),
            },
          ]),

          const SizedBox(height: AppTheme.spacingLg),

          _buildButtonSection('带图标的按钮', [
            {
              'name': '带图标',
              'button': FigmaButtons.primary(
                text: '发送',
                onPressed: () {},
                icon: Icons.send,
              ),
            },
            {
              'name': '带图标',
              'button': FigmaButtons.secondary(
                text: '下载',
                onPressed: () {},
                icon: Icons.download,
              ),
            },
            {
              'name': '带图标',
              'button': FigmaButtons.outline(
                text: '分享',
                onPressed: () {},
                icon: Icons.share,
              ),
            },
          ]),

          const SizedBox(height: AppTheme.spacingLg),

          _buildButtonSection('全宽按钮', [
            {
              'name': '全宽按钮',
              'button': FigmaButtons.primary(
                text: '全宽按钮',
                onPressed: () {},
                fullWidth: true,
              ),
            },
          ]),
        ],
      ),
    );
  }

  Widget _buildButtonSection(String title, List<Map<String, dynamic>> buttons) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTheme.h4),
        const SizedBox(height: AppTheme.spacingMd),
        ...buttons.map((buttonInfo) {
          return Container(
            margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(buttonInfo['name'], style: AppTheme.bodySmall),
                const SizedBox(height: AppTheme.spacingXs),
                buttonInfo['button'],
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildSpacingSystem() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('间距系统', style: AppTheme.h2),
          const SizedBox(height: AppTheme.spacingLg),

          _buildSpacingSection('基础间距', [
            {'name': 'XS (4px)', 'size': AppTheme.spacingXs},
            {'name': 'SM (8px)', 'size': AppTheme.spacingSm},
            {'name': 'MD (16px)', 'size': AppTheme.spacingMd},
            {'name': 'LG (24px)', 'size': AppTheme.spacingLg},
            {'name': 'XL (32px)', 'size': AppTheme.spacingXl},
            {'name': 'XXL (48px)', 'size': AppTheme.spacingXxl},
          ]),

          const SizedBox(height: AppTheme.spacingLg),

          _buildSpacingSection('边距示例', [
            {'name': 'XS 边距', 'padding': AppTheme.paddingXs},
            {'name': 'SM 边距', 'padding': AppTheme.paddingSm},
            {'name': 'MD 边距', 'padding': AppTheme.paddingMd},
            {'name': 'LG 边距', 'padding': AppTheme.paddingLg},
          ]),

          const SizedBox(height: AppTheme.spacingLg),

          _buildSpacingSection('水平边距', [
            {'name': 'SM 水平边距', 'padding': AppTheme.paddingHorizontalSm},
            {'name': 'MD 水平边距', 'padding': AppTheme.paddingHorizontalMd},
            {'name': 'LG 水平边距', 'padding': AppTheme.paddingHorizontalLg},
          ]),

          const SizedBox(height: AppTheme.spacingLg),

          _buildSpacingSection('垂直边距', [
            {'name': 'SM 垂直边距', 'padding': AppTheme.paddingVerticalSm},
            {'name': 'MD 垂直边距', 'padding': AppTheme.paddingVerticalMd},
            {'name': 'LG 垂直边距', 'padding': AppTheme.paddingVerticalLg},
          ]),
        ],
      ),
    );
  }

  Widget _buildSpacingSection(
    String title,
    List<Map<String, dynamic>> spacings,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTheme.h4),
        const SizedBox(height: AppTheme.spacingMd),
        ...spacings.map((spacingInfo) {
          return Container(
            margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(spacingInfo['name'], style: AppTheme.bodySmall),
                const SizedBox(height: AppTheme.spacingXs),
                Container(
                  padding:
                      spacingInfo['padding'] ??
                      EdgeInsets.all(spacingInfo['size']),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryWithOpacity(0.1),
                    borderRadius: AppTheme.borderRadiusSm,
                    border: Border.all(color: AppTheme.primary),
                  ),
                  child: Text('示例内容', style: AppTheme.bodyMedium),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
