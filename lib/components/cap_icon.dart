import 'package:flutter/material.dart';

class CapIcon extends StatelessWidget {
  final double size;
  final Color imageColor;
  final double? opacity;

  const CapIcon({
    super.key,
    this.size = 60.0,
    this.imageColor = Colors.white,
    this.opacity = 0.12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(opacity ?? 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/images/capbranca.png',
          color: imageColor,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
