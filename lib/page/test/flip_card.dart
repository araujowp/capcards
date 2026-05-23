import 'dart:math' as math;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:capcards/components/cap_image_viewer.dart';
import 'package:flutter/material.dart';

class FlipCard extends StatefulWidget {
  final String frontText;
  final String? frontImageBase64;
  final String backText;
  final String? backImageBase64;
  final double height;
  final double width;

  const FlipCard({
    super.key,
    required this.frontText,
    this.frontImageBase64,
    required this.backText,
    this.backImageBase64,
    required this.height,
    required this.width,
  });

  @override
  State<FlipCard> createState() => _CustomFlipCardState();
}

class _CustomFlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(
      begin: 0,
      end: math.pi,
    ).animate(_animationController);
  }

  @override
  void didUpdateWidget(covariant FlipCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _resetToFront();
  }

  void _resetToFront() {
    if (_animationController.isAnimating) {
      _animationController.stop();
    }
    _animationController.value = 0.0;
    _isFront = true;
  }

  void _flip() {
    if (_isFront) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    _isFront = !_isFront;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flip,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final isBackVisible = _animation.value > math.pi / 2;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(_animation.value),
            child: isBackVisible
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: _buildBack(),
                  )
                : _buildFront(),
          );
        },
      ),
    );
  }

  Widget _buildFront() {
    return _buildCardSide(
      text: widget.frontText,
      imageBase64: widget.frontImageBase64,
      backgroundColor: Colors.white.withValues(alpha: 0.4),
      textStyle: const TextStyle(
        color: Color.fromARGB(255, 55, 85, 6),
        fontSize: 100,
        height: 0.9,
      ),
    );
  }

  Widget _buildBack() {
    return _buildCardSide(
      text: widget.backText,
      imageBase64: widget.backImageBase64,
      backgroundColor: Colors.black.withValues(alpha: 0.4),
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 100,
        height: 0.9,
      ),
    );
  }

  Widget _buildCardSide({
    required String text,
    required String? imageBase64,
    required Color backgroundColor,
    required TextStyle textStyle,
  }) {
    final hasText = text.isNotEmpty;
    final hasImage = imageBase64 != null && imageBase64.isNotEmpty;

    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12), // padding reduzido
        child: Column(
          children: [
            // TEXTO
            if (hasText)
              Flexible(
                flex: 2, // mantendo como você testou
                child: Center(
                  child: AutoSizeText(
                    text,
                    textAlign: TextAlign.center,
                    style: textStyle,
                    minFontSize: 22,
                    maxLines: 3,
                    maxFontSize: 130,
                    overflow: TextOverflow.ellipsis,
                    stepGranularity: 1,
                  ),
                ),
              ),

            // Espaçamento mínimo entre texto e imagem
            if (hasText && hasImage) const SizedBox(height: 8), // bem menor
            // IMAGEM - Aproveita o máximo possível da tela
            if (hasImage)
              Expanded(
                flex: 8,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox.expand(
                      // ← Força ocupar todo espaço disponível
                      child: CapImageViewer(
                        imageBase64: imageBase64,
                        label: text,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
