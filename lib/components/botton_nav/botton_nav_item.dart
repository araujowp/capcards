import 'package:flutter/material.dart';

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const BottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? Colors.transparent
                  : Colors.white.withOpacity(0.06),
              border: Border.all(
                color: Colors.white.withOpacity(isSelected ? 0.50 : 0.12),
                width: 0.8,
              ),
            ),
            child: TweenAnimationBuilder<Color?>(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              tween: ColorTween(
                end: isSelected ? Colors.white : Colors.white.withOpacity(0.9),
              ),
              builder: (context, color, child) {
                return Icon(
                  icon,
                  color: color,
                  size: 24,
                );
              },
            ),
          ),
          const SizedBox(height: 4),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.9),
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
            child: Text(label),
          ),
        ],
      ),
    );
  }
}
