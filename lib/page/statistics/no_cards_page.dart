import 'package:capcards/repository/deck/deck_dto.dart';
import 'package:flutter/material.dart';

class NoCardsPage extends StatelessWidget {
  final DeckDTO deckDto;

  const NoCardsPage(this.deckDto, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(deckDto.description),
      ),
      body: const Center(
        child: Text('Nenhum cartão encontrado'),
      ),
    );
  }
}
