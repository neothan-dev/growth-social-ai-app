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

class DeviceService {
  Future<bool> connectDevice(String deviceType) async {
    try {
      final response = await HTTPManager.post(
        '${NetworkConfig.baseUrl}/device/connect',
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'device_type': deviceType}),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    } catch (e) {
      return false;
    }
  }
}
