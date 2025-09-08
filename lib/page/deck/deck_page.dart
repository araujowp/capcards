import 'package:capcards/page/card/search_card_page.dart';
import 'package:capcards/repository/deck/deck_repository.dart';
import 'package:flutter/material.dart';

class DeckPage extends StatefulWidget {
  final int id;
  final String description;
  const DeckPage({super.key, required this.id, required this.description});

  @override
  State<DeckPage> createState() => _DeckPageState();
}

class _DeckPageState extends State<DeckPage> {
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

  editCards(BuildContext context, int deckId) async {
    print("------------------------ pressionando");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchCardPage(deckId: deckId)));
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
          ListTile(
            title: const Text("Salvar"),
            onTap: save,
          ),
          if (widget.id != 0)
            ListTile(
              title: const Text("Excluir"),
              onTap: delete,
            ),
          ListTile(
              title: const Text("Edit cards"),
              onTap: () {
                print(" ---------------- dentro do botão ");
                editCards(context, widget.id);
              }),
        ],
      ),
    );
  }
}
