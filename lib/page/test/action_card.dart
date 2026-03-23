import 'package:capcards/components/cap_icon.dart';
import 'package:capcards/components/glass_container.dart';
import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {
  final VoidCallback onCorrect;
  final VoidCallback onWrong;

  const ActionCard({super.key, required this.onCorrect, required this.onWrong});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildButton(
            label: "ACERTEI",
            icon: Icons.check,
            color: Colors.green,
            borderColor: Colors.green,
            onTap: onCorrect,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildButton(
            label: "ERREI",
            icon: Icons.close,
            color: Colors.red,
            borderColor: Colors.red,
            onTap: onWrong,
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    required String label,
    required IconData icon,
    required Color color,
    required Color borderColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        color: color,
        borderColor: borderColor,
        alpha: 0.5,
        height: 64,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CapIcon(size: 50, imageColor: color),
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
    );
  }
}
