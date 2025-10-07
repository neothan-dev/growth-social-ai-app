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

import '../dashboard_card.dart';
import '../../../models/dashboard_card_model.dart';
import '../../../theme/app_theme.dart';
import 'package:flutter/material.dart';
import '../../../localization/app_localizations.dart';

class HeartRateCard extends DashboardCard {
  HeartRateCard({Key? key})
    : super(
        model: DashboardCardModel(
          type: DashboardCardType.bodyMetrics,
          title: "5f1e61a642w8PPbkw43D".tr,
          width: 2,
          height: 2,
          data: {'bpm': 72, 'status': "296de0e31fibLhpxO21w".tr},
        ),
        key: key,
      );

  @override
  void onTap(BuildContext context) {
    super.onTap(context);
  }

  Color _getHeartRateColor(int bpm) {
    if (bpm < 60) return const Color(0xFF4FC3F7);
    if (bpm > 100) return const Color(0xFFFF5722);
    return const Color(0xFF4CAF50);
  }

  String _getHeartRateStatus(int bpm) {
    if (bpm < 60) return "fd9b72d8decWWziYgAcs".tr;
    if (bpm > 100) return "cde6311d91DEmHCTjo3l".tr;
    return "296de0e31fgPbcWiMHHe".tr;
  }

  @override
  Widget build(BuildContext context) {
    final bpm = model.data['bpm'] ?? 72;
    final heartColor = _getHeartRateColor(bpm);
    final status = _getHeartRateStatus(bpm);

    return buildCardContainer(
      context: context,
      gradientColors: [heartColor, heartColor.withValues(alpha: 0.7)],
      height: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  model.title,
                  style: AppTheme.h4.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '$bpm',
                            style: AppTheme.h2.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              'BPM',
                              style: AppTheme.bodySmall.copyWith(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          status,
                          style: AppTheme.caption.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(
                    Icons.timeline,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
