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
import 'package:http/http.dart' as http;
import 'dart:io';
import '../config/network_config.dart';
import 'network_service.dart';
import '../models/user.dart';
import '../localization/app_localizations.dart';

class AuthResult {
  final bool status;
  final String reason;
  final User? user;
  final String? token;

  AuthResult({
    required this.status,
    required this.reason,
    this.user,
    this.token,
  });
}

class AuthService {
  Future<AuthResult> login(String username, String password) async {
    try {
      final response = await HTTPManager.post(
        '${NetworkConfig.baseUrl}/auth/login',
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final userData = data['user'] as Map<String, dynamic>;
        final user = User.fromJson(userData);
        final token = data['token'] as String;

        return AuthResult(status: true, reason: '', user: user, token: token);
      } else if (response.statusCode == 401) {
        return AuthResult(status: false, reason: "a9a6a83a7dfhim9a4hX2".tr);
      } else {
        return AuthResult(
          status: false,
          reason: response.body + "56b36087530FEqYytBgs".tr,
        );
      }
    } on SocketException catch (_) {
      return AuthResult(status: false, reason: "42545546d3Ql59ZLEno1".tr);
    } catch (e) {
      return AuthResult(status: false, reason: "00eaa32366EDR6iwW0t9".tr);
    }
  }

  Future<AuthResult> register(
    String username,
    String password,
    String fullName,
    int age,
    String region,
  ) async {
    final url = Uri.parse('${NetworkConfig.baseUrl}/auth/register');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
          'full_name': fullName.isNotEmpty ? fullName : "",
          'age': age > 0 ? age : 0,
          'region': region.isNotEmpty ? region : "",
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final userData = data['user'] as Map<String, dynamic>;
        final user = User.fromJson(userData);
        final token = data['token'] as String;

        return AuthResult(status: true, reason: '', user: user, token: token);
      } else if (response.statusCode == 400) {
        final data = jsonDecode(response.body);
        return AuthResult(
          status: false,
          reason: data['detail'] ?? "6d57824e031j6qSD2u7G".tr,
        );
      } else {
        return AuthResult(status: false, reason: "56b3608753YodFekHKSo".tr);
      }
    } on SocketException catch (_) {
      return AuthResult(status: false, reason: "42545546d3kOYEJDpb9E".tr);
    } catch (e) {
      return AuthResult(status: false, reason: "ebbaa5eb76WCY8NUlhGy".tr);
    }
  }

  Future<User?> getUserInfo(String token) async {
    try {
      final response = await HTTPManager.get(
        '${NetworkConfig.baseUrl}/auth/profile',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return User.fromJson(data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<AuthResult> updateUserInfo(
    String token,
    Map<String, dynamic> userData,
  ) async {
    try {
      final response = await HTTPManager.put(
        '${NetworkConfig.baseUrl}/auth/profile',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = User.fromJson(data);
        return AuthResult(status: true, reason: '', user: user);
      } else {
        return AuthResult(status: false, reason: "ec99e5c45d4xt94gEXLM".tr);
      }
    } catch (e) {
      return AuthResult(status: false, reason: "d536d47bd3N3ZJnxkpPy".tr);
    }
  }

  Future<AuthResult> changePassword(
    String token,
    String oldPassword,
    String newPassword,
  ) async {
    try {
      final response = await HTTPManager.put(
        '${NetworkConfig.baseUrl}/auth/change-password',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'old_password': oldPassword,
          'new_password': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        return AuthResult(status: true, reason: "c5299b8223Xy4e91NWD5".tr);
      } else if (response.statusCode == 400) {
        final data = jsonDecode(response.body);
        return AuthResult(
          status: false,
          reason: data['detail'] ?? "878b622b47w9xt0M72lN".tr,
        );
      } else {
        return AuthResult(status: false, reason: "56b3608753TEOmnr7Slm".tr);
      }
    } catch (e) {
      return AuthResult(status: false, reason: "d536d47bd36vem51zqjB".tr);
    }
  }

  Future<bool> logout(String token) async {
    try {
      final response = await HTTPManager.post(
        '${NetworkConfig.baseUrl}/auth/logout',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
