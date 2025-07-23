import 'package:capcards/repository/deck/deck_repository.dart';
import 'package:flutter/material.dart';

class NewDeckPage extends StatefulWidget {
  const NewDeckPage({super.key});

  @override
  State<NewDeckPage> createState() => _NewDeckPageState();
}

class _NewDeckPageState extends State<NewDeckPage> {
  final TextEditingController controllerName = TextEditingController();

  Future<int> add() async {
    int id = await DeckRepository.add(controllerName.text);
    return id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("new Deck"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextField(
              controller: controllerName,
              decoration: const InputDecoration(label: Text("new deck")),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                int newId = await add();
                if (mounted) {
                  Navigator.of(context).pop(newId);
                  controllerName.clear();
                }
              },
              child: const Text("Cadastrar"))
        ],
      ),
    );
  }
}
