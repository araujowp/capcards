import 'dart:ui'; // Para o BackdropFilter e ImageFilter
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
  double _holePosition = 0.0; // Posição inicial do buraco
  int _previousIndex = 0;

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
    _previousIndex = widget.currentIndex;
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
        // Sem animação necessária, pois begin e end são iguais
      }
      _previousIndex = newIndex;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Stack(
        children: [
          // Fundo com buraco (clipado)
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
                    child:
                        const SizedBox.expand(), // Conteúdo vazio, só o efeito
                  ),
                ),
              );
            },
          ),
          // Itens da nav (ícones e textos sobrepostos, sem fundo próprio no selecionado)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home,
                label: 'Início',
                index: 0,
              ),
              _buildNavItem(
                icon: Icons.info_outline,
                label: 'Sobre',
                index: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    bool isSelected = widget.currentIndex == index;
    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? Colors.transparent // Transparente no selecionado
                  : Colors.white.withOpacity(0.06),
              border: Border.all(
                color: Colors.white.withOpacity(isSelected ? 0.50 : 0.12),
                width: 0.8,
              ),
            ),
            child: TweenAnimationBuilder<Color?>(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              tween: ColorTween(
                end: isSelected ? Colors.white : Colors.white.withOpacity(0.9),
              ),
              builder: (context, color, child) {
                return Icon(
                  icon,
                  color: color,
                  size: 24,
                );
              },
            ),
          ),
          const SizedBox(height: 4),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.9),
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
            child: Text(label),
          ),
        ],
      ),
    );
  }
}
