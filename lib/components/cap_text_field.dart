import 'package:flutter/material.dart';

class CapTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const CapTextField({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(label: Text(label)),
      ),
    );
  }
}
