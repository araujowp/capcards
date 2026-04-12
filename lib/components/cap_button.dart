import 'package:capcards/components/glass_container.dart';
import 'package:flutter/material.dart';

class CapButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? color;
  final Color? borderColor;
  final VoidCallback onTap;

  const CapButton({
    super.key,
    required this.label,
    required this.icon,
    this.color,
    this.borderColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: GlassContainer(
          color: color ?? Colors.black,
          borderColor: borderColor ?? Colors.white,
          alpha: 0.15,
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon, color: Colors.white, size: 30),
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
