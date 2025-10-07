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

import 'dart:convert';
import 'dart:io';
import '../config/network_config.dart';
import 'network_service.dart';
import 'voice_style_service.dart';
import '../localization/app_localizations.dart';

class SpeechService {
  Future<String> speechToText(String base64Audio) async {
    try {
      final response = await HTTPManager.post(
        '${NetworkConfig.baseUrl}/speech/stt',
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'audio': base64Audio}),
        requireAuth: true,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['text'] ?? '';
      } else if (response.statusCode == 401) {
        return "48144f96c1R8VOb9ehv0".tr;
      } else {
        return "1af7fdf8b8Wn0tCFWmrS".tr;
      }
    } on SocketException catch (_) {
      return "42545546d3vkD9wxGLiQ".tr;
    } catch (e) {
      return "ebbaa5eb76OA4m50KFi3".tr;
    }
  }

  static Future<String> textToSpeech({
    required String text,
    String? emotion,
    String? voiceStyle,
    String? language,
  }) async {
    try {
      final body = {'text': text};

      if (language != null) {
        body['lang'] = language;
      }

      if (emotion != null) {
        body['emotion'] = emotion;
      }

      if (voiceStyle != null) {
        body['voice_style'] = voiceStyle;
      }

      final response = await HTTPManager.post(
        '${NetworkConfig.baseUrl}/speech/tts',
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
        requireAuth: true,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['audio'] ?? '';
      } else if (response.statusCode == 401) {
        return "48144f96c1uNrEWnNeVG".tr;
      } else {
        return "d3cafdda3atdNZTuOs1b".tr;
      }
    } on SocketException catch (_) {
      return "42545546d3z1eUfR7UT9".tr;
    } catch (e) {
      return "ebbaa5eb763mypsHhFSh".tr;
    }
  }

  static Future<String> smartTextToSpeech({
    required String text,
    String? emotion,
    String? language,
  }) async {
    try {
      final currentVoiceStyle = VoiceStyleService.instance.currentVoiceStyle;

      String targetLanguage = language ?? 'zh';
      if (language == null) {
      }

      if (!currentVoiceStyle.supportsLanguage(targetLanguage)) {
        print('当前音色不支持语言 $targetLanguage，使用默认音色');
        return await textToSpeech(
          text: text,
          emotion: emotion,
          voiceStyle: 'default',
          language: targetLanguage,
        );
      }

      return await textToSpeech(
        text: text,
        emotion: emotion,
        voiceStyle: currentVoiceStyle.id,
        language: targetLanguage,
      );
    } catch (e) {
      print('智能文本转语音失败: $e');
      return await textToSpeech(
        text: text,
        emotion: emotion,
        language: language,
      );
    }
  }

  Future<Map<String, dynamic>> getVoicePreferences() async {
    try {
      final response = await HTTPManager.get(
        '${NetworkConfig.baseUrl}/speech/preferences',
        requireAuth: true,
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {};
      }
    } catch (e) {
      return {};
    }
  }
}
