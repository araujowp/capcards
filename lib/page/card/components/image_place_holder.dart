import 'package:flutter/material.dart';

class ImagePlaceHolder extends StatelessWidget {
  final String label;
  const ImagePlaceHolder(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.add_a_photo, size: 48, color: Colors.grey),
        const SizedBox(height: 8),
        Text(
          'Adicionar imagem - $label',
          style: const TextStyle(color: Colors.grey),
        ),
        const Text(
          'Toque para tirar foto ou escolher',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
