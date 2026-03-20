import 'dart:ui';

import 'package:flutter/material.dart'; // ← NÃO ESQUEÇA dessa importação!

class GlassContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final double? height;
  final double? width;
  final double borderRadius;
  final double blur;
  final double alpha;

  const GlassContainer({
    super.key,
    required this.child,
    this.color = Colors.black,
    this.height,
    this.width,
    this.borderRadius = 16,
    this.blur = 12,
    this.alpha = 0.18,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: color.withValues(alpha: alpha),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: color.withValues(alpha: alpha),
              width: 1.0,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
