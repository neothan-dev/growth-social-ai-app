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
import 'package:shared_preferences/shared_preferences.dart';
import '../models/voice_style.dart';
import 'network_service.dart';
import '../config/network_config.dart';

class VoiceStyleService {
  static const String _voiceStyleKey = 'selected_voice_style';
  static VoiceStyleService? _instance;
  VoiceStyle? _currentVoiceStyle;

  VoiceStyleService._();

  static VoiceStyleService get instance {
    _instance ??= VoiceStyleService._();
    return _instance!;
  }

  VoiceStyle get currentVoiceStyle {
    return _currentVoiceStyle ?? VoiceStyle.getDefault();
  }

  Future<void> setVoiceStyle(VoiceStyle voiceStyle) async {
    _currentVoiceStyle = voiceStyle;
    await _saveVoiceStyle(voiceStyle);
  }

  Future<void> initialize() async {
    await _loadVoiceStyle();
  }

  Future<void> _saveVoiceStyle(VoiceStyle voiceStyle) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final voiceStyleJson = voiceStyle.toJson();
      await prefs.setString(_voiceStyleKey, jsonEncode(voiceStyleJson));
    } catch (e) {
      print('保存音色设置失败: $e');
    }
  }

  Future<void> _loadVoiceStyle() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final voiceStyleString = prefs.getString(_voiceStyleKey);

      if (voiceStyleString != null) {
        final voiceStyleJson = jsonDecode(voiceStyleString);
        _currentVoiceStyle = VoiceStyle.fromJson(voiceStyleJson);
      } else {
        _currentVoiceStyle = VoiceStyle.getDefault();
      }
    } catch (e) {
      print('加载音色设置失败: $e');
      _currentVoiceStyle = VoiceStyle.getDefault();
    }
  }

  List<VoiceStyle> getAvailableVoices() {
    return VoiceStyle.availableVoices;
  }

  VoiceStyle? getVoiceById(String id) {
    return VoiceStyle.getById(id);
  }

  String getVoiceForLanguage(String voiceStyleId, String language) {
    final voiceStyle = getVoiceById(voiceStyleId);
    if (voiceStyle != null) {
      return voiceStyle.getVoiceForLanguage(language);
    }
    return VoiceStyle.getDefault().getVoiceForLanguage(language);
  }

  bool supportsLanguage(String voiceStyleId, String language) {
    final voiceStyle = getVoiceById(voiceStyleId);
    if (voiceStyle != null) {
      return voiceStyle.supportsLanguage(language);
    }
    return true;
  }

  Future<List<Map<String, dynamic>>> getVoiceStylesFromServer() async {
    try {
      final response = await HTTPManager.get(
        '${NetworkConfig.baseUrl}/speech/voice-styles',
        requireAuth: true,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['voice_styles'] ?? []);
      } else {
        print('获取音色列表失败: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('获取音色列表异常: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>?> getVoiceStyleInfo(String voiceStyleId) async {
    try {
      final response = await HTTPManager.get(
        '${NetworkConfig.baseUrl}/speech/voice-styles/$voiceStyleId',
        requireAuth: true,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('获取音色信息失败: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('获取音色信息异常: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getVoiceStylePreview(
    String voiceStyleId,
    String language,
  ) async {
    try {
      final response = await HTTPManager.get(
        '${NetworkConfig.baseUrl}/speech/voice-styles/$voiceStyleId/preview?language=$language',
        requireAuth: true,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('获取音色预览失败: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('获取音色预览异常: $e');
      return null;
    }
  }

  Future<List<String>> getSupportedLanguagesForStyle(
    String voiceStyleId,
  ) async {
    try {
      final response = await HTTPManager.get(
        '${NetworkConfig.baseUrl}/speech/voice-styles/$voiceStyleId/languages',
        requireAuth: true,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<String>.from(data['supported_languages'] ?? []);
      } else {
        print('获取支持语言失败: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('获取支持语言异常: $e');
      return [];
    }
  }

  String getCurrentVoiceForLanguage(String language) {
    return currentVoiceStyle.getVoiceForLanguage(language);
  }

  bool currentVoiceSupportsLanguage(String language) {
    return currentVoiceStyle.supportsLanguage(language);
  }
}
