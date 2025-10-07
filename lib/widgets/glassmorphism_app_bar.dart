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
import 'dart:ui';

class GlassmorphismAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final double blurRadius;
  final double opacity;
  final Color? backgroundColor;
  final double height;
  final bool automaticallyImplyLeading;

  const GlassmorphismAppBar({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.blurRadius = 20.0,
    this.opacity = 0.8,
    this.backgroundColor,
    this.height = kToolbarHeight,
    this.automaticallyImplyLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: height + MediaQuery.of(context).padding.top,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      backgroundColor?.withValues(alpha: 0.0) ??
                          Colors.transparent,
                      backgroundColor?.withValues(alpha: 0.3) ??
                          Colors.transparent,
                      backgroundColor?.withValues(alpha: 0.6) ??
                          Colors.transparent,
                      backgroundColor?.withValues(alpha: 0.8) ??
                          Colors.transparent,
                    ],
                    stops: const [0.0, 0.3, 0.7, 1.0],
                  ),
                ),
              ),
            ),
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: blurRadius,
                  sigmaY: blurRadius,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        backgroundColor?.withValues(alpha: opacity) ??
                        Colors.white.withValues(alpha: opacity),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white.withValues(alpha: 0.2),
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Container(
                      height: height,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          if (leading != null) leading!,
                          if (title != null) Expanded(child: title!),
                          if (actions != null) ...actions!,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class AnimatedGlassmorphismAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final double blurRadius;
  final double opacity;
  final Color? backgroundColor;
  final double height;
  final bool automaticallyImplyLeading;
  final Duration animationDuration;

  const AnimatedGlassmorphismAppBar({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.blurRadius = 20.0,
    this.opacity = 0.8,
    this.backgroundColor,
    this.height = kToolbarHeight,
    this.automaticallyImplyLeading = true,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  State<AnimatedGlassmorphismAppBar> createState() =>
      _AnimatedGlassmorphismAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _AnimatedGlassmorphismAppBarState
    extends State<AnimatedGlassmorphismAppBar>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: widget.height + MediaQuery.of(context).padding.top,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          widget.backgroundColor?.withValues(alpha: 0.0) ??
                              Colors.transparent,
                          widget.backgroundColor?.withValues(alpha: 0.3) ??
                              Colors.transparent,
                          widget.backgroundColor?.withValues(alpha: 0.6) ??
                              Colors.transparent,
                          widget.backgroundColor?.withValues(alpha: 0.8) ??
                              Colors.transparent,
                        ],
                        stops: const [0.0, 0.3, 0.7, 1.0],
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: widget.blurRadius,
                      sigmaY: widget.blurRadius,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            (widget.backgroundColor?.withValues(
                                      alpha: widget.opacity,
                                    ) ??
                                    Colors.white.withValues(
                                      alpha: widget.opacity,
                                    ))
                                .withValues(alpha: _animation.value),
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.white.withValues(
                              alpha: 0.2 * _animation.value,
                            ),
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: SafeArea(
                        bottom: false,
                        child: Container(
                          height: widget.height,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              if (widget.leading != null)
                                Opacity(
                                  opacity: _animation.value,
                                  child: widget.leading!,
                                ),
                              if (widget.title != null)
                                Expanded(
                                  child: Opacity(
                                    opacity: _animation.value,
                                    child: widget.title!,
                                  ),
                                ),
                              if (widget.actions != null)
                                ...widget.actions!.map(
                                  (action) => Opacity(
                                    opacity: _animation.value,
                                    child: action,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
