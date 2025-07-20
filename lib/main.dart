import 'package:capcards/repository/card_dto.dart';
import 'package:capcards/repository/card_repository.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: SafeArea(child: Text('no futuro teremos um menu')),
      ),
      appBar: AppBar(
        title: const Text("baralhos"),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: () {}),
          IconButton(icon: const Icon(Icons.edit), onPressed: () {})
        ],
      ),
      body: FutureBuilder<List<CardDTO>>(
          future: CardRepositoy.getList(1),
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
