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

class AssetManager {
  static const String _iconPath = 'assets/images/icons';
  static const String _backgroundPath = 'assets/images/backgrounds';
  static const String _logoPath = 'assets/images/logos';
  static const String _uiPath = 'assets/images/ui';

  static const String _animationPath = 'assets/animations';

  static const String _audioPath = 'assets/audio';

  static String getIconPath(String iconName) {
    return '$_iconPath/$iconName';
  }

  static String getBackgroundPath(String bgName) {
    return '$_backgroundPath/$bgName';
  }

  static String getLogoPath(String logoName) {
    return '$_logoPath/$logoName';
  }

  static String getUIPath(String uiName) {
    return '$_uiPath/$uiName';
  }

  static String getAnimationPath(String animationName) {
    return '$_animationPath/$animationName';
  }

  static String getAudioPath(String audioName) {
    return '$_audioPath/$audioName';
  }

  static Future<void> precacheImages(BuildContext context) async {
    if (!context.mounted) return;

    await precacheImage(AssetImage(getIconPath('chat_icon.png')), context);

    if (!context.mounted) return;
    await precacheImage(AssetImage(getIconPath('mic_icon.png')), context);

    if (!context.mounted) return;
    await precacheImage(AssetImage(getIconPath('send_icon.png')), context);

    if (!context.mounted) return;
    await precacheImage(AssetImage(getBackgroundPath('chat_bg.jpg')), context);
  }
}

class AppIcons {
  static const String chat = 'chat_icon.png';
  static const String mic = 'mic_icon.png';
  static const String send = 'send_icon.png';
  static const String voice = 'voice_icon.png';
  static const String settings = 'settings_icon.png';
  static const String user = 'user_icon.png';
  static const String agent = 'agent_icon.png';
  static const String emotion = 'emotion_icon.png';
  static const String backup = 'backup_icon.png';
  static const String restore = 'restore_icon.png';
  static const String stats = 'stats_icon.png';
  static const String clear = 'clear_icon.png';
  static const String customVoice = 'custom_voice_icon.jpg';

  static const String dashboard = 'dashboard_icon.png';
  static const String society = 'society_icon.png';
  static const String chatNav = 'chat_nav_icon.png';
  static const String improvement = 'improvement_icon.png';
  static const String agentNav = 'agent_nav_icon.png';

  static const String dashboardActive = 'dashboard_active_icon.png';
  static const String societyActive = 'society_active_icon.png';
  static const String chatNavActive = 'chat_nav_active_icon.png';
  static const String improvementActive = 'improvement_active_icon.png';
  static const String agentNavActive = 'agent_nav_active_icon.png';
}

class AppBackgrounds {
  static const String friendChatBackground = 'friend_chat_bg.jpg';
  static const String chatBackground = 'chat_bg.jpg';
  static const String loginBackground = 'login_bg.jpg';
  static const String registerBackground = 'register_bg.jpg';
  static const String dashboardBackground = 'dashboard_bg.jpg';
  static const String societyBackground = 'society_bg.jpg';
  static const String improvementBackground = 'improvement_bg.jpg';
  static const String agentBackground = 'agent_bg.jpg';
  static const String gradientBackground = 'gradient_bg.jpg';
}

class AppLogos {
  static const String appLogo = 'app_logo.png';
  static const String appLogoWhite = 'app_logo_white.png';
  static const String appIcon = 'app_icon.png';
}

class AppUI {
  static const String buttonBg = 'button_bg.png';
  static const String cardBg = 'card_bg.png';
  static const String inputBg = 'input_bg.png';
  static const String avatarDefault = 'avatar_default.png';
  static const String loadingSpinner = 'loading_spinner.png';
}

class AppAnimations {
  static const String loading = 'loading.json';
  static const String success = 'success.json';
  static const String error = 'error.json';
  static const String voiceWave = 'voice_wave.json';
  static const String typing = 'typing.json';
}

class AppAudio {
  static const String notification = 'notification.mp3';
  static const String messageSent = 'message_sent.mp3';
  static const String voiceStart = 'voice_start.mp3';
  static const String voiceEnd = 'voice_end.mp3';
}
