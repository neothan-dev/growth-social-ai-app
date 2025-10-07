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

import 'package:flutter/material.dart';
import '../../models/dashboard_card_model.dart';
import '../../theme/app_theme.dart';
import '../../utils/haptic_feedback_helper.dart';

abstract class DashboardCard extends StatelessWidget {
  final DashboardCardModel model;
  const DashboardCard({required this.model, Key? key}) : super(key: key);

  @protected
  void onTap(BuildContext context) {
    // 为卡片点击提供震动反馈
    HapticFeedbackHelper.buttonTap();
    // 可在基类做通用处理，如埋点、动画等
  }

  Widget buildCardContainer({
    required BuildContext context,
    required Widget child,
    required List<Color> gradientColors,
    double height = 150,
    EdgeInsets? padding,
  }) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
          borderRadius: AppTheme.borderRadiusLg,
          boxShadow: AppTheme.shadowMd,
        ),
        child: Container(
          width: double.infinity,
          height: height,
          padding: padding ?? AppTheme.paddingMd,
          child: child,
        ),
      ),
    );
  }

  Widget buildCardHeader({
    required IconData icon,
    String? badgeText,
    Color iconColor = Colors.white,
    Color badgeColor = Colors.white,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            model.title,
            style: AppTheme.h4.copyWith(
              color: iconColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (badgeText != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: badgeColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              badgeText,
              style: AppTheme.caption.copyWith(
                color: badgeColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }

  Widget buildTag({
    required String text,
    Color backgroundColor = Colors.white,
    Color textColor = Colors.white,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: AppTheme.caption.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget buildDataContainer({
    required Widget child,
    Color backgroundColor = Colors.white,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor.withValues(alpha: 0.15),
        borderRadius: AppTheme.borderRadiusMd,
      ),
      child: child,
    );
  }
}
