import 'package:capcards/page/deck/deck_page.dart';
import 'package:capcards/repository/deck/deck_dto.dart';
import 'package:capcards/repository/deck/deck_repository.dart';
import 'package:flutter/material.dart';

class SearchDeckPage extends StatefulWidget {
  const SearchDeckPage({super.key});

  @override
  State<SearchDeckPage> createState() => _SearchDeckPageState();
}

class _SearchDeckPageState extends State<SearchDeckPage> {
  late Future<List<DeckDTO>> _futureDecks;
  bool editMode = false;

  @override
  void initState() {
    super.initState();
    _futureDecks = DeckRepository.getAll();
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

    setState(() {
      _futureDecks = DeckRepository.getAll();
    });
  }

  edit() {
    setState(() {
      editMode = !editMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: SafeArea(child: Text('no futuro teremos um menu')),
      ),
      appBar: AppBar(
        title: const Text("Decks"),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => saveDeck(context, 0, "")),
          IconButton(icon: const Icon(Icons.edit), onPressed: () => edit())
        ],
      ),
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
                  return ListTile(
                    title: Text(deck.description),
                    trailing: !editMode
                        ? null
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.delete,
                                      color: Color.fromARGB(255, 5, 85, 8))),
                              IconButton(
                                  icon: const Icon(Icons.arrow_right,
                                      color: Color.fromARGB(255, 5, 85, 8)),
                                  onPressed: () {
                                    saveDeck(
                                        context, deck.id, deck.description);
                                  })
                            ],
                          ),
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
