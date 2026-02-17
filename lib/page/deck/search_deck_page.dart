import 'package:capcards/page/cap_scaffold.dart';
import 'package:capcards/page/deck/deck_card_item.dart';
import 'package:capcards/page/deck/deck_page.dart';
import 'package:capcards/page/test/test_page.dart';
import 'package:capcards/repository/deck/deck_dto.dart';
import 'package:capcards/repository/deck/deck_repository.dart';
import 'package:flutter/material.dart';

final RouteObserver<PageRoute<dynamic>> routeObserver =
    RouteObserver<PageRoute<dynamic>>();

class SearchDeckPage extends StatefulWidget {
  const SearchDeckPage({super.key});

  @override
  State<SearchDeckPage> createState() => _SearchDeckPageState();
}

class _SearchDeckPageState extends State<SearchDeckPage> with RouteAware {
  late Future<List<DeckDTO>> _futureDecks;
  bool editMode = false;

  @override
  void initState() {
    super.initState();
    _futureDecks = DeckRepository.getAll();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(
        this, ModalRoute.of(context)! as PageRoute<dynamic>);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    setState(() {
      _futureDecks = DeckRepository.getAll();
    });
  }

  saveDeck(BuildContext context, int id, String description) async {
    // ignore: unused_local_variable
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DeckPage(
                  id: id,
                  description: description,
                )));
  }

  delete(int deckId) {
    DeckRepository.delete(deckId);
    setState(() {
      _futureDecks = DeckRepository.getAll();
    });
  }

  edit() {
    setState(() {
      editMode = !editMode;
    });
  }

  test(DeckDTO deck) {
    if (!editMode) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => TestPage(deckDTO: deck)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CapScaffold(
      appBarText: "Listas",
      appBarActions: [
        IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () => saveDeck(context, 0, "")),
        IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () => edit())
      ],
      body: FutureBuilder<List<DeckDTO>>(
          future: _futureDecks,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                  child: Text('Erro ao carregar os cards: ${snapshot.error}'));
            }
            if (snapshot.hasData) {
              final decks = snapshot.data!;
              return ListView.builder(
                itemCount: decks.length,
                itemBuilder: (context, index) {
                  final deck = decks[index];
                  return DeckCardItem(
                    description: deck.description,
                    deckId: deck.id,
                    cardCount: 25,
                    editMode: editMode,
                    onDelete: () => delete(deck.id),
                    onEdit: () => saveDeck(context, deck.id, deck.description),
                    onTap: () => test(deck),
                  );
                },
              );
            } else {
              return const Center(child: Text('Nenhum deck encontrado.'));
            }
          }),
    );
  }
}
