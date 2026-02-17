// lib/widgets/deck_card_item.dart
import 'package:flutter/material.dart';

class DeckCardItem extends StatelessWidget {
  final String description;
  final int deckId;
  final int cardCount;
  final bool editMode;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onTap;

  const DeckCardItem({
    super.key,
    required this.description,
    required this.deckId,
    required this.cardCount,
    required this.editMode,
    required this.onDelete,
    required this.onEdit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.5),
      color: Colors.white.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white.withOpacity(0.20),
            width: 0.8,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          onTap: editMode ? null : onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Image.asset(
                      'assets/images/capbranca.png',
                      color: Colors.white,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
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
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      '($cardCount)',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                else
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete_outline,
                            color: Colors.white70, size: 26),
                        onPressed: onDelete,
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit_outlined,
                            color: Colors.white70, size: 26),
                        onPressed: onEdit,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
