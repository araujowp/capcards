import 'package:capcards/page/new_deck_page.dart';
import 'package:capcards/repository/deck/deck_dto.dart';
import 'package:capcards/repository/deck/deck_repository.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'cap-cards',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.green),
        scaffoldBackgroundColor: const Color.fromARGB(110, 165, 245, 80),
        listTileTheme: const ListTileThemeData(tileColor: Colors.white),
        inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 2))),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<DeckDTO>> _futureDecks;

  @override
  void initState() {
    super.initState();
    _futureDecks = DeckRepository.getAll();
  }

  addDeck(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const NewDeckPage()));

    if (result != null) {
      setState(() {
        _futureDecks = DeckRepository.getAll();
      });
    }
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
              icon: const Icon(Icons.add), onPressed: () => addDeck(context)),
          IconButton(icon: const Icon(Icons.edit), onPressed: () {})
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
              final cards = snapshot.data!;
              return ListView.builder(
                itemCount: cards.length, // Quantidade de itens na lista
                itemBuilder: (context, index) {
                  final card = cards[index];
                  return ListTile(
                    title: Text(card.description),
                  ); // Widget para exibir cada card
                },
              );
            } else {
              return const Center(child: Text('Nenhum card encontrado.'));
            }
          }),
    );
  }
}
