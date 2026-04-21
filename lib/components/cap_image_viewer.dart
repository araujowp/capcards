import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:capcards/page/card/components/image_place_holder.dart';

class CapImageViewer extends StatelessWidget {
  final String? imageBase64;
  final String label;
  final double? height;
  final double? width;
  final BoxFit fit;
  final VoidCallback? onTap;

  const CapImageViewer({
    super.key,
    required this.imageBase64,
    required this.label,
    this.height = 200,
    this.width = double.infinity,
    this.fit = BoxFit.cover,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = imageBase64 != null && imageBase64!.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: hasImage
              ? Image.memory(
                  base64Decode(imageBase64!),
                  fit: fit,
                  errorBuilder: (context, error, stackTrace) =>
                      ImagePlaceHolder(label),
                )
              : ImagePlaceHolder(label),
        ),
      ),
    );
  }
}
