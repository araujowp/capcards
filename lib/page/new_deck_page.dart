import 'package:capcards/repository/deck/deck_repository.dart';
import 'package:flutter/material.dart';

class NewDeckPage extends StatefulWidget {
  final int id;
  final String description;
  const NewDeckPage({super.key, required this.id, required this.description});

  @override
  State<NewDeckPage> createState() => _NewDeckPageState();
}

class _NewDeckPageState extends State<NewDeckPage> {
  late TextEditingController controllerName;

  @override
  void initState() {
    super.initState();
    controllerName = TextEditingController(text: widget.description);
  }

  @override
  void dispose() {
    controllerName.dispose();
    super.dispose();
  }

  Future<int> save() async {
    int id;
    if (widget.id == 0) {
      id = await DeckRepository.add(controllerName.text);
    } else {
      id = await DeckRepository.update(widget.id, controllerName.text);
    }
    return id;
  }

  Future<bool> delete() async {
    bool ret = await DeckRepository.delete(widget.id);
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id == 0 ? "new Deck" : "Edit deck"),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    int newId = await save();
                    if (mounted) {
                      Navigator.of(context).pop(newId);
                      controllerName.clear();
                    }
                  },
                  child: const Text("Salvar")),
              ElevatedButton(
                  onPressed: () async {
                    await delete();
                    if (mounted) {
                      Navigator.of(context).pop(widget.id);
                      controllerName.clear();
                    }
                  },
                  child: const Text("Excluir"))
            ],
          )
        ],
      ),
    );
  }
}
