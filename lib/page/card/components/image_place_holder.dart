import 'package:flutter/material.dart';

class ImagePlaceHolder extends StatelessWidget {
  final String label;
  const ImagePlaceHolder(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_a_photo, size: 48, color: Colors.grey),
            const SizedBox(width: 24),
            Text(
              'Adicionar imagem - $label',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
