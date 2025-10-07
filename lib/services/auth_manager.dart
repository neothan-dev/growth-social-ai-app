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

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager extends ChangeNotifier {
  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';

  String? _authToken;
  int? _userId;
  bool _isAuthenticated = false;

  String? get authToken => _authToken;
  int? get userId => _userId;
  bool get isAuthenticated => _isAuthenticated;

  Future<void> initialize() async {
    try {
      await _loadAuthFromStorage();
    } catch (e) {
      debugPrint('初始化认证管理器失败: $e');
    }
  }

  Future<void> setAuth(String token, int userId) async {
    _authToken = token;
    _userId = userId;
    _isAuthenticated = true;

    await _saveAuthToStorage();
    notifyListeners();
  }

  Future<void> clearAuth() async {
    _authToken = null;
    _userId = null;
    _isAuthenticated = false;

    await _clearAuthFromStorage();
    notifyListeners();
  }

  Map<String, String> getAuthHeaders() {
    if (_authToken == null) return {};

    return {
      'Authorization': 'Bearer $_authToken',
      'Content-Type': 'application/json',
    };
  }

  bool isTokenValid() {
    return _authToken != null && _authToken!.isNotEmpty;
  }

  Future<bool> refreshToken() async {
    return isTokenValid();
  }


  Future<void> _loadAuthFromStorage() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString(_tokenKey);
    final userId = prefs.getInt(_userIdKey);

    if (token != null && userId != null) {
      _authToken = token;
      _userId = userId;
      _isAuthenticated = true;
    }
  }

  Future<void> _saveAuthToStorage() async {
    final prefs = await SharedPreferences.getInstance();

    if (_authToken != null && _userId != null) {
      await prefs.setString(_tokenKey, _authToken!);
      await prefs.setInt(_userIdKey, _userId!);
    }
  }

  Future<void> _clearAuthFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userIdKey);
  }
}
