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

import 'package:flutter/services.dart';
import 'dart:io';

/// 震动反馈工具类
/// 提供不同类型的震动反馈，适配iOS和Android平台
class HapticFeedbackHelper {
  /// 轻触反馈 - 适用于按钮点击、导航切换等
  static void lightImpact() {
    if (Platform.isIOS) {
      HapticFeedback.lightImpact();
    } else if (Platform.isAndroid) {
      HapticFeedback.vibrate();
    }
  }

  /// 中等强度反馈 - 适用于重要操作确认
  static void mediumImpact() {
    if (Platform.isIOS) {
      HapticFeedback.mediumImpact();
    } else if (Platform.isAndroid) {
      HapticFeedback.vibrate();
    }
  }

  /// 重触反馈 - 适用于警告或错误操作
  static void heavyImpact() {
    if (Platform.isIOS) {
      HapticFeedback.heavyImpact();
    } else if (Platform.isAndroid) {
      HapticFeedback.vibrate();
    }
  }

  /// 选择反馈 - 适用于选择器、轮盘等
  static void selectionClick() {
    if (Platform.isIOS) {
      HapticFeedback.selectionClick();
    } else if (Platform.isAndroid) {
      HapticFeedback.vibrate();
    }
  }

  /// 成功反馈 - 适用于操作成功
  static void success() {
    if (Platform.isIOS) {
      // iOS没有专门的成功反馈，使用中等强度
      HapticFeedback.mediumImpact();
    } else if (Platform.isAndroid) {
      HapticFeedback.vibrate();
    }
  }

  /// 错误反馈 - 适用于操作失败或错误
  static void error() {
    if (Platform.isIOS) {
      // iOS使用重触反馈表示错误
      HapticFeedback.heavyImpact();
    } else if (Platform.isAndroid) {
      HapticFeedback.vibrate();
    }
  }

  /// 警告反馈 - 适用于警告信息
  static void warning() {
    if (Platform.isIOS) {
      HapticFeedback.mediumImpact();
    } else if (Platform.isAndroid) {
      HapticFeedback.vibrate();
    }
  }

  /// 导航反馈 - 专门为导航栏设计的轻触反馈
  static void navigationTap() {
    lightImpact();
  }

  /// 按钮反馈 - 专门为按钮设计的反馈
  static void buttonTap() {
    lightImpact();
  }

  /// 开关反馈 - 专门为开关设计的反馈
  static void toggleSwitch() {
    selectionClick();
  }

  /// 长按反馈 - 专门为长按操作设计的反馈
  static void longPress() {
    mediumImpact();
  }

  /// 滑动反馈 - 专门为滑动操作设计的反馈
  static void swipe() {
    lightImpact();
  }

  /// 自定义震动（仅Android）
  /// [duration] 震动持续时间（毫秒）
  /// [amplitude] 震动强度（1-255）
  static void customVibrate({int duration = 50, int amplitude = 128}) {
    if (Platform.isAndroid) {
      // Android平台可以使用自定义震动参数
      // 注意：这里需要添加vibration插件才能使用自定义参数
      HapticFeedback.vibrate();
    } else {
      // iOS平台使用默认的轻触反馈
      lightImpact();
    }
  }
}
