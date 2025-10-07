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
import '../services/user_manager.dart';
import '../widgets/blur_background_container.dart';
import '../widgets/glassmorphism_app_bar.dart';
import '../utils/asset_manager.dart';
import '../localization/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          _buildPageContent(context),
          _buildGlassmorphismAppBar(context),
        ],
      ),
    );
  }

  Widget _buildPageContent(BuildContext context) {
    return GlassmorphismBackgroundContainer(
      backgroundName: AppBackgrounds.dashboardBackground,
      blurSigma: 1.5,
      glassOpacity: 0.2,
      overlayColor: Colors.black.withValues(alpha: 0.2),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top + kToolbarHeight),
          Expanded(
            child: Consumer<UserManager>(
              builder: (context, userManager, child) {
                return SafeArea(
                  top: false,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _buildUserInfoCard(context, userManager),
                      const SizedBox(height: 16),
                      _buildSettingsSection(context),
                      const SizedBox(height: 16),
                      _buildAccountSection(context, userManager),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassmorphismAppBar(BuildContext context) {
    return GlassmorphismAppBar(
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
      ),
      title: Text(
        "df3d58c7d8UBKisU29ZA".tr,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: Colors.lightGreen,
      blurRadius: 20.0,
      opacity: 0.001,
    );
  }

  Widget _buildUserInfoCard(BuildContext context, UserManager userManager) {
    final user = userManager.currentUser;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue[100],
            backgroundImage: user?.avatarUrl != null
                ? NetworkImage(user!.avatarUrl!)
                : null,
            child: user?.avatarUrl == null
                ? const Icon(Icons.person, size: 30, color: Colors.blue)
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.displayName ?? "c1f6583730yuAKcUFKMm".tr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user?.username != null
                      ? '@${user!.username}'
                      : "48144f96c1HmodogPTjz".tr,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          if (user != null)
            Builder(
              builder: (context) => IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/user_profile_screen'),
                icon: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "a1a42cd9b1UhkNVTPx8P".tr,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildSettingItem(
            icon: Icons.notifications,
            title: "247ca01ae2j22cWO92Z1".tr,
            subtitle: "d0a9d1733fMH27DlYc4j".tr,
            onTap: () {
            },
          ),
          _buildSettingItem(
            icon: Icons.language,
            title: "b0543352187asIz1wgSs".tr,
            subtitle: _getCurrentLanguageDisplay(),
            onTap: () {
              Navigator.pushNamed(context, '/language_settings_screen');
            },
          ),
          _buildSettingItem(
            icon: Icons.dark_mode,
            title: "ab98197175jstVi1s7hz".tr,
            subtitle: "217cfe7db1b9mXORhlND".tr,
            onTap: () {
            },
          ),
          _buildSettingItem(
            icon: Icons.support_agent,
            title: "42838a313emrgYQ1ZURL".tr,
            subtitle: "9afa6e311eTP16Vsps1a".tr,
            onTap: () {
              Navigator.pushNamed(context, '/agent_screen');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSection(BuildContext context, UserManager userManager) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "3c07271224ej0W3Ogm6D".tr,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          if (userManager.isLoggedIn) ...[
            _buildSettingItem(
              icon: Icons.person,
              title: "640803d897WJ6tHTmzqw".tr,
              subtitle: "8519461090DEHPVJ0zaK".tr,
              onTap: () => Navigator.pushNamed(context, '/user_profile_screen'),
            ),
            _buildSettingItem(
              icon: Icons.security,
              title: "f42a0719f1e3a5jYm2Vn".tr,
              subtitle: "0e389f4bf86vfrqJ5zaW".tr,
              onTap: () {
              },
            ),
            _buildSettingItem(
              icon: Icons.logout,
              title: "3ab8cc1593sNsslhbohe".tr,
              subtitle: "2cc8c23108Mx2Ou17x0f".tr,
              color: Colors.red,
              onTap: () => _showLogoutDialog(context, userManager),
            ),
          ] else ...[
            _buildSettingItem(
              icon: Icons.login,
              title: "84ff538db4ivDBt4zHb7".tr,
              subtitle: "da48274859sTKca5ld9j".tr,
              onTap: () => Navigator.pushNamed(context, '/login_screen'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.blue[600]),
      title: Text(
        title,
        style: TextStyle(
          color: color ?? Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey[600], fontSize: 12),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Future<void> _showLogoutDialog(
    BuildContext context,
    UserManager userManager,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("ab942a2cacmHxZ5iCNFj".tr),
        content: Text("26407a0143GLYNztDnpg".tr),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text("2cd0f3be878snZI3zxqv".tr),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text("fac2a67ad81CiN8sjg48".tr),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await userManager.logout();
      if (context.mounted) {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil('/onboarding_screen', (route) => false);
      }
    }
  }

  String _getCurrentLanguageDisplay() {
    final currentLanguage = AppLocalizations.currentLanguage;
    final supportedLanguages = AppLocalizations.getSupportedLanguages();

    final currentLanguageData = supportedLanguages.firstWhere(
      (lang) => lang['code'] == currentLanguage,
      orElse: () => {'name': 'Unknown', 'code': currentLanguage},
    );

    return currentLanguageData['name'] ?? 'Unknown';
  }
}
