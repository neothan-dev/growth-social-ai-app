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

class AIService {
  Future<String> getAIResponse(String input) async {
    try {
      final response = await HTTPManager.post(
        '${NetworkConfig.baseUrl}/ai/response',
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'input': input}),
        requireAuth: true,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['response'] ?? '';
      } else if (response.statusCode == 401) {
        return '请先登录';
      } else {
        return 'AI服务异常';
      }
    } on SocketException catch (_) {
      return '无法连接服务器';
    } catch (e) {
      return '请求异常';
    }
  }

  Future<String> getPersonalizedAdvice() async {
    try {
      final response = await HTTPManager.get(
        '${NetworkConfig.baseUrl}/ai/personalized-advice',
        requireAuth: true,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['advice'] ?? '';
      } else if (response.statusCode == 401) {
        return '请先登录';
      } else {
        return '获取建议失败';
      }
    } on SocketException catch (_) {
      return '无法连接服务器';
    } catch (e) {
      return '请求异常';
    }
  }
}
