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
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/language_settings_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/social/social_hub_screen.dart';
import 'screens/improvement/improvement_screen.dart';
import 'screens/agent/agent_screen.dart';
import 'screens/chat/chat_screen.dart';
import 'screens/chat/voice_chat_screen.dart';
import 'screens/chat/friend_chat_screen.dart';
import 'screens/user_profile_screen.dart';
import 'screens/society/society_screen.dart';
import 'screens/social/hubs/chat_hub_screen.dart';
import 'screens/social/hubs/moments_hub_screen.dart';
import 'screens/social/hubs/video_share_hub_screen.dart';
import 'screens/social/hubs/treasure_chest_hub_screen.dart';
import 'screens/social/hubs/community_hub_screen.dart';
import 'screens/social/hubs/events_hub_screen.dart';
import 'screens/social/hubs/fitness_video_hub_screen.dart';
import 'screens/social/hubs/knowledge_base_hub_screen.dart';
import 'screens/social/hubs/expert_articles_hub_screen.dart';
import 'screens/social/hubs/achievements_hub_screen.dart';
import 'screens/social/hubs/exclusive_offers_hub_screen.dart';
import 'screens/dashboard/card_detail/health_summary_detail_screen.dart';
import 'screens/dashboard/card_detail/blood_pressure_detail_screen.dart';
import 'screens/dashboard/card_detail/blood_sugar_detail_screen.dart';
import 'screens/dashboard/card_detail/body_metrics_detail_screen.dart';
import 'screens/dashboard/card_detail/exercise_detail_screen.dart';
import 'screens/dashboard/card_detail/mood_detail_screen.dart';
import 'screens/dashboard/card_detail/water_intake_detail_screen.dart';
import 'screens/dashboard/card_detail/recipe_detail_screen.dart';
import 'screens/dashboard/card_detail/sleep_detail_screen.dart';
import 'screens/dashboard/card_detail/steps_detail_screen.dart';
import 'screens/dashboard/card_detail/weather_detail_screen.dart';
import 'screens/dashboard/card_detail/scroll_card_detail_screen.dart';
import 'screens/improvement/progress_detail_screen.dart';
import 'models/friend.dart';
import 'models/health_progress.dart';
import 'services/user_manager.dart';
import 'services/network_service.dart';
import 'widgets/custom_bottom_navigation_bar.dart';
import 'localization/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppLocalizations.initialize();

  final userManager = UserManager();
  await userManager.initialize();

  HTTPManager.setAuthManager(userManager.authManager);
  WebSocketManager.setAuthManager(userManager.authManager);

  runApp(HealthAIApp(userManager: userManager));
}

class HealthAIApp extends StatefulWidget {
  final UserManager userManager;
  const HealthAIApp({super.key, required this.userManager});

  @override
  State<HealthAIApp> createState() => _HealthAIAppState();
}

enum AppStage { splash, onboarding, login, main }

class _HealthAIAppState extends State<HealthAIApp> {
  AppStage _stage = AppStage.splash;
  Key _appKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _startSplash();
  }

  void _startSplash() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _stage = AppStage.onboarding;
    });
  }

  void _onOnboardingComplete() {
    setState(() {
      _stage = AppStage.login;
    });
  }

  void _onLoginSuccess() async {
    print('_onLoginSuccess被调用，当前阶段: $_stage');
    print('切换到主页面');

    final userManager = widget.userManager;
    final isFirstLogin = await userManager.isFirstLogin();
    print('isFirstLogin: $isFirstLogin');

    setState(() {
      _stage = AppStage.main;
      _appKey = UniqueKey();
    });

    print('setState完成，新阶段: $_stage');

    if (isFirstLogin) {
      await userManager.setPreference('should_show_voice_chat_guide', true);
      userManager.markFirstLoginCompleted();
    }
  }

  @override
  Widget build(BuildContext context) {
    print('MaterialApp build被调用，当前阶段: $_stage');

    Widget currentScreen;
    switch (_stage) {
      case AppStage.splash:
        currentScreen = const SplashScreen();
        break;
      case AppStage.onboarding:
        currentScreen = OnboardingScreen(onStart: _onOnboardingComplete);
        break;
      case AppStage.login:
        currentScreen = LoginScreen(
          onLoginSuccess: _onLoginSuccess,
          initialUsername: null,
        );
        break;
      case AppStage.main:
        currentScreen = const MainNavigation();
        break;
    }

    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => widget.userManager)],
      child: MaterialApp(
        key: _appKey,
        title: '5b890fb7a6ty8ZCgByTh'.tr,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: AppLocalizations.locale,
        home: currentScreen,
        debugShowCheckedModeBanner: false,
        routes: {
          // 基础页面路由
          '/splash_screen': (context) => const SplashScreen(),
          '/onboarding_screen': (context) =>
              OnboardingScreen(onStart: _onOnboardingComplete),
          '/login_screen': (context) {
            final args = ModalRoute.of(context)?.settings.arguments;
            return LoginScreen(
              onLoginSuccess: _onLoginSuccess,
              initialUsername: args is String ? args : null,
            );
          },
          '/register_screen': (context) => const RegisterScreen(),
          '/settings_screen': (context) => const SettingsScreen(),
          '/language_settings_screen': (context) =>
              const LanguageSettingsScreen(),
          '/user_profile_screen': (context) => const UserProfileScreen(),

          // 主要功能页面路由
          '/dashboard_screen': (context) => DashboardScreen(),
          '/social_hub_screen': (context) => SocialHubScreen(),
          '/society_screen': (context) => const SocietyScreen(),
          '/improvement_screen': (context) => ImprovementScreen(),
          '/agent_screen': (context) => AgentScreen(),
          '/chat_screen': (context) => ChatScreen(),
          '/voice_chat_screen': (context) => VoiceChatScreen(),
          '/friend_chat_screen': (context) {
            final args = ModalRoute.of(context)?.settings.arguments;
            return FriendChatScreen(friend: args as Friend);
          },

          // 社交中心子页面路由
          '/chat_hub_screen': (context) => const ChatHubScreen(),
          '/moments_hub_screen': (context) => const MomentsHubScreen(),
          '/video_share_hub_screen': (context) => const VideoShareHubScreen(),
          '/treasure_chest_hub_screen': (context) =>
              const TreasureChestHubScreen(),
          '/community_hub_screen': (context) => const CommunityHubScreen(),
          '/events_hub_screen': (context) => const EventsHubScreen(),
          '/fitness_video_hub_screen': (context) =>
              const FitnessVideoHubScreen(),
          '/knowledge_base_hub_screen': (context) =>
              const KnowledgeBaseHubScreen(),
          '/expert_articles_hub_screen': (context) =>
              const ExpertArticlesHubScreen(),
          '/achievements_hub_screen': (context) =>
              const AchievementsHubScreen(),
          '/exclusive_offers_hub_screen': (context) =>
              const ExclusiveOffersHubScreen(),

          // 仪表板详情页面路由
          '/health_summary_detail_screen': (context) =>
              const HealthSummaryDetailScreen(),
          '/blood_pressure_detail_screen': (context) =>
              const BloodPressureDetailScreen(),
          '/blood_sugar_detail_screen': (context) =>
              const BloodSugarDetailScreen(),
          '/body_metrics_detail_screen': (context) =>
              const BodyMetricsDetailScreen(),
          '/exercise_detail_screen': (context) => const ExerciseDetailScreen(),
          '/mood_detail_screen': (context) => const MoodDetailScreen(),
          '/water_intake_detail_screen': (context) =>
              const WaterIntakeDetailScreen(),
          '/recipe_detail_screen': (context) => const RecipeDetailScreen(),
          '/sleep_detail_screen': (context) => const SleepDetailScreen(),
          '/steps_detail_screen': (context) => const StepsDetailScreen(),
          '/weather_detail_screen': (context) => const WeatherDetailScreen(),
          '/scroll_card_detail_screen': (context) {
            final args =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>?;
            return ScrollCardDetailScreen(
              title: args?['title'] ?? '',
              subtitle: args?['subtitle'] ?? '',
              value: args?['value'] ?? '',
              unit: args?['unit'] ?? '',
              icon: args?['icon'] ?? Icons.info,
              color: args?['color'] ?? Colors.blue,
              gradient: args?['gradient'] ?? [Colors.blue, Colors.blueAccent],
              trend: args?['trend'] ?? 0.0,
              trendData: args?['trendData'] ?? [],
            );
          },

          // 改进相关页面路由
          '/progress_detail_screen': (context) {
            final args = ModalRoute.of(context)?.settings.arguments;
            return ProgressDetailScreen(progress: args as HealthProgress);
          },
        },
      ),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    DashboardScreen(),
    SocialHubScreen(),
    ImprovementScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVoiceChatGuide();
    });
  }

  void _checkVoiceChatGuide() async {
    final userManager = Provider.of<UserManager>(context, listen: false);
    final shouldShowGuide = userManager.getPreference<bool>(
      'should_show_voice_chat_guide',
      defaultValue: false,
    );

    if (shouldShowGuide == true) {
      await userManager.setPreference('should_show_voice_chat_guide', false);

      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        Navigator.of(context).pushNamed('/voice_chat_screen');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: AnimatedGlassmorphismBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        useDynamicTheme: true,
        blurRadius: 10000000000000000000000.0,
        opacity: 0,
      ),
    );
  }
}
