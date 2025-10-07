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
import '../../widgets/figma_components.dart';
import '../../theme/app_theme.dart';

class FigmaComponentsExample extends StatelessWidget {
  const FigmaComponentsExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Figma组件示例'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle('按钮组件'),
          _buildButtonExamples(),

          FigmaSpacingLg(),

          _buildSectionTitle('输入框组件'),
          _buildInputExamples(),

          FigmaSpacingLg(),

          _buildSectionTitle('卡片组件'),
          _buildCardExamples(),

          FigmaSpacingLg(),

          _buildSectionTitle('头像组件'),
          _buildAvatarExamples(),

          FigmaSpacingLg(),

          _buildSectionTitle('标签组件'),
          _buildTagExamples(),

          FigmaSpacingLg(),

          _buildSectionTitle('进度条组件'),
          _buildProgressBarExamples(),

          FigmaSpacingLg(),

          _buildSectionTitle('图标按钮组件'),
          _buildIconButtonExamples(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: AppTheme.h3.copyWith(
          color: AppTheme.textPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildButtonExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FigmaButton(
          text: '主要按钮',
          onPressed: () => _showSnackBar('点击了主要按钮'),
          type: ButtonType.primary,
        ),
        FigmaSpacingMd(),
        FigmaButton(
          text: '次要按钮',
          onPressed: () => _showSnackBar('点击了次要按钮'),
          type: ButtonType.secondary,
        ),
        FigmaSpacingMd(),
        FigmaButton(
          text: '轮廓按钮',
          onPressed: () => _showSnackBar('点击了轮廓按钮'),
          type: ButtonType.outline,
        ),
      ],
    );
  }

  Widget _buildInputExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FigmaInput(hintText: '请输入用户名', prefixIcon: const Icon(Icons.person)),
        FigmaSpacingMd(),
        FigmaInput(
          hintText: '请输入密码',
          obscureText: true,
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: const Icon(Icons.visibility),
        ),
        FigmaSpacingMd(),
        FigmaInput(
          hintText: '请输入邮箱',
          keyboardType: TextInputType.emailAddress,
          prefixIcon: const Icon(Icons.email),
        ),
      ],
    );
  }

  Widget _buildCardExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FigmaCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '健康数据卡片',
                style: AppTheme.h4.copyWith(fontWeight: FontWeight.bold),
              ),
              FigmaSpacingMd(),
              Text('这是一个使用FigmaCard组件创建的卡片示例。', style: AppTheme.bodyMedium),
              FigmaSpacingMd(),
              Row(
                children: [
                  FigmaTag(text: '健康'),
                  FigmaSpacingSm(isHorizontal: true),
                  FigmaTag(text: '数据', backgroundColor: AppTheme.secondary),
                ],
              ),
            ],
          ),
        ),
        FigmaSpacingMd(),
        FigmaCard(
          backgroundColor: AppTheme.primary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '彩色卡片',
                style: AppTheme.h4.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FigmaSpacingMd(),
              Text(
                '这是一个带有自定义背景色的卡片。',
                style: AppTheme.bodyMedium.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarExamples() {
    return Row(
      children: [
        FigmaAvatar(name: '张三', size: 60),
        FigmaSpacingMd(isHorizontal: true),
        FigmaAvatar(name: '李四', size: 50, backgroundColor: AppTheme.secondary),
        FigmaSpacingMd(isHorizontal: true),
        FigmaAvatar(name: '王五', size: 40, backgroundColor: AppTheme.success),
      ],
    );
  }

  Widget _buildTagExamples() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        FigmaTag(text: '健康'),
        FigmaTag(text: '运动', backgroundColor: AppTheme.secondary),
        FigmaTag(text: '成功', backgroundColor: AppTheme.success),
        FigmaTag(
          text: '警告',
          backgroundColor: AppTheme.warning,
          textColor: AppTheme.textPrimary,
        ),
        FigmaTag(text: '错误', backgroundColor: AppTheme.error),
      ],
    );
  }

  Widget _buildProgressBarExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('进度: 75%', style: AppTheme.bodyMedium),
        FigmaSpacingSm(),
        FigmaProgressBar(progress: 0.75, height: 8),
        FigmaSpacingMd(),
        Text('进度: 30%', style: AppTheme.bodyMedium),
        FigmaSpacingSm(),
        FigmaProgressBar(
          progress: 0.30,
          height: 12,
          progressColor: AppTheme.secondary,
        ),
        FigmaSpacingMd(),
        Text('进度: 90%', style: AppTheme.bodyMedium),
        FigmaSpacingSm(),
        FigmaProgressBar(
          progress: 0.90,
          height: 6,
          progressColor: AppTheme.success,
        ),
      ],
    );
  }

  Widget _buildIconButtonExamples() {
    return Row(
      children: [
        FigmaIconButton(
          icon: Icons.favorite,
          onPressed: () => _showSnackBar('点击了喜欢按钮'),
          backgroundColor: AppTheme.primary,
          iconColor: Colors.white,
        ),
        FigmaSpacingMd(isHorizontal: true),
        FigmaIconButton(
          icon: Icons.share,
          onPressed: () => _showSnackBar('点击了分享按钮'),
          backgroundColor: AppTheme.secondary,
          iconColor: Colors.white,
        ),
        FigmaSpacingMd(isHorizontal: true),
        FigmaIconButton(
          icon: Icons.settings,
          onPressed: () => _showSnackBar('点击了设置按钮'),
        ),
        FigmaSpacingMd(isHorizontal: true),
        FigmaIconButton(
          icon: Icons.delete,
          onPressed: () => _showSnackBar('点击了删除按钮'),
          backgroundColor: AppTheme.error,
          iconColor: Colors.white,
        ),
      ],
    );
  }

  void _showSnackBar(String message) {
    print('SnackBar: $message');
  }
}

class FigmaDashboardExample extends StatelessWidget {
  const FigmaDashboardExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Figma Dashboard示例'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        leading: FigmaAvatar(name: '用户', size: 40),
        actions: [
          FigmaIconButton(
            icon: Icons.settings,
            onPressed: () {},
            backgroundColor: Colors.transparent,
            iconColor: Colors.white,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Row(
            children: [
              Expanded(
                child: FigmaCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.directions_walk, color: AppTheme.primary),
                          FigmaSpacingSm(isHorizontal: true),
                          Text('今日步数', style: AppTheme.bodyMedium),
                        ],
                      ),
                      FigmaSpacingMd(),
                      Text(
                        '8,432',
                        style: AppTheme.h2.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      FigmaSpacingSm(),
                      FigmaProgressBar(progress: 0.84),
                    ],
                  ),
                ),
              ),
              FigmaSpacingMd(isHorizontal: true),
              Expanded(
                child: FigmaCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.bedtime, color: AppTheme.secondary),
                          FigmaSpacingSm(isHorizontal: true),
                          Text('睡眠时长', style: AppTheme.bodyMedium),
                        ],
                      ),
                      FigmaSpacingMd(),
                      Text(
                        '7.5h',
                        style: AppTheme.h2.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      FigmaSpacingSm(),
                      FigmaTag(text: '良好'),
                    ],
                  ),
                ),
              ),
            ],
          ),

          FigmaSpacingLg(),

          FigmaCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '身体指标',
                  style: AppTheme.h4.copyWith(fontWeight: FontWeight.bold),
                ),
                FigmaSpacingMd(),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '65',
                            style: AppTheme.h3.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('kg', style: AppTheme.bodySmall),
                        ],
                      ),
                    ),
                    Container(width: 1, height: 40, color: AppTheme.divider),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '170',
                            style: AppTheme.h3.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('cm', style: AppTheme.bodySmall),
                        ],
                      ),
                    ),
                  ],
                ),
                FigmaSpacingMd(),
                FigmaTag(text: 'BMI: 22.5'),
              ],
            ),
          ),

          FigmaSpacingLg(),

          Row(
            children: [
              Expanded(
                child: FigmaButton(
                  text: '查看详情',
                  onPressed: () {},
                  type: ButtonType.primary,
                ),
              ),
              FigmaSpacingMd(isHorizontal: true),
              Expanded(
                child: FigmaButton(
                  text: '分享数据',
                  onPressed: () {},
                  type: ButtonType.outline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
