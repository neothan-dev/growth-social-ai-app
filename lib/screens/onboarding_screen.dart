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
import '../widgets/preload_video_background.dart';
import '../localization/app_localizations.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onStart;
  const OnboardingScreen({super.key, required this.onStart});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PreloadVideoBackground(
        videoPath: 'assets/videos/onboarding_background.mp4',
        overlayColor: Colors.black.withValues(alpha: 0.3),
        fadeInDuration: const Duration(milliseconds: 600),
        preloadTimeout: const Duration(seconds: 3),
        enablePreload: true,
        child: SafeArea(
          child: Column(
            children: [
              _buildTopSection(),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 60),

                      _buildSloganSection(),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    _buildActionButtons(),

                    const SizedBox(height: 20),

                    _buildSocialLoginSection(),

                    _buildBottomSection(),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: Row(
              children: [
                AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/app_icon.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(width: 12),

                Text(
                  "5b890fb7a6W6bvrM2SlU".tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Spacer(),

                IconButton(
                  onPressed: _showLanguageDialog,
                  icon: const Icon(
                    Icons.language,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSloganSection() {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              Text(
                "e9456363f4Bk8Z8JzvPS".tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                "47d437ca76wnMRVynuJc".tr,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButtons() {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/login_screen');
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1976D2),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "afc7352ab04XKh8gkSs0".tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.of(
                    context,
                  ).pushReplacementNamed('/register_screen');
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      "c4fb62202bAsqbeRRsRT".tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSocialLoginSection() {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              Text(
                "58ecb27e0bl4TN8MpltY".tr,
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialButton(Icons.facebook, 'f', _handleFacebookLogin),
                  const SizedBox(width: 20),
                  _buildSocialButton(
                    Icons.g_mobiledata,
                    'G',
                    _handleGoogleLogin,
                  ),
                  const SizedBox(width: 20),
                  _buildSocialButton(
                    Icons.camera_alt,
                    '',
                    _handleInstagramLogin,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSocialButton(IconData icon, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Center(
          child: text.isNotEmpty
              ? Text(
                  text,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Icon(icon, color: Colors.black87, size: 24),
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        "5578431407Mu4g0bsdZ5".tr,
        style: TextStyle(color: Colors.white70, fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }

  void _handleFacebookLogin() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("7cf7e9bcabBxtvc7KmO3".tr)));
  }

  void _handleGoogleLogin() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("09d0b5ee8bOhsYuIuRUg".tr)));
  }

  void _handleInstagramLogin() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("1b56ed463d2vDvmiIZ4B".tr)));
  }

  void _showLanguageDialog() {
    final supportedLanguages = AppLocalizations.getSupportedLanguages();
    final currentLanguage = AppLocalizations.currentLanguage;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.language, color: Colors.blue),
            const SizedBox(width: 8),
            Text("b054335218Hh2z6Jblk3".tr),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: supportedLanguages.length,
            itemBuilder: (context, index) {
              final language = supportedLanguages[index];
              final isSelected = language['code'] == currentLanguage;

              return ListTile(
                leading: Text(
                  _getLanguageFlag(language['code']!),
                  style: const TextStyle(fontSize: 24),
                ),
                title: Text(
                  language['name']!,
                  style: TextStyle(
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isSelected ? Colors.blue : Colors.black87,
                  ),
                ),
                subtitle: Text(_getLanguageDescription(language['code']!)),
                trailing: isSelected
                    ? const Icon(Icons.check_circle, color: Colors.blue)
                    : null,
                onTap: () => _selectLanguage(language['code']!),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("2cd0f3be878snZI3zxqv".tr),
          ),
        ],
      ),
    );
  }

  Future<void> _selectLanguage(String languageCode) async {
    if (languageCode == AppLocalizations.currentLanguage) {
      Navigator.of(context).pop();
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("确认"),
        content: Text("确定要切换到${_getLanguageDescription(languageCode)}吗？"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("2cd0f3be878snZI3zxqv".tr),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text("fac2a67ad81CiN8sjg48".tr),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await AppLocalizations.setLanguage(languageCode);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Language changed successfully'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.of(context).pop();

        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    OnboardingScreen(onStart: widget.onStart),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          }
        });
      }
    }
  }

  String _getLanguageFlag(String languageCode) {
    switch (languageCode) {
      case 'en':
        return '🇺🇸';
      case 'zh':
        return '🇨🇳';
      case 'ja':
        return '🇯🇵';
      case 'ko':
        return '🇰🇷';
      case 'es':
        return '🇪🇸';
      case 'fr':
        return '🇫🇷';
      case 'de':
        return '🇩🇪';
      case 'it':
        return '🇮🇹';
      case 'pt':
        return '🇵🇹';
      case 'ru':
        return '🇷🇺';
      case 'ar':
        return '🇸🇦';
      default:
        return '🌐';
    }
  }

  String _getLanguageDescription(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English - Default language';
      case 'zh':
        return '中文 - 简体中文';
      case 'ja':
        return '日本語 - 日本語';
      case 'ko':
        return '한국어 - 한국어';
      case 'es':
        return 'Español - Spanish';
      case 'fr':
        return 'Français - French';
      case 'de':
        return 'Deutsch - German';
      case 'it':
        return 'Italiano - Italian';
      case 'pt':
        return 'Português - Portuguese';
      case 'ru':
        return 'Русский - Russian';
      case 'ar':
        return 'العربية - Arabic';
      default:
        return 'Unknown language';
    }
  }
}
