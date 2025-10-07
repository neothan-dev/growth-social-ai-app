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
import 'package:web_socket_channel/web_socket_channel.dart';
import '../config/network_config.dart';
import 'dart:io';
import 'package:web_socket_channel/io.dart';
import 'dart:async';
import 'auth_manager.dart';

class HTTPManager {
  static const Duration _timeout = Duration(seconds: 10);
  static AuthManager? _authManager;

  static void setAuthManager(AuthManager authManager) {
    _authManager = authManager;
  }

  static Map<String, String> _getAuthHeaders() {
    return _authManager?.getAuthHeaders() ?? {};
  }

  static Future<http.Response> get(
    String url, {
    Map<String, String>? headers,
    bool requireAuth = false,
  }) async {
    try {
      Map<String, String> finalHeaders = headers ?? {};
      if (requireAuth) {
        finalHeaders.addAll(_getAuthHeaders());
      }

      final response = await http
          .get(Uri.parse(url), headers: finalHeaders)
          .timeout(_timeout);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.Response> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    bool requireAuth = false,
  }) async {
    try {
      Map<String, String> finalHeaders = headers ?? {};
      if (requireAuth) {
        finalHeaders.addAll(_getAuthHeaders());
      }

      final response = await http
          .post(
            Uri.parse(url),
            headers: finalHeaders,
            body: body,
            encoding: encoding,
          )
          .timeout(_timeout);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.Response> put(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    bool requireAuth = false,
  }) async {
    try {
      Map<String, String> finalHeaders = headers ?? {};
      if (requireAuth) {
        finalHeaders.addAll(_getAuthHeaders());
      }

      final response = await http
          .put(
            Uri.parse(url),
            headers: finalHeaders,
            body: body,
            encoding: encoding,
          )
          .timeout(_timeout);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.Response> delete(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    bool requireAuth = false,
  }) async {
    try {
      Map<String, String> finalHeaders = headers ?? {};
      if (requireAuth) {
        finalHeaders.addAll(_getAuthHeaders());
      }

      final response = await http
          .delete(
            Uri.parse(url),
            headers: finalHeaders,
            body: body,
            encoding: encoding,
          )
          .timeout(_timeout);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

class WebSocketManager {
  WebSocketChannel? _channel;
  final Duration _timeout = Duration(seconds: 7);
  static AuthManager? _authManager;

  static void setAuthManager(AuthManager authManager) {
    _authManager = authManager;
  }

  Future<void> connect(String path, {bool requireAuth = false}) async {
    String url = '${NetworkConfig.wsBaseUrl}$path';

    if (requireAuth && _authManager?.authToken != null) {
      final separator = url.contains('?') ? '&' : '?';
      url = '$url${separator}token=${_authManager!.authToken}';
    }

    try {
      final ws = await WebSocket.connect(url).timeout(_timeout);
      _channel = IOWebSocketChannel(ws);
    } on TimeoutException {
      throw Exception('WebSocket连接超时');
    } catch (e) {
      rethrow;
    }
  }

  WebSocketChannel? get channel => _channel;

  void disconnect() {
    _channel?.sink.close();
    _channel = null;
  }
}
