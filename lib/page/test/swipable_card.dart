import 'package:capcards/page/test/flip_card.dart';
import 'package:capcards/repository/card/card_dto.dart';
import 'package:flutter/material.dart';

class SwipableCard extends StatelessWidget {
  final CardDTO card;
  final double height;
  final double width;
  final VoidCallback onCorrect;
  final VoidCallback onWrong;

  const SwipableCard({
    super.key,
    required this.card,
    required this.height,
    required this.width,
    required this.onCorrect,
    required this.onWrong,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(card.id),
      direction: DismissDirection.vertical,
      dismissThresholds: const {
        DismissDirection.up: 0.3,
        DismissDirection.down: 0.3,
      },
      movementDuration: const Duration(milliseconds: 300),
      onDismissed: (direction) {
        if (direction == DismissDirection.up) {
          onWrong();
        } else if (direction == DismissDirection.down) {
          onCorrect();
        }
      },
      background: Container(color: Colors.transparent),
      child: FlipCard(
        frontText: card.frontDescription,
        backText: card.backDescription,
        height: height,
        width: width,
      ),
    );
  }
}
