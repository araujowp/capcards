import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {
  final VoidCallback onCorrect;
  final VoidCallback onWrong;

  const ActionCard({
    super.key,
    required this.onCorrect,
    required this.onWrong,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildButton(
            label: "ACERTEI",
            icon: Icons.check,
            gradient: const LinearGradient(
              colors: [
                Color(0xFF4CAF50),
                Color(0xFF2E7D32),
              ],
            ),
            onTap: onCorrect,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildButton(
            label: "ERREI",
            icon: Icons.close,
            gradient: const LinearGradient(
              colors: [
                Color(0xFFEF5350),
                Color(0xFFC62828),
              ],
            ),
            onTap: onWrong,
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    required String label,
    required IconData icon,
    required LinearGradient gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 26),
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
