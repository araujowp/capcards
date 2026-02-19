import 'dart:math' as math;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class FlipCard extends StatefulWidget {
  final String frontText;
  final String backText;
  final double height;
  final double width;

  const FlipCard({
    super.key,
    required this.frontText,
    required this.backText,
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
    _animation =
        Tween<double>(begin: 0, end: math.pi).animate(_animationController);
  }

  @override
  void didUpdateWidget(covariant FlipCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.frontText != widget.frontText ||
        oldWidget.backText != widget.backText) {
      if (!_isFront) {
        _animationController.value = 0;
        _isFront = true;
      }
    }
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
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AutoSizeText(widget.frontText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color.fromARGB(255, 55, 85, 6),
                fontSize: 100,
              ),
              minFontSize: 16,
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
        ),
      ),
    );
  }

  Widget _buildBack() {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AutoSizeText(
            widget.backText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 100,
            ),
            minFontSize: 16,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
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
