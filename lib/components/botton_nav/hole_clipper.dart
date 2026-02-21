import 'package:flutter/material.dart';

class HoleClipper extends CustomClipper<Path> {
  final double holeCenterX;
  final double holeCenterY;
  final double holeWidth;

  HoleClipper({
    required this.holeCenterX,
    required this.holeCenterY,
    this.holeWidth = 60, // Default width (adjust as needed)
  });

  @override
  Path getClip(Size size) {
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height)); // Fundo inteiro

    final double circleRadius = holeWidth / 2;
    final double rectWidth = holeWidth;
    final double rectHeight = holeWidth / 2;

    final circleRect = Rect.fromCircle(
      center: Offset(holeCenterX, holeCenterY),
      radius: circleRadius,
    );
    final circlePath = Path()..addOval(circleRect);

    final rectTop = holeCenterY - circleRadius;
    final rect = Rect.fromLTWH(
      holeCenterX - rectWidth / 2,
      rectTop,
      rectWidth,
      rectHeight,
    );
    final rectPath = Path()..addRect(rect);

    final combinedHole =
        Path.combine(PathOperation.union, circlePath, rectPath);

    path.addPath(combinedHole, Offset.zero);

    path.fillType = PathFillType.evenOdd;

    return path;
  }

  @override
  bool shouldReclip(covariant HoleClipper oldClipper) {
    return oldClipper.holeCenterX != holeCenterX ||
        oldClipper.holeCenterY != holeCenterY ||
        oldClipper.holeWidth != holeWidth;
  }
}
