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
  CardDTO cardDTO =
      CardDTO(backDescription: "", frontDescription: "", id: 0, deckId: 0);

  @override
  void initState() {
    super.initState();
    _futureCards = CardRepository.getByDeckId(widget.deckId);
  }

  void addCard() async {
    cardDTO.deckId = widget.deckId;
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CardPage(
                  cardDTO: cardDTO,
                )));
    setState(() {
      _futureCards = CardRepository.getByDeckId(widget.deckId);
    });
  }

  delete(int cardId) {
    CardRepository.delete(cardId);
    setState(() {
      _futureCards = CardRepository.getByDeckId(widget.deckId);
    });
  }

  update(CardDTO cardDTO) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CardPage(
                  cardDTO: cardDTO,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return CapScaffold(
      appBarText: "Edite cartões",
      appBarActions: [
        IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () => addCard())
      ],
      body: FutureBuilder<List<CardDTO>>(
        future: _futureCards,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
                child: Text("Erro ao carregar dados ${snapshot.error}"));
          }

          if (snapshot.hasData) {
            final cards = snapshot.data!;
            return ListView.builder(
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  final card = cards[index];
                  cardDTO = card;
                  return CardItem(
                    description: card.frontDescription,
                    onDelete: () => delete(card.id),
                  );
                });
          } else {
            return const Center(
              child: Text("0 card"),
            );
          }
        },
      ),
    );
  }
}
