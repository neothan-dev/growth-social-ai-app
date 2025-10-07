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
import '../services/auth_service.dart';
import '../widgets/blur_background_container.dart';
import '../utils/asset_manager.dart';
import '../localization/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();
  bool _loading = false;
  String? _error;
  final AuthService _authService = AuthService();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    _fullNameController.dispose();
    _ageController.dispose();
    _regionController.dispose();
    super.dispose();
  }

  void _register() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    if (_passwordController.text != _repeatPasswordController.text) {
      setState(() {
        _loading = false;
        _error = "58807745708rIBarCko8".tr;
      });
      return;
    }

    int? age = int.tryParse(_ageController.text.trim());
    if (age == null || age <= 0 || age > 120) {
      setState(() {
        _loading = false;
        _error = "27ad0cd667ClfHrEI2ZZ".tr;
      });
      return;
    }

    if (_usernameController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty ||
        _fullNameController.text.trim().isEmpty) {
      setState(() {
        _loading = false;
        _error = "ac026f5633aDBCIeVsHE".tr;
      });
      return;
    }

    try {
      final result = await _authService.register(
        _usernameController.text.trim(),
        _passwordController.text.trim(),
        _fullNameController.text.trim(),
        age,
        _regionController.text.trim(),
      );

      if (mounted) {
        if (result.status) {
          final username = _usernameController.text.trim();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("38c60717623saLEv97oR".tr),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 3),
            ),
          );

          Navigator.of(
            context,
          ).pushReplacementNamed('/login_screen', arguments: username);
        } else {
          setState(() {
            _error = result.reason;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = "8e7222fcc6dR0ISHuJkK".tr;
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 防止键盘推起背景
      body: GlassmorphismBackgroundContainer(
        backgroundName: AppBackgrounds.loginBackground,
        blurSigma: 2.0,
        glassOpacity: 0.2,
        overlayColor: Colors.black.withValues(alpha: 0.2),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                _buildBrandSection(),

                const SizedBox(height: 20),

                _buildFormSection(),

                const SizedBox(height: 10),

                _buildBottomLinks(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBrandSection() {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/app_icon.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "733dee6d88rs7DxzXUQ0".tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "1f47f42d980RZVVU1Woi".tr,
                style: TextStyle(color: Colors.white70, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFormSection() {
    return AnimatedBuilder(
      animation: _slideAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              height: 400, // 设置固定高度
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // 用户名输入框
                    _buildInputField(
                      controller: _usernameController,
                      hintText: "1a3f0617d6K2wCuhinc2".tr,
                      icon: Icons.person,
                      onChanged: (_) => setState(() {}),
                    ),

                    const SizedBox(height: 16),

                    // 密码输入框
                    _buildInputField(
                      controller: _passwordController,
                      hintText: "a621ab606dUGzBofSbIZ".tr,
                      icon: Icons.lock,
                      obscureText: true,
                      onChanged: (_) => setState(() {}),
                    ),

                    const SizedBox(height: 16),

                    // 重复密码输入框
                    _buildInputField(
                      controller: _repeatPasswordController,
                      hintText: "86ed4b29cbbNxzNVlBYE".tr,
                      icon: Icons.lock_outline,
                      obscureText: true,
                      onChanged: (_) => setState(() {}),
                    ),

                    const SizedBox(height: 16),

                    // 真实姓名输入框
                    _buildInputField(
                      controller: _fullNameController,
                      hintText: "c6330743dbfNE2IjA0VX".tr,
                      icon: Icons.badge,
                      onChanged: (_) => setState(() {}),
                    ),

                    const SizedBox(height: 16),

                    // 年龄输入框
                    _buildInputField(
                      controller: _ageController,
                      hintText: "9ee831fcb8o1RBHFjdNZ".tr,
                      icon: Icons.cake,
                      keyboardType: TextInputType.number,
                      onChanged: (_) => setState(() {}),
                    ),

                    const SizedBox(height: 16),

                    // 地区输入框
                    _buildInputField(
                      controller: _regionController,
                      hintText: "0b5daa9276oFVsOVNixF".tr,
                      icon: Icons.location_on,
                      onChanged: (_) => setState(() {}),
                    ),

                    const SizedBox(height: 24),

                    // 错误信息
                    if (_error != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.red.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          _error!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                    const SizedBox(height: 10),

                    // 注册按钮
                    GestureDetector(
                      onTap:
                          (!_loading &&
                              _usernameController.text.trim().isNotEmpty &&
                              _passwordController.text.trim().isNotEmpty &&
                              _repeatPasswordController.text
                                  .trim()
                                  .isNotEmpty &&
                              _fullNameController.text.trim().isNotEmpty &&
                              _ageController.text.trim().isNotEmpty &&
                              _regionController.text.trim().isNotEmpty)
                          ? _register
                          : null,
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color:
                              (!_loading &&
                                  _usernameController.text.trim().isNotEmpty &&
                                  _passwordController.text.trim().isNotEmpty &&
                                  _repeatPasswordController.text
                                      .trim()
                                      .isNotEmpty &&
                                  _fullNameController.text.trim().isNotEmpty &&
                                  _ageController.text.trim().isNotEmpty &&
                                  _regionController.text.trim().isNotEmpty)
                              ? const Color(0xFF1976D2)
                              : Colors.grey,
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
                          child: _loading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : Text(
                                  "5bddf41dd8uph3YyXxup".tr,
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
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    TextInputType? keyboardType,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.black87, fontSize: 16),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          prefixIcon: Icon(icon, color: Colors.grey),
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildBottomLinks() {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil('/login_screen', (route) => false);
                },
                child: Text(
                  "fa458119eeLb77ng1cTz".tr,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(height: 7),
              Text(
                "6cd10e2810FdHngUA1ea".tr,
                style: TextStyle(color: Colors.white70, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
