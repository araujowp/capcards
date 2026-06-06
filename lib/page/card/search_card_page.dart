import 'package:capcards/page/cap_scaffold.dart';
import 'package:capcards/page/card/card_item.dart';
import 'package:capcards/page/card/card_page.dart';
import 'package:capcards/repository/card/card_dto.dart';
import 'package:capcards/repository/card/card_repository.dart';
import 'package:flutter/material.dart';

class SearchCardPage extends StatefulWidget {
  final int deckId;
  const SearchCardPage({super.key, required this.deckId});

  @override
  State<SearchCardPage> createState() => _SearchCardPageState();
}

class _SearchCardPageState extends State<SearchCardPage> {
  late Future<List<CardDTO>> _futureCards;

  @override
  void initState() {
    super.initState();
    _futureCards = CardRepository.getByDeckId(widget.deckId);
  }

  void addCard() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardPage(cardDTO: CardDTO.build(widget.deckId)),
      ),
    );
    updateList();
  }

  void goHome() {
    Navigator.of(
      context,
      rootNavigator: true,
    ).popUntil((route) => route.isFirst);
  }

  void delete(int cardId) {
    CardRepository.delete(cardId);
    updateList();
  }

  void update(CardDTO cardDTO) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CardPage(cardDTO: cardDTO)),
    );
    updateList();
  }

  void updateList() {
    setState(() {
      _futureCards = CardRepository.getByDeckId(widget.deckId);
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return CapScaffold(
      appBarText: "Edite cartões",
      extendBodyBehindAppBar: true, // ← Voltar para true
      resizeToAvoidBottomInset: true,

      appBarActions: [
        IconButton(
          icon: const Icon(Icons.home, color: Colors.white),
          onPressed: goHome,
        ),
        IconButton(
          icon: const Icon(Icons.add, color: Colors.white),
          onPressed: addCard,
        ),
      ],

      body: SafeArea(
        top: true,
        child: FutureBuilder<List<CardDTO>>(
          future: _futureCards,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Erro: ${snapshot.error}"));
            }

            final cards = snapshot.data ?? [];

            if (cards.isEmpty) {
              return const Center(child: Text("0 card"));
            }

            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
              itemCount: cards.length,
              itemBuilder: (context, index) {
                final card = cards[index];
                return CardItem(
                  card: card,
                  onDelete: () => delete(card.id),
                  onUpdate: () => update(card),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
