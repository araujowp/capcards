import 'package:flutter/material.dart';

class CapListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback action;
  const CapListTile(
      {super.key,
      required this.icon,
      required this.text,
      required this.action});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepOrange),
      title: Text(text, style: const TextStyle(color: Colors.white)),
      onTap: action,
    );
  }
}
