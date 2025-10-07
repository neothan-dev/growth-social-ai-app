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
import 'package:provider/provider.dart';
import 'app_theme.dart';

class PageThemeManager {
  PageThemeManager._();

  static const Map<String, PageTheme> _pageThemes = {
    'agent': PageTheme(
      primaryColor: Color(0xFF2196F3),
      secondaryColor: Color(0xFF64B5F6),
      backgroundColor: Color(0xFFF5F5F5),
      navigationBarColor: Color(0xFFF5F5F5),
      navigationBarSelectedColor: Color(0xFF2196F3),
      navigationBarUnselectedColor: Color(0xFF757575),
    ),
    'society': PageTheme(
      primaryColor: Color(0xFFFF9800),
      secondaryColor: Color(0xFFFFB74D),
      backgroundColor: Color(0xFFFFF8E1),
      navigationBarColor: Color(0xFFFFF8E1),
      navigationBarSelectedColor: Color(0xFFFF9800),
      navigationBarUnselectedColor: Color(0xFF757575),
    ),
    'dashboard': PageTheme(
      primaryColor: Color(0xFF4CAF50),
      secondaryColor: Color(0xFF81C784),
      backgroundColor: Color(0xFFF1F8E9),
      navigationBarColor: Color(0xFFF1F8E9),
      navigationBarSelectedColor: Color(0xFF4CAF50),
      navigationBarUnselectedColor: Color(0xFF757575),
    ),
    'chat': PageTheme(
      primaryColor: Color(0xFF9C27B0),
      secondaryColor: Color(0xFFBA68C8),
      backgroundColor: Color(0xFFF3E5F5),
      navigationBarColor: Color(0xFFF3E5F5),
      navigationBarSelectedColor: Color(0xFF9C27B0),
      navigationBarUnselectedColor: Color(0xFF757575),
    ),
    'improvement': PageTheme(
      primaryColor: Color(0xFFFF5722),
      secondaryColor: Color(0xFFFF8A65),
      backgroundColor: Color(0xFFFFEBEE),
      navigationBarColor: Color(0xFFFFEBEE),
      navigationBarSelectedColor: Color(0xFFFF5722),
      navigationBarUnselectedColor: Color(0xFF757575),
    ),
  };

  static PageTheme getPageTheme(String pageName) {
    return _pageThemes[pageName] ?? _pageThemes['dashboard']!;
  }

  static PageTheme getPageThemeByIndex(int index) {
    switch (index) {
      case 0:
        return getPageTheme('dashboard');
      case 1:
        return getPageTheme('society');
      case 2:
        return getPageTheme('improvement');
      default:
        return getPageTheme('dashboard');
    }
  }

  static String getPageName(int index) {
    switch (index) {
      case 0:
        return 'dashboard';
      case 1:
        return 'society';
      case 2:
        return 'improvement';
      default:
        return 'dashboard';
    }
  }

  static List<Color> getGradientColors(String pageName) {
    final theme = getPageTheme(pageName);
    return [theme.primaryColor, theme.secondaryColor];
  }

  static List<Color> getGradientColorsByIndex(int index) {
    final pageName = getPageName(index);
    return getGradientColors(pageName);
  }

  static Color getNavigationBarColor(String pageName) {
    final theme = getPageTheme(pageName);
    return theme.backgroundColor;
  }

  static Color getNavigationBarColorByIndex(int index) {
    final pageName = getPageName(index);
    return getNavigationBarColor(pageName);
  }
}

class PageTheme {
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final Color navigationBarColor;
  final Color navigationBarSelectedColor;
  final Color navigationBarUnselectedColor;

  const PageTheme({
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.navigationBarColor,
    required this.navigationBarSelectedColor,
    required this.navigationBarUnselectedColor,
  });

  NavigationBarTheme get navigationBarTheme => NavigationBarTheme(
    backgroundColor: navigationBarColor,
    selectedColor: navigationBarSelectedColor,
    unselectedColor: navigationBarUnselectedColor,
  );

  List<Color> get gradientColors => [primaryColor, secondaryColor];

  Color get cardBackgroundColor => backgroundColor;

  Color get textColor => AppTheme.textPrimary;

  Color get secondaryTextColor => AppTheme.textSecondary;

  Color get navBarBackgroundColor => backgroundColor;
}

class NavigationBarTheme {
  final Color backgroundColor;
  final Color selectedColor;
  final Color unselectedColor;

  const NavigationBarTheme({
    required this.backgroundColor,
    required this.selectedColor,
    required this.unselectedColor,
  });
}

class PageThemeProvider extends ChangeNotifier {
  int _currentPageIndex = 0;
  PageTheme _currentTheme = PageThemeManager.getPageThemeByIndex(0);

  int get currentPageIndex => _currentPageIndex;
  PageTheme get currentTheme => _currentTheme;

  void switchPage(int index) {
    if (_currentPageIndex != index) {
      _currentPageIndex = index;
      _currentTheme = PageThemeManager.getPageThemeByIndex(index);
      notifyListeners();
    }
  }

  NavigationBarTheme get navigationBarTheme => _currentTheme.navigationBarTheme;

  List<Color> get gradientColors => _currentTheme.gradientColors;

  Color get primaryColor => _currentTheme.primaryColor;

  Color get secondaryColor => _currentTheme.secondaryColor;

  Color get navigationBarBackgroundColor => _currentTheme.navBarBackgroundColor;
}

extension PageThemeExtension on BuildContext {
  PageTheme get pageTheme {
    final provider = Provider.of<PageThemeProvider>(this, listen: false);
    return provider.currentTheme;
  }

  NavigationBarTheme get navigationBarTheme {
    final provider = Provider.of<PageThemeProvider>(this, listen: false);
    return provider.navigationBarTheme;
  }

  Color get pagePrimaryColor {
    final provider = Provider.of<PageThemeProvider>(this, listen: false);
    return provider.primaryColor;
  }

  List<Color> get pageGradientColors {
    final provider = Provider.of<PageThemeProvider>(this, listen: false);
    return provider.gradientColors;
  }

  Color get pageNavigationBarBackgroundColor {
    final provider = Provider.of<PageThemeProvider>(this, listen: false);
    return provider.navigationBarBackgroundColor;
  }
}
