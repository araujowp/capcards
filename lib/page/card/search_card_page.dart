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
    _futureCards = CardRepositoy.getByDeckId(widget.deckId);
  }

  void addCard() async {
    // ignore: unused_local_variable
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CardPage(
                  deckId: widget.deckId,
                )));
    setState(() {
      _futureCards = CardRepositoy.getByDeckId(widget.deckId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit cards"),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: () => addCard())
        ],
      ),
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
                  return ListTile(title: Text(card.frontDescription));
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
