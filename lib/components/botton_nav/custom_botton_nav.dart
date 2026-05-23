import 'dart:ui';
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

  // GlobalKeys para pegar posição real dos itens
  final List<GlobalKey> _itemKeys = List.generate(3, (_) => GlobalKey());

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
    // Espera o layout ser renderizado
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? box =
          _itemKeys[newIndex].currentContext?.findRenderObject() as RenderBox?;

      if (box != null) {
        final Offset globalPosition = box.localToGlobal(Offset.zero);
        final double centerX = globalPosition.dx + (box.size.width / 2);

        setState(() {
          if (animate) {
            _holePositionAnimation =
                Tween<double>(begin: _holePosition, end: centerX).animate(
                  CurvedAnimation(
                    parent: _animationController,
                    curve: Curves.easeInOut,
                  ),
                );
            _animationController.forward(from: 0.0);
          } else {
            _holePosition = centerX;
            _holePositionAnimation = Tween<double>(begin: centerX, end: centerX)
                .animate(
                  CurvedAnimation(
                    parent: _animationController,
                    curve: Curves.easeInOut,
                  ),
                );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Stack(
        children: [
          // Camada com o furo
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
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: const SizedBox.expand(),
                  ),
                ),
              );
            },
          ),

          // Itens da navegação
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround, // pode voltar para spaceAround
            children: [
              BottomNavItem(
                key: _itemKeys[0],
                icon: Icons.home,
                label: 'Início',
                isSelected: widget.currentIndex == 0,
                onTap: () => widget.onTap(0),
              ),
              BottomNavItem(
                key: _itemKeys[1],
                icon: Icons.info_outline,
                label: 'Sobre',
                isSelected: widget.currentIndex == 1,
                onTap: () => widget.onTap(1),
              ),
              BottomNavItem(
                key: _itemKeys[2],
                icon: Icons.info_outline,
                label: 'Configurações',
                isSelected: widget.currentIndex == 2,
                onTap: () => widget.onTap(2),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
