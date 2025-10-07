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

class CircularImageButton extends StatefulWidget {
  final String imagePath;

  final double size;

  final VoidCallback? onTap;

  final VoidCallback? onPressed;

  final VoidCallback? onReleased;

  final Color? borderColor;

  final double borderWidth;

  final Color? shadowColor;

  final Offset shadowOffset;

  final double shadowBlurRadius;

  final double pressedScale;

  final Duration animationDuration;

  final IconData? fallbackIcon;

  final Color? fallbackIconColor;

  final double? fallbackIconSize;

  final bool enableRotation;

  final double rotationSpeed;

  final bool stopRotationOnPress;

  const CircularImageButton({
    super.key,
    required this.imagePath,
    this.size = 60.0,
    this.onTap,
    this.onPressed,
    this.onReleased,
    this.borderColor,
    this.borderWidth = 2.0,
    this.shadowColor,
    this.shadowOffset = const Offset(0, 2),
    this.shadowBlurRadius = 4.0,
    this.pressedScale = 0.95,
    this.animationDuration = const Duration(milliseconds: 150),
    this.fallbackIcon,
    this.fallbackIconColor,
    this.fallbackIconSize,
    this.enableRotation = false,
    this.rotationSpeed = 90.0,
    this.stopRotationOnPress = true,
  });

  @override
  State<CircularImageButton> createState() => _CircularImageButtonState();
}

class _CircularImageButtonState extends State<CircularImageButton>
    with TickerProviderStateMixin {
  late AnimationController _scaleAnimationController;
  late AnimationController _rotationAnimationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();

    _scaleAnimationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: widget.pressedScale)
        .animate(
          CurvedAnimation(
            parent: _scaleAnimationController,
            curve: Curves.easeInOut,
          ),
        );

    final rotationDuration = Duration(
      milliseconds: (360 / widget.rotationSpeed * 1000).round(),
    );
    _rotationAnimationController = AnimationController(
      duration: rotationDuration,
      vsync: this,
    );
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 360.0,
    ).animate(_rotationAnimationController);

    if (widget.enableRotation) {
      _rotationAnimationController.repeat();
    }
  }

  @override
  void dispose() {
    _scaleAnimationController.dispose();
    _rotationAnimationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
    _scaleAnimationController.forward();

    if (widget.enableRotation && widget.stopRotationOnPress) {
      _rotationAnimationController.stop();
    }

    widget.onPressed?.call();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    _scaleAnimationController.reverse();

    if (widget.enableRotation && widget.stopRotationOnPress) {
      _rotationAnimationController.repeat();
    }

    widget.onReleased?.call();
  }

  void _handleTapCancel() {
    setState(() {
      _isPressed = false;
    });
    _scaleAnimationController.reverse();

    if (widget.enableRotation && widget.stopRotationOnPress) {
      _rotationAnimationController.repeat();
    }

    widget.onReleased?.call();
  }

  void setRotationSpeed(double speed) {
    if (widget.enableRotation) {
      final duration = Duration(milliseconds: (360 / speed * 1000).round());
      _rotationAnimationController.duration = duration;
    }
  }

  void startRotation() {
    if (widget.enableRotation) {
      _rotationAnimationController.repeat();
    }
  }

  void stopRotation() {
    if (widget.enableRotation) {
      _rotationAnimationController.stop();
    }
  }

  void pauseRotation() {
    if (widget.enableRotation) {
      _rotationAnimationController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: Listenable.merge([_scaleAnimation, _rotationAnimation]),
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Transform.rotate(
              angle: widget.enableRotation
                  ? _rotationAnimation.value *
                        (3.14159 / 180)
                  : 0.0,
              child: Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: widget.borderColor != null
                      ? Border.all(
                          color: widget.borderColor!,
                          width: widget.borderWidth,
                        )
                      : null,
                  boxShadow: widget.shadowColor != null
                      ? [
                          BoxShadow(
                            color: widget.shadowColor!,
                            offset: widget.shadowOffset,
                            blurRadius: widget.shadowBlurRadius,
                          ),
                        ]
                      : null,
                ),
                child: ClipOval(child: _buildImage()),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImage() {
    return Image.asset(
      widget.imagePath,
      width: widget.size,
      height: widget.size,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Icon(
            widget.fallbackIcon ?? Icons.image,
            color: widget.fallbackIconColor ?? Colors.grey[600],
            size: widget.fallbackIconSize ?? widget.size * 0.4,
          ),
        );
      },
    );
  }
}

class BorderedCircularImageButton extends StatelessWidget {
  final String imagePath;

  final double size;

  final VoidCallback? onTap;

  final Color borderColor;

  final double borderWidth;

  final Color? backgroundColor;

  final EdgeInsets padding;

  final bool enableRotation;

  final double rotationSpeed;

  final bool stopRotationOnPress;

  const BorderedCircularImageButton({
    super.key,
    required this.imagePath,
    this.size = 60.0,
    this.onTap,
    this.borderColor = Colors.white,
    this.borderWidth = 2.0,
    this.backgroundColor,
    this.padding = EdgeInsets.zero,
    this.enableRotation = false,
    this.rotationSpeed = 90.0,
    this.stopRotationOnPress = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: CircularImageButton(
        imagePath: imagePath,
        size: size,
        onTap: onTap,
        borderColor: borderColor,
        borderWidth: borderWidth,
        shadowColor: Colors.black.withValues(alpha: 0.2),
        shadowOffset: const Offset(0, 2),
        shadowBlurRadius: 4.0,
        pressedScale: 0.95,
        enableRotation: enableRotation,
        rotationSpeed: rotationSpeed,
        stopRotationOnPress: stopRotationOnPress,
      ),
    );
  }
}

class GradientCircularImageButton extends StatelessWidget {
  final String imagePath;

  final double size;

  final VoidCallback? onTap;

  final List<Color> gradientColors;

  final GradientDirection gradientDirection;

  final double borderWidth;

  final double pressedScale;

  final bool enableRotation;

  final double rotationSpeed;

  final bool stopRotationOnPress;

  const GradientCircularImageButton({
    super.key,
    required this.imagePath,
    this.size = 60.0,
    this.onTap,
    this.gradientColors = const [Colors.blue, Colors.purple],
    this.gradientDirection = GradientDirection.radial,
    this.borderWidth = 2.0,
    this.pressedScale = 0.95,
    this.enableRotation = false,
    this.rotationSpeed = 90.0,
    this.stopRotationOnPress = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size + borderWidth * 2,
      height: size + borderWidth * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: _buildGradient(),
      ),
      child: Padding(
        padding: EdgeInsets.all(borderWidth),
        child: CircularImageButton(
          imagePath: imagePath,
          size: size,
          onTap: onTap,
          pressedScale: pressedScale,
          enableRotation: enableRotation,
          rotationSpeed: rotationSpeed,
          stopRotationOnPress: stopRotationOnPress,
        ),
      ),
    );
  }

  Gradient _buildGradient() {
    switch (gradientDirection) {
      case GradientDirection.radial:
        return RadialGradient(colors: gradientColors);
      case GradientDirection.linear:
        return LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case GradientDirection.sweep:
        return SweepGradient(colors: gradientColors);
    }
  }
}

enum GradientDirection { radial, linear, sweep }
