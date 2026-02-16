import 'dart:ui'; // Para o BackdropFilter (opcional)
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

class _CustomBottomNavState extends State<CustomBottomNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70, // Altura similar ao exemplo
      decoration: BoxDecoration(
        color: Colors.white
            .withOpacity(0.08), // Ajustado para combinar com o DeckCardItem
      ),
      child: ClipRect(
        // Para aplicar blur corretamente
        child: BackdropFilter(
          filter:
              ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Efeito glassy mantido
          child: Row(
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
              // Adicione mais se quiser (ex: como no exemplo com 3 itens)
              // _buildNavItem(
              //   icon: Icons.bar_chart,
              //   label: 'Estatísticas',
              //   index: 2,
              // ),
            ],
          ),
        ),
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
          Container(
            width:
                40, // Tamanho ajustado para ser compacto como o ícone da capivara
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle, // Mantém circular como desejado
              color: isSelected
                  ? Colors.white.withOpacity(
                      0.2) // Destaque sutil com opacidade maior, combinando com a paleta neutra do app
                  : Colors.white.withOpacity(
                      0.06), // Fundo semi-transparente como no DeckCar, // Fundo semi-transparente como no DeckCardItem para não selecionado; verde para selecionado
              border: Border.all(
                color: Colors.white.withOpacity(0.12),
                width: 0.8,
              ), // Borda sutil como no DeckCardItem
            ),
            child: Icon(
              icon,
              color: isSelected
                  ? Colors.white
                  : Colors.white.withOpacity(
                      0.9), // Branco como a capivara; opacidade leve para não selecionado
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.9),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
