import 'package:capcards/components/glass_container.dart';
import 'package:flutter/material.dart';

class CapButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color? color;
  final Color? borderColor;
  final VoidCallback onTap;

  const CapButton({
    super.key,
    required this.label,
    required this.icon,
    this.color,
    this.borderColor,
    required this.onTap,
  });

  @override
  State<CapButton> createState() => _CapButtonState();
}

class _CapButtonState extends State<CapButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.92,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown() {
    _controller.forward();
  }

  void _onTapUp() {
    _controller.reverse();
  }

  void _onTap() async {
    // Pequeno delay para a animação ser sentida
    await Future.delayed(const Duration(milliseconds: 80));
    widget.onTap();
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _onTapDown(),
      onTapUp: (_) => _onTapUp(),
      onTapCancel: () => _controller.reverse(),
      onTap: _onTap,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: GlassContainer(
            color: widget.color ?? Colors.black,
            borderColor: widget.borderColor ?? Colors.white,
            alpha: 0.15,
            height: 55,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(widget.icon, color: Colors.white, size: 30),
                const SizedBox(width: 10),
                Text(
                  widget.label,
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
        ),
      ),
    );
  }
}
