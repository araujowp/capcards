import 'package:flutter/material.dart';

class CapText extends StatelessWidget {
  final String text;
  final Color color;

  const CapText(this.text, {super.key, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
      ),
    );
  }
}
