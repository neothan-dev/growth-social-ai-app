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

import '../localization/app_localizations.dart';

class VoiceStyle {
  final String id;
  final String name;
  final String description;
  final String azureVoice;
  final String openaiVoice;
  final String iconPath;
  final bool isDefault;
  final Map<String, String>? multilingualVoices;
  final List<String>? supportedLanguages;

  const VoiceStyle({
    required this.id,
    required this.name,
    required this.description,
    required this.azureVoice,
    required this.openaiVoice,
    required this.iconPath,
    this.isDefault = false,
    this.multilingualVoices,
    this.supportedLanguages,
  });

  static List<VoiceStyle> availableVoices = [
    VoiceStyle(
      id: 'xiaoxiao',
      name: "67b26f7f5e9A2LpR6p5Q".tr,
      description: "92107d6540QEB51K1kfN".tr,
      azureVoice: 'zh-CN-XiaoxiaoNeural',
      openaiVoice: 'alloy',
      iconPath: 'assets/images/icons/voice_female_1.png',
      isDefault: true,
      multilingualVoices: {
        'zh': 'zh-CN-XiaoxiaoNeural',
        'en': 'en-US-JennyNeural',
        'ja': 'ja-JP-NanamiNeural',
        'ko': 'ko-KR-SunHiNeural',
        'fr': 'fr-FR-DeniseNeural',
        'de': 'de-DE-KatjaNeural',
        'es': 'es-ES-ElviraNeural',
        'ru': 'ru-RU-SvetlanaNeural',
        'ar': 'ar-SA-ZariyahNeural',
        'hi': 'hi-IN-SwaraNeural',
      },
      supportedLanguages: [
        'zh',
        'en',
        'ja',
        'ko',
        'fr',
        'de',
        'es',
        'ru',
        'ar',
        'hi',
      ],
    ),
    VoiceStyle(
      id: 'yunxi',
      name: "b3fa84e97bDsmJCJcAa4".tr,
      description: "30ee7c0e4dxP0xQNtv0j".tr,
      azureVoice: 'zh-CN-YunxiNeural',
      openaiVoice: 'alloy',
      iconPath: 'assets/images/icons/voice_male_1.png',
      multilingualVoices: {
        'zh': 'zh-CN-YunxiNeural',
        'en': 'en-US-GuyNeural',
        'ja': 'ja-JP-KeitaNeural',
        'ko': 'ko-KR-InJoonNeural',
        'fr': 'fr-FR-HenriNeural',
        'de': 'de-DE-ConradNeural',
        'es': 'es-ES-AlvaroNeural',
        'ru': 'ru-RU-DmitryNeural',
        'ar': 'ar-SA-HamedNeural',
        'hi': 'hi-IN-MadhurNeural',
      },
      supportedLanguages: [
        'zh',
        'en',
        'ja',
        'ko',
        'fr',
        'de',
        'es',
        'ru',
        'ar',
        'hi',
      ],
    ),
    VoiceStyle(
      id: 'yunyang',
      name: "f07c35ae9bhsQLFRb9Cy".tr,
      description: "2b5dd169faYSiWhK5nTr".tr,
      azureVoice: 'zh-CN-YunyangNeural',
      openaiVoice: 'alloy',
      iconPath: 'assets/images/icons/voice_male_2.png',
      multilingualVoices: {
        'zh': 'zh-CN-YunyangNeural',
        'en': 'en-US-AriaNeural',
        'ja': 'ja-JP-NaokiNeural',
        'ko': 'ko-KR-YuJinNeural',
        'fr': 'fr-FR-AlainNeural',
        'de': 'de-DE-AmalaNeural',
        'es': 'es-ES-LaiaNeural',
        'ru': 'ru-RU-DariyaNeural',
        'ar': 'ar-SA-SalimNeural',
        'hi': 'hi-IN-AarohiNeural',
      },
      supportedLanguages: [
        'zh',
        'en',
        'ja',
        'ko',
        'fr',
        'de',
        'es',
        'ru',
        'ar',
        'hi',
      ],
    ),
    VoiceStyle(
      id: 'xiaoyi',
      name: "c203dbe9aetl9yH7yyer".tr,
      description: "607622eb98oPDDRd3pmM".tr,
      azureVoice: 'zh-CN-XiaoyiNeural',
      openaiVoice: 'alloy',
      iconPath: 'assets/images/icons/voice_female_2.png',
      multilingualVoices: {
        'zh': 'zh-CN-XiaoyiNeural',
        'en': 'en-US-JennyNeural',
        'ja': 'ja-JP-NanamiNeural',
        'ko': 'ko-KR-SunHiNeural',
        'fr': 'fr-FR-DeniseNeural',
        'de': 'de-DE-KatjaNeural',
        'es': 'es-ES-ElviraNeural',
        'ru': 'ru-RU-SvetlanaNeural',
        'ar': 'ar-SA-ZariyahNeural',
        'hi': 'hi-IN-SwaraNeural',
      },
      supportedLanguages: [
        'zh',
        'en',
        'ja',
        'ko',
        'fr',
        'de',
        'es',
        'ru',
        'ar',
        'hi',
      ],
    ),
    VoiceStyle(
      id: 'yunfeng',
      name: "96c9cece0e9bt0BqUROP".tr,
      description: "941d46a77dFQ3AjgCw84".tr,
      azureVoice: 'zh-CN-YunfengNeural',
      openaiVoice: 'alloy',
      iconPath: 'assets/images/icons/voice_male_3.png',
      multilingualVoices: {
        'zh': 'zh-CN-YunfengNeural',
        'en': 'en-US-GuyNeural',
        'ja': 'ja-JP-KeitaNeural',
        'ko': 'ko-KR-InJoonNeural',
        'fr': 'fr-FR-HenriNeural',
        'de': 'de-DE-ConradNeural',
        'es': 'es-ES-AlvaroNeural',
        'ru': 'ru-RU-DmitryNeural',
        'ar': 'ar-SA-HamedNeural',
        'hi': 'hi-IN-MadhurNeural',
      },
      supportedLanguages: [
        'zh',
        'en',
        'ja',
        'ko',
        'fr',
        'de',
        'es',
        'ru',
        'ar',
        'hi',
      ],
    ),
  ];

  static VoiceStyle? getById(String id) {
    try {
      return availableVoices.firstWhere((voice) => voice.id == id);
    } catch (e) {
      return null;
    }
  }

  static VoiceStyle getDefault() {
    return availableVoices.firstWhere((voice) => voice.isDefault);
  }

  String getVoiceForLanguage(String language) {
    if (multilingualVoices != null &&
        multilingualVoices!.containsKey(language)) {
      return multilingualVoices![language]!;
    }
    return azureVoice;
  }

  bool supportsLanguage(String language) {
    if (supportedLanguages != null) {
      return supportedLanguages!.contains(language);
    }
    return true;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'azureVoice': azureVoice,
      'openaiVoice': openaiVoice,
      'iconPath': iconPath,
      'isDefault': isDefault,
      'multilingualVoices': multilingualVoices,
      'supportedLanguages': supportedLanguages,
    };
  }

  factory VoiceStyle.fromJson(Map<String, dynamic> json) {
    return VoiceStyle(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      azureVoice: json['azureVoice'],
      openaiVoice: json['openaiVoice'],
      iconPath: json['iconPath'],
      isDefault: json['isDefault'] ?? false,
      multilingualVoices: json['multilingualVoices'] != null
          ? Map<String, String>.from(json['multilingualVoices'])
          : null,
      supportedLanguages: json['supportedLanguages'] != null
          ? List<String>.from(json['supportedLanguages'])
          : null,
    );
  }
}
