import 'dart:ui';

import 'package:capcards/components/cap_icon.dart';
import 'package:capcards/components/glass_container.dart';
import 'package:flutter/material.dart';

class DeckCardItem extends StatelessWidget {
  final String description;
  final int deckId;
  final int cardCount;
  final int cardsReview;
  final bool editMode;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onTap;

  const DeckCardItem({
    super.key,
    required this.description,
    required this.deckId,
    required this.cardCount,
    required this.cardsReview,
    required this.editMode,
    required this.onDelete,
    required this.onEdit,
    required this.onTap,
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
            child: InkWell(
              onTap: editMode ? null : onTap,
              borderRadius: BorderRadius.circular(16),
              child: Row(
                children: [
                  const CapIcon(size: 60, imageColor: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            description.isEmpty ? "Nova lista" : description,
                            style: const TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        if (!editMode)
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'revisar ($cardsReview/$cardCount)',
                              style: TextStyle(
                                color: Colors.yellow.withValues(alpha: 0.9),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (editMode)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                          onPressed: onEdit,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
