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

class ScrollTriggeredAnimation extends StatefulWidget {
  final Widget child;
  final Duration animationDelay;
  final Duration slideDuration;
  final Duration fadeDuration;
  final Offset slideOffset;
  final Curve slideCurve;
  final Curve fadeCurve;

  const ScrollTriggeredAnimation({
    super.key,
    required this.child,
    this.animationDelay = Duration.zero,
    this.slideDuration = const Duration(milliseconds: 800),
    this.fadeDuration = const Duration(milliseconds: 600),
    this.slideOffset = const Offset(0, 0.3),
    this.slideCurve = Curves.easeOutCubic,
    this.fadeCurve = Curves.easeInOut,
  });

  @override
  State<ScrollTriggeredAnimation> createState() =>
      _ScrollTriggeredAnimationState();
}

class _ScrollTriggeredAnimationState extends State<ScrollTriggeredAnimation>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;

  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  bool _hasPlayedAnimation = false;
  final GlobalKey _widgetKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      duration: widget.slideDuration,
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: widget.fadeDuration,
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(begin: widget.slideOffset, end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _slideController, curve: widget.slideCurve),
        );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: widget.fadeCurve),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkWidgetVisibility();
    });
  }

  void _checkWidgetVisibility() {
    if (!mounted || _hasPlayedAnimation) return;

    final RenderBox? renderBox =
        _widgetKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final screenHeight = MediaQuery.of(context).size.height;

    final widgetTop = position.dy;
    final widgetBottom = position.dy + size.height;
    final viewportTop = 0.0;
    final viewportBottom = screenHeight;

    if (widgetBottom > viewportTop &&
        widgetTop < viewportBottom &&
        !_hasPlayedAnimation) {
      _startAnimations();
      _hasPlayedAnimation = true;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkWidgetVisibility();
      });
    }
  }

  void _startAnimations() async {
    if (!mounted || _hasPlayedAnimation) return;

    _hasPlayedAnimation = true;

    await Future.delayed(widget.animationDelay);

    if (mounted) {
      _slideController.forward();
      _fadeController.forward();
    }
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _widgetKey,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(opacity: _fadeAnimation, child: widget.child),
      ),
    );
  }
}
