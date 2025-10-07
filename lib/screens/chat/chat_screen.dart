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
import '../../widgets/background_container.dart';
import '../../utils/asset_manager.dart';
import '../../models/voice_style.dart';
import '../../services/voice_style_service.dart';
import '../../widgets/voice_style_dialog.dart';
import '../../widgets/circular_image_button.dart';
import 'voice_chat_screen.dart';
import '../../localization/app_localizations.dart';
import '../../utils/haptic_feedback_helper.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  VoiceStyle? _currentVoiceStyle;
  final VoiceStyleService _voiceStyleService = VoiceStyleService.instance;

  @override
  void initState() {
    super.initState();
    _loadCurrentVoiceStyle();
  }

  Future<void> _loadCurrentVoiceStyle() async {
    await _voiceStyleService.initialize();
    setState(() {
      _currentVoiceStyle = _voiceStyleService.currentVoiceStyle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        backgroundName: AppBackgrounds.chatBackground,
        overlayColor: Colors.black.withValues(alpha: 0.2),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "31dadd8980auKTsdatOE".tr,
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
                Text(
                  "544a3624878Q5D04AOSa".tr,
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
                const SizedBox(height: 60),
                GestureDetector(
                  onTap: () => _showVoiceStyleDialog(context),
                  child: _buildVoiceStyleButton(context),
                ),
                const SizedBox(height: 20),
                _buildVoiceChatButton(context),
                const SizedBox(height: 40),
                Text(
                  "0c900bc212R7cf9U9S9w".tr,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white60,
                    shadows: [
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 2,
                        color: Colors.black54,
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

  Widget _buildVoiceChatButton(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: GradientCircularImageButton(
            imagePath: AssetManager.getIconPath(AppIcons.customVoice),
            size: 120.0,
            onTap: () => _navigateToVoiceChat(context),
            gradientColors: [
              Colors.blue.withValues(alpha: 0.2),
              Colors.purple.withValues(alpha: 0.2),
            ],
            gradientDirection: GradientDirection.linear,
            borderWidth: 10.0,
            pressedScale: 0.5,
            enableRotation: true,
            rotationSpeed: 60.0,
            stopRotationOnPress: true,
          ),
        );
      },
    );
  }

  Widget _buildVoiceStyleButton(BuildContext context) {
    final voiceStyle = _currentVoiceStyle ?? VoiceStyle.getDefault();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            voiceStyle.name.contains("0ab4610b923p1560sxsV".tr)
                ? Icons.person
                : Icons.person_outline,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            voiceStyle.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_drop_down, color: Colors.white, size: 20),
        ],
      ),
    );
  }

  void _showVoiceStyleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const VoiceStyleDialog(),
    ).then((selectedVoiceStyle) {
      if (selectedVoiceStyle != null) {
        setState(() {
          _currentVoiceStyle = selectedVoiceStyle;
        });
      }
    });
  }

  void _navigateToVoiceChat(BuildContext context) {
    HapticFeedbackHelper.success();
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const VoiceChatScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var fadeTween = Tween(
            begin: 0.0,
            end: 1.0,
          ).chain(CurveTween(curve: Curves.easeInOut));
          var fadeAnimation = animation.drive(fadeTween);

          return FadeTransition(opacity: fadeAnimation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 400),
        reverseTransitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}
