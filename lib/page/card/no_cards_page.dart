import 'package:capcards/page/cap_scaffold.dart';
import 'package:capcards/page/card/search_card_page.dart';
import 'package:capcards/service/Deck.dart';
import 'package:flutter/material.dart';

class NoCardsPage extends StatelessWidget {
  final Deck deck;

  const NoCardsPage(this.deck, {super.key});

  editCards(BuildContext context, int deckId) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchCardPage(deckId: deckId)));
  }

  @override
  Widget build(BuildContext context) {
    return CapScaffold(
      appBarText: deck.description,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Nenhum cartão encontrado',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton.icon(
              onPressed: () => editCards(context, deck.id),
              icon: const Icon(Icons.add), // Ou Icons.edit se preferir
              label: const Text('Adicionar cartões'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
