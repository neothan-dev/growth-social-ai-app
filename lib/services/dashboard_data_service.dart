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
import '../models/dashboard_card_model.dart';
import '../config/network_config.dart';
import 'network_service.dart';
import '../localization/app_localizations.dart';

class DashboardDataService {
  Future<DashboardCardModel> getStepsCardData() async {
    try {
      final response = await HTTPManager.get(
        '${NetworkConfig.baseUrl}/dashboard/steps',
        requireAuth: true,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return DashboardCardModel(
          type: DashboardCardType.steps,
          title: "50897d95949sCN0fxSbL".tr,
          width: 3,
          height: 4,
          data: data,
        );
      } else {
        return DashboardCardModel(
          type: DashboardCardType.steps,
          title: "50897d9594TOmq7vVUAl".tr,
          width: 3,
          height: 4,
          data: {'steps': 8000, 'activity': "c7092c51fdoQrZIIn5LF".tr},
        );
      }
    } catch (e) {
      return DashboardCardModel(
        type: DashboardCardType.steps,
        title: "50897d95948G8jDOgskJ".tr,
        width: 3,
        height: 4,
        data: {'steps': 8000, 'activity': "c7092c51fdwSwAZVD0eT".tr},
      );
    }
  }

  Future<DashboardCardModel> getWeatherCardData() async {
    try {
      final response = await HTTPManager.get(
        '${NetworkConfig.baseUrl}/dashboard/weather',
        requireAuth: true,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return DashboardCardModel(
          type: DashboardCardType.weather,
          title: "e2d89f9d30I5MsB2ja7P".tr,
          width: 2,
          height: 4,
          data: data,
        );
      } else {
        return DashboardCardModel(
          type: DashboardCardType.weather,
          title: "e2d89f9d30ZlozXh4viM".tr,
          width: 2,
          height: 4,
          data: {'temp': '25°C', 'desc': "6379ede5c2Zorxc23foR".tr},
        );
      }
    } catch (e) {
      return DashboardCardModel(
        type: DashboardCardType.weather,
        title: "e2d89f9d30UWgQ0O2XG3".tr,
        width: 2,
        height: 4,
        data: {'temp': '25°C', 'desc': "6379ede5c2sSbudM5M1N".tr},
      );
    }
  }

  Future<DashboardCardModel> getSleepCardData() async {
    try {
      final response = await HTTPManager.get(
        '${NetworkConfig.baseUrl}/dashboard/sleep',
        requireAuth: true,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return DashboardCardModel(
          type: DashboardCardType.sleep,
          title: "01324e540dnqwE0SoCb8".tr,
          width: 2,
          height: 2,
          data: data,
        );
      } else {
        return DashboardCardModel(
          type: DashboardCardType.sleep,
          title: "01324e540dBA59BLaFuz".tr,
          width: 2,
          height: 2,
          data: {'hours': 7.5},
        );
      }
    } catch (e) {
      return DashboardCardModel(
        type: DashboardCardType.sleep,
        title: "01324e540dwVoQJYdzbU".tr,
        width: 2,
        height: 2,
        data: {'hours': 7.5},
      );
    }
  }

  Future<DashboardCardModel> getBodyMetricsCardData() async {
    try {
      final response = await HTTPManager.get(
        '${NetworkConfig.baseUrl}/dashboard/body-metrics',
        requireAuth: true,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return DashboardCardModel(
          type: DashboardCardType.bodyMetrics,
          title: "d50dc87729Xrk82HKjIs".tr,
          width: 2,
          height: 2,
          data: data,
        );
      } else {
        return DashboardCardModel(
          type: DashboardCardType.bodyMetrics,
          title: "d50dc877290DrCbOsC74".tr,
          width: 2,
          height: 2,
          data: {'weight': 65, 'height': 170},
        );
      }
    } catch (e) {
      return DashboardCardModel(
        type: DashboardCardType.bodyMetrics,
        title: "d50dc87729Z7w24eUSp2".tr,
        width: 2,
        height: 2,
        data: {'weight': 65, 'height': 170},
      );
    }
  }

  Future<DashboardCardModel> getRecipeCardData() async {
    try {
      final response = await HTTPManager.get(
        '${NetworkConfig.baseUrl}/dashboard/recipe',
        requireAuth: true,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return DashboardCardModel(
          type: DashboardCardType.recipe,
          title: "e9352b5a9c5zDLfN4BVb".tr,
          width: 4,
          height: 2,
          data: data,
        );
      } else {
        return DashboardCardModel(
          type: DashboardCardType.recipe,
          title: "e9352b5a9canBlKOm5uh".tr,
          width: 4,
          height: 2,
          data: {'suggestion': "f74aeebd76kSFYRfXmyt".tr},
        );
      }
    } catch (e) {
      return DashboardCardModel(
        type: DashboardCardType.recipe,
        title: '食谱建议',
        width: 4,
        height: 2,
        data: {'suggestion': "f74aeebd76FAzOiJjghZ".tr},
      );
    }
  }
}
