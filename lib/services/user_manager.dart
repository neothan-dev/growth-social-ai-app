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
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import 'auth_manager.dart';
import 'network_service.dart';
import '../config/network_config.dart';

class UserManager extends ChangeNotifier {
  static const String _userKey = 'current_user';
  static const String _isLoggedInKey = 'is_logged_in';

  static const String _hasShownVoiceChatTip = 'has_shown_voice_chat_tip';
  static const String _hasShownDashboardVoiceChatTip =
      'has_shown_dashboard_voice_chat_tip';
  static const String _isFirstLogin = 'is_first_login';

  User? _currentUser;
  bool _isLoggedIn = false;
  bool _isLoading = false;
  late AuthManager _authManager;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  bool get hasUser => _currentUser != null;
  AuthManager get authManager => _authManager;

  UserManager() {
    _authManager = AuthManager();
  }

  Future<void> initialize() async {
    _setLoading(true);
    try {
      await _authManager.initialize();
      await _loadUserFromStorage();
    } catch (e) {
      debugPrint('初始化用户管理器失败: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> login(User user, String token) async {
    _setLoading(true);
    try {
      _currentUser = user;
      _isLoggedIn = true;

      await _authManager.setAuth(token, user.id);

      await _syncPreferencesFromServer();

      await _saveUserToStorage();
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('保存用户信息失败: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    _setLoading(true);
    try {
      _currentUser = null;
      _isLoggedIn = false;

      await _authManager.clearAuth();
      await _clearUserFromStorage();
      notifyListeners();
    } catch (e) {
      debugPrint('清除用户信息失败: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> HasShownVoiceChatTip() async {
    if (_currentUser == null) return false;

    try {
      final preferences = await _getServerPreferences();
      return preferences[_hasShownVoiceChatTip] == true;
    } catch (e) {
      debugPrint('获取语音聊天提示状态失败: $e');
      return _currentUser?.preferences?[_hasShownVoiceChatTip] == true;
    }
  }

  Future<void> ShowVoiceChatTip() async {
    if (_currentUser == null) return;

    try {
      await _updateServerPreference(_hasShownVoiceChatTip, true);
    } catch (e) {
      debugPrint('更新语音聊天提示状态失败: $e');
      _updateLocalPreference(_hasShownVoiceChatTip, true);
    }
  }

  Future<bool> HasShownDashboardVoiceChatTip() async {
    if (_currentUser == null) return false;

    try {
      final preferences = await _getServerPreferences();
      return preferences[_hasShownDashboardVoiceChatTip] == true;
    } catch (e) {
      debugPrint('获取仪表板语音聊天提示状态失败: $e');
      return _currentUser?.preferences?[_hasShownDashboardVoiceChatTip] == true;
    }
  }

  Future<void> ShowDashboardVoiceChatTip() async {
    if (_currentUser == null) return;

    try {
      await _updateServerPreference(_hasShownDashboardVoiceChatTip, true);
    } catch (e) {
      debugPrint('更新仪表板语音聊天提示状态失败: $e');
      _updateLocalPreference(_hasShownDashboardVoiceChatTip, true);
    }
  }

  Future<bool> isFirstLogin() async {
    if (_currentUser == null) return true;

    try {
      final preferences = await _getServerPreferences();
      return preferences[_isFirstLogin] != false;
    } catch (e) {
      debugPrint('获取首次登录状态失败: $e');
      return _currentUser?.preferences?[_isFirstLogin] != false;
    }
  }

  Future<void> markFirstLoginCompleted() async {
    if (_currentUser == null) return;

    try {
      await _updateServerPreference(_isFirstLogin, false);
    } catch (e) {
      debugPrint('更新首次登录状态失败: $e');
      _updateLocalPreference(_isFirstLogin, false);
    }
  }

  Future<bool> updateUser(User updatedUser) async {
    if (_currentUser == null) return false;

    _setLoading(true);
    try {
      _currentUser = updatedUser;
      await _saveUserToStorage();
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('更新用户信息失败: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> updatePreferences(Map<String, dynamic> preferences) async {
    if (_currentUser == null) return false;

    try {
      final updatedUser = _currentUser!.copyWith(preferences: preferences);
      return await updateUser(updatedUser);
    } catch (e) {
      debugPrint('更新用户偏好设置失败: $e');
      return false;
    }
  }

  T? getPreference<T>(String key, {T? defaultValue}) {
    if (_currentUser?.preferences == null) return defaultValue;
    final value = _currentUser!.preferences![key];
    if (value is T) return value;
    return defaultValue;
  }

  Future<bool> setPreference<T>(String key, T value) async {
    if (_currentUser == null) return false;

    final currentPreferences = Map<String, dynamic>.from(
      _currentUser!.preferences ?? {},
    );
    currentPreferences[key] = value;

    return await updatePreferences(currentPreferences);
  }

  Future<bool> refreshUserInfo() async {
    if (_currentUser == null) return false;

    try {
      final response = await HTTPManager.get(
        '${NetworkConfig.baseUrl}/auth/profile',
        headers: _authManager.getAuthHeaders(),
      );

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        final updatedUser = User.fromJson(userData);
        _currentUser = updatedUser;
        await _saveUserToStorage();
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('刷新用户信息失败: $e');
      return false;
    }
  }

  bool checkLoginStatus() {
    return _isLoggedIn && _currentUser != null && _authManager.isAuthenticated;
  }

  Map<String, String> getAuthHeaders() {
    return _authManager.getAuthHeaders();
  }


  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<Map<String, dynamic>> _getServerPreferences() async {
    try {
      final response = await HTTPManager.get(
        '${NetworkConfig.baseUrl}/auth/preferences',
        headers: _authManager.getAuthHeaders(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Map<String, dynamic>.from(data['preferences'] ?? {});
      } else {
        throw Exception('获取偏好设置失败: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('从服务器获取偏好设置失败: $e');
      return {};
    }
  }

  Future<void> _updateServerPreference(String key, dynamic value) async {
    try {
      final currentPreferences = await _getServerPreferences();

      currentPreferences[key] = value;

      final response = await HTTPManager.put(
        '${NetworkConfig.baseUrl}/auth/preferences',
        headers: {
          ..._authManager.getAuthHeaders(),
          'Content-Type': 'application/json',
        },
        body: jsonEncode(currentPreferences),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final updatedPreferences = Map<String, dynamic>.from(
          data['preferences'] ?? {},
        );

        if (_currentUser != null) {
          _currentUser = _currentUser!.copyWith(
            preferences: updatedPreferences,
          );
          await _saveUserToStorage();
          notifyListeners();
        }
      } else {
        throw Exception('更新偏好设置失败: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('更新服务器偏好设置失败: $e');
      rethrow;
    }
  }

  Future<void> _syncPreferencesFromServer() async {
    if (_currentUser == null) return;

    try {
      final serverPreferences = await _getServerPreferences();
      final currentPreferences = Map<String, dynamic>.from(
        _currentUser!.preferences ?? {},
      );

      final keysToUpdate = serverPreferences.keys.where((key) {
        final currentValue = currentPreferences[key];
        return currentValue != serverPreferences[key];
      }).toList();

      for (final key in keysToUpdate) {
        await _updateServerPreference(key, serverPreferences[key]);
      }
    } catch (e) {
      debugPrint('同步偏好设置失败: $e');
    }
  }

  Future<void> _loadUserFromStorage() async {
    final prefs = await SharedPreferences.getInstance();

    final isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;
    if (!isLoggedIn) return;

    final userJson = prefs.getString(_userKey);

    if (userJson != null && _authManager.isAuthenticated) {
      try {
        final userData = jsonDecode(userJson) as Map<String, dynamic>;
        _currentUser = User.fromJson(userData);
        _isLoggedIn = true;
      } catch (e) {
        debugPrint('解析用户信息失败: $e');
        await _clearUserFromStorage();
      }
    }
  }

  Future<void> _saveUserToStorage() async {
    final prefs = await SharedPreferences.getInstance();

    if (_currentUser != null && _isLoggedIn) {
      await prefs.setString(_userKey, jsonEncode(_currentUser!.toJson()));
      await prefs.setBool(_isLoggedInKey, true);
    }
  }

  Future<void> _clearUserFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    await prefs.setBool(_isLoggedInKey, false);
  }

  void _updateLocalPreference(String key, dynamic value) {
    if (_currentUser != null) {
      final currentPreferences = Map<String, dynamic>.from(
        _currentUser!.preferences ?? {},
      );
      currentPreferences[key] = value;
      _currentUser = _currentUser!.copyWith(preferences: currentPreferences);
      notifyListeners();
    }
  }
}
