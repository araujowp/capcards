import 'dart:ui';

import 'package:flutter/material.dart'; // ← NÃO ESQUEÇA dessa importação!

class GlassContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final double? height;
  final double? width;
  final double borderRadius;
  final double blur;

  const GlassContainer({
    super.key,
    required this.child,
    this.color = const Color(
      0x33000000,
    ), // preto com ~20% de transparência (padrão perfeito)
    this.height,
    this.width,
    this.borderRadius = 16,
    this.blur = 12,
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
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.18),
              width: 1.1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
