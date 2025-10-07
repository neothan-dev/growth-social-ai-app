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
import '../models/health_data.dart';
import 'dart:io';
import '../config/network_config.dart';
import 'network_service.dart';

class HealthDataService {
  Future<List<HealthData>> fetchHealthData() async {
    try {
      final response = await HTTPManager.get(
        '${NetworkConfig.baseUrl}/health/data',
        requireAuth: true,
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map(
              (item) => HealthData(
                date: DateTime.parse(item['date']),
                steps: item['steps'],
                heartRate: item['heart_rate'],
                sleepHours: item['sleep_hours'].toDouble(),
              ),
            )
            .toList();
      } else if (response.statusCode == 401) {
        return [];
      } else {
        return [];
      }
    } on SocketException catch (_) {
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<bool> uploadHealthData(HealthData data) async {
    try {
      final response = await HTTPManager.post(
        '${NetworkConfig.baseUrl}/health/upload',
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'date': data.date.toIso8601String(),
          'steps': data.steps,
          'heart_rate': data.heartRate,
          'sleep_hours': data.sleepHours,
        }),
        requireAuth: true,
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>> getHealthStats() async {
    try {
      final response = await HTTPManager.get(
        '${NetworkConfig.baseUrl}/health/stats',
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
