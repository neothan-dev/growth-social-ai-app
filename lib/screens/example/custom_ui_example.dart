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
import '../../widgets/animation_widget.dart';
import '../../widgets/audio_player_widget.dart';

class CustomUIExample extends StatefulWidget {
  const CustomUIExample({super.key});

  @override
  State<CustomUIExample> createState() => _CustomUIExampleState();
}

class _CustomUIExampleState extends State<CustomUIExample> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AssetManager.precacheImages(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('自定义 UI 素材示例')),
      body: BackgroundContainer(
        backgroundName: AppBackgrounds.chatBackground,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '图标按钮示例',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomIconButton(
                    iconName: AppIcons.chat,
                    onPressed: () => _showMessage('聊天图标'),
                  ),
                  CustomIconButton(
                    iconName: AppIcons.mic,
                    onPressed: () => _showMessage('麦克风图标'),
                    backgroundColor: Colors.red,
                  ),
                  CustomIconButton(
                    iconName: AppIcons.send,
                    onPressed: () => _showMessage('发送图标'),
                    backgroundColor: Colors.green,
                  ),
                ],
              ),
              const SizedBox(height: 32),

              const Text(
                '动画示例',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const LoadingAnimation(size: 80),
                  const SuccessAnimation(size: 80),
                  const ErrorAnimation(size: 80),
                ],
              ),
              const SizedBox(height: 32),

              const Text(
                '音频播放示例',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const NotificationSound(),
                  const MessageSentSound(),
                  AudioPlayerWidget(
                    audioName: AppAudio.voiceStart,
                    size: 40,
                    backgroundColor: Colors.orange,
                  ),
                ],
              ),
              const SizedBox(height: 32),

              const Text(
                '渐变背景示例',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              GradientBackgroundContainer(
                colors: const [Colors.blue, Colors.purple],
                child: Container(
                  height: 100,
                  padding: const EdgeInsets.all(16),
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
              const SizedBox(height: 32),

              const Text(
                '语音波形动画',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const VoiceWaveAnimation(isActive: true),
                  const VoiceWaveAnimation(isActive: false),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
