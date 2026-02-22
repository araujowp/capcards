import 'dart:ui'; // Para o BackdropFilter e ImageFilter
import 'package:capcards/components/botton_nav/botton_nav_item.dart';
import 'package:capcards/components/botton_nav/hole_clipper.dart';
import 'package:flutter/material.dart';

class CustomBottomNav extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _holePositionAnimation;
  double _holePosition = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _holePositionAnimation = Tween<double>(begin: 0.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _holePosition = _holePositionAnimation.value;
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateHolePosition(widget.currentIndex, animate: false);
    });
  }

  @override
  void didUpdateWidget(covariant CustomBottomNav oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _updateHolePosition(widget.currentIndex, animate: true);
    }
  }

  void _updateHolePosition(int newIndex, {required bool animate}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth / 2; // Para 2 itens
    final newPosition = itemWidth * newIndex + itemWidth / 2;

    setState(() {
      if (animate) {
        _holePositionAnimation = Tween<double>(
          begin: _holePosition,
          end: newPosition,
        ).animate(
          CurvedAnimation(
              parent: _animationController, curve: Curves.easeInOut),
        );
        _animationController.forward(from: 0.0);
      } else {
        _holePosition = newPosition;
        _holePositionAnimation = Tween<double>(
          begin: newPosition,
          end: newPosition,
        ).animate(
          CurvedAnimation(
              parent: _animationController, curve: Curves.easeInOut),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.removeStatusListener((status) {});
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return ClipPath(
                clipper: HoleClipper(
                  holeCenterX: _holePositionAnimation.value,
                  holeCenterY: 30,
                  holeWidth: 60,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: const SizedBox.expand(),
                  ),
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomNavItem(
                icon: Icons.home,
                label: 'Início',
                isSelected: widget.currentIndex == 0,
                onTap: () => widget.onTap(0),
              ),
              BottomNavItem(
                icon: Icons.info_outline,
                label: 'Sobre',
                isSelected: widget.currentIndex == 1,
                onTap: () => widget.onTap(1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
