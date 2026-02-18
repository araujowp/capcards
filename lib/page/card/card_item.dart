import 'dart:ui';

import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String description;
  final VoidCallback onDelete;

  const CardItem({
    super.key,
    required this.description,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: 4, horizontal: 16), // Margem reduzida para visual slim
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
            16), // Arredondamento ajustado para combinar com a imagem
        child: BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: 12,
              sigmaY: 12), // Blur mais forte para efeito de vidro escuro
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 8), // Padding mínimo
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(
                  0.15), // Preenchimento mais escuro (ajuste se precisar de mais verde: Colors.green.withOpacity(0.25))
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity(
                    0.18), // Borda com mais destaque (opacidade e largura aumentadas)
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 48, // Tamanho ajustado
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(
                        0.12), // Container do ícone mais escuro para blending
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/capbranca.png',
                      color: Colors.white,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(width: 12), // Espaçamento reduzido
                Expanded(
                  child: Text(
                    description,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline,
                      color: Colors.white70,
                      size: 24), // Ícone de delete ajustado
                  onPressed: onDelete,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
