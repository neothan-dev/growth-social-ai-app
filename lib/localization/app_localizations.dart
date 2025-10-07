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
import 'package:shared_preferences/shared_preferences.dart';
import 'zh.dart';

import 'foreign/ja.dart';
import 'foreign/ko.dart';
import 'foreign/es.dart';
import 'foreign/fr.dart';
import 'foreign/de.dart';
import 'foreign/it.dart';
import 'foreign/pt.dart';
import 'foreign/ru.dart';
import 'foreign/ar.dart';
import 'foreign/en.dart';

class AppLocalizations {
  static const String _languageKey = 'app_language';
  static const String _defaultLanguage = 'en';

  static String _currentLanguage = _defaultLanguage;
  static Map<String, String> _currentStrings = en;

  static const List<String> supportedLanguages = [
    'en',
    'zh',
    'ja',
    'ko',
    'es',
    'fr',
    'de',
    'it',
    'pt',
    'ru',
    'ar',
  ];
  static const List<String> languageNames = [
    'English',
    '中文',
    '日本語',
    '한국어',
    'Español',
    'Français',
    'Deutsch',
    'Italiano',
    'Português',
    'Русский',
    'العربية',
  ];

  static String get currentLanguage => _currentLanguage;

  static String get currentLanguageName {
    final index = supportedLanguages.indexOf(_currentLanguage);
    return index >= 0 ? languageNames[index] : languageNames[0];
  }

  static Future<void> initialize() async {
    await _loadLanguageFromStorage();
  }

  static Future<void> setLanguage(String languageCode) async {
    if (!supportedLanguages.contains(languageCode)) {
      languageCode = _defaultLanguage;
    }

    _currentLanguage = languageCode;
    _currentStrings = _getStringsForLanguage(languageCode);

    await _saveLanguageToStorage(languageCode);
  }

  static String getString(String key) {
    return _currentStrings[key] ?? key;
  }

  static String getStringWithParams(String key, Map<String, String> params) {
    String text = getString(key);

    params.forEach((paramKey, paramValue) {
      text = text.replaceAll('{$paramKey}', paramValue);
    });

    return text;
  }

  static List<Map<String, String>> getSupportedLanguages() {
    return supportedLanguages.asMap().entries.map((entry) {
      return {'code': entry.value, 'name': languageNames[entry.key]};
    }).toList();
  }

  static Future<void> _loadLanguageFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguage = prefs.getString(_languageKey);

      if (savedLanguage != null && supportedLanguages.contains(savedLanguage)) {
        _currentLanguage = savedLanguage;
        _currentStrings = _getStringsForLanguage(savedLanguage);
      } else {
        _currentLanguage = _defaultLanguage;
        _currentStrings = _getStringsForLanguage(_defaultLanguage);
      }
    } catch (e) {
      _currentLanguage = _defaultLanguage;
      _currentStrings = _getStringsForLanguage(_defaultLanguage);
    }
  }

  static Future<void> _saveLanguageToStorage(String languageCode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, languageCode);
    } catch (e) {}
  }

  static Map<String, String> _getStringsForLanguage(String languageCode) {
    switch (languageCode) {
      case 'zh':
        return zh;
      case 'ja':
        return ja;
      case 'ko':
        return ko;
      case 'es':
        return es;
      case 'fr':
        return fr;
      case 'de':
        return de;
      case 'it':
        return it;
      case 'pt':
        return pt;
      case 'ru':
        return ru;
      case 'ar':
        return ar;
      case 'en':
        return en;
      default:
        return en;
    }
  }

  static TextDirection get textDirection {
    return _currentLanguage == 'ar' ? TextDirection.rtl : TextDirection.ltr;
  }

  static Locale get locale {
    return Locale(_currentLanguage);
  }

  static List<Locale> get supportedLocales {
    return supportedLanguages.map((lang) => Locale(lang)).toList();
  }
}

extension LocalizationExtension on String {
  String get tr => AppLocalizations.getString(this);

  String trParams(Map<String, String> params) =>
      AppLocalizations.getStringWithParams(this, params);
}

extension LocalizationWidgetExtension on Widget {
  Widget withDirection() {
    return Directionality(
      textDirection: AppLocalizations.textDirection,
      child: this,
    );
  }
}
