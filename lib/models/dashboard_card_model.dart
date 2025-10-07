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

enum DashboardCardType {
  steps,
  weather,
  sleep,
  bodyMetrics,
  recipe,
  bloodPressure,
  bloodSugar,
  exercise,
  waterIntake,
  mood,
  healthSummary,
}

class DashboardCardModel {
  final DashboardCardType type;
  final String title;
  final int width;
  final int height;
  final dynamic data;

  DashboardCardModel({
    required this.type,
    required this.title,
    required this.width,
    required this.height,
    this.data,
  });
}
