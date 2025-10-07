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
import '../models/user.dart';
import '../services/user_manager.dart';
import '../services/auth_service.dart';
import '../widgets/blur_background_container.dart';
import '../widgets/glassmorphism_app_bar.dart';
import '../utils/asset_manager.dart';
import '../localization/app_localizations.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  String? _error;

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
                if (userManager.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                final user = userManager.currentUser;
                if (user == null) {
                  return Center(
                    child: Text(
                      "983aa25b62f5il8sh0of".tr,
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProfileHeader(user),
                      const SizedBox(height: 24),
                      _buildUserInfoSection(user),
                      const SizedBox(height: 24),
                      _buildActionsSection(userManager),
                      if (_error != null) ...[
                        const SizedBox(height: 24),
                        _buildErrorWidget(),
                      ],
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
        "640803d897KmOMQUYCyB".tr,
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

  Widget _buildProfileHeader(User user) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[400]!, Colors.purple[400]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white.withValues(alpha: 0.2),
            foregroundImage: const AssetImage(
              'assets/images/avatar/avatar6.jpg',
            ),
            child: const Icon(Icons.person, size: 40, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.displayName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '@${user.username}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
                if (user.createdAt != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    "a2ae7de8b0BofXmKGzQI".tr +
                        ' ${_formatDate(user.createdAt!)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfoSection(User user) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "e8df058725TA6AU9wENm".tr,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildInfoRow("1a3f0617d6RsjXmQvvNf".tr, user.username),
          _buildInfoRow(
            "50b5b1d2abBgSKkcgGx8".tr,
            user.fullName ?? "2f5f1d6fbf0ppZ0EEe50".tr,
          ),
          _buildInfoRow(
            "73075237fdb58HBn0FWo".tr,
            user.email ?? "2f5f1d6fbfCCsphHhFuG".tr,
          ),
          _buildInfoRow("9ee831fcb8MoNY35lsZ1".tr, user.ageDisplay),
          _buildInfoRow("0b5daa9276DLv90egphR".tr, user.regionDisplay),
          if (user.lastLoginAt != null)
            _buildInfoRow(
              "abd3a20e9aZZHOyuj2JU".tr,
              _formatDate(user.lastLoginAt!),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionsSection(UserManager userManager) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "46161a6cd4IlJLiQRmHh".tr,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildActionButton(
            icon: Icons.edit,
            title: "a8f5ff1894CzgU60MGMO".tr,
            onTap: () => _editProfile(userManager),
          ),
          _buildActionButton(
            icon: Icons.lock,
            title: "08d0080624yf3FEiHiKD".tr,
            onTap: () => _changePassword(userManager),
          ),
          _buildActionButton(
            icon: Icons.settings,
            title: "57907a69fcsjFvCNEMhW".tr,
            onTap: () => _openPreferences(userManager),
          ),
          const Divider(height: 32),
          _buildActionButton(
            icon: Icons.logout,
            title: "3ab8cc1593ymhzeRryM0".tr,
            color: Colors.red,
            onTap: () => _logout(userManager),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String title,
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
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Row(
        children: [
          Icon(Icons.error, color: Colors.red[600], size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(_error!, style: TextStyle(color: Colors.red[700])),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  void _editProfile(UserManager userManager) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("5bda1b27eadLCIKUn9bt".tr)));
  }

  void _changePassword(UserManager userManager) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("e72b72e5catgi6OVFHra".tr)));
  }

  void _openPreferences(UserManager userManager) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("6e16f875a6ePn63qnaqg".tr)));
  }

  Future<void> _logout(UserManager userManager) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("ab942a2caciQxmEXgFhB".tr),
        content: Text("26407a01431cQgxTnXJe".tr),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text("2cd0f3be87affY0f4bCJ".tr),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text("fac2a67ad8YR6tY0kFpU".tr),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      try {
        if (userManager.authManager.authToken != null) {
          await _authService.logout(userManager.authManager.authToken!);
        }

        await userManager.logout();

        if (mounted) {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil('/onboarding_screen', (route) => false);
        }
      } catch (e) {
        setState(() {
          _error = "3f3a2cb3a7jpcUFQIYIO".tr + '$e';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
