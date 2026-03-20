import 'dart:ui';

import 'package:capcards/components/cap_icon.dart';
import 'package:capcards/components/glass_container.dart';
import 'package:flutter/material.dart';
import 'package:capcards/repository/card/card_dto.dart';

class CardItem extends StatelessWidget {
  final CardDTO card;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  const CardItem({
    super.key,
    required this.card,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: GlassContainer(
            child: Row(
              children: [
                const CapIcon(),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    card.frontDescription,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.white70,
                    size: 24,
                  ),
                  onPressed: onDelete,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: Colors.white70,
                    size: 24,
                  ),
                  onPressed: onUpdate,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
