import 'package:capcards/page/cap_scaffold.dart';
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

  myAction(String action) async {
    int id = 0;
    switch (action) {
      case "Save":
        id = await save();
        if (mounted && id > -1) {
          editCards(context, id);
        }
        break;
      case "Excluir":
        // ignore: unused_local_variable
        bool result = await delete();
        if (mounted) {
          Navigator.pop(context);
        }
        break;
    }
  }

  Future<int> save() async {
    int id;

    if (controllerName.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('O nome é obrigatório'),
          backgroundColor: Colors.red,
        ),
      );
      return -1;
    }

    if (widget.id == 0) {
      id = await DeckRepository.add(controllerName.text.trim());
    } else {
      id = await DeckRepository.update(widget.id, controllerName.text.trim());
    }
    return id;
  }

  Future<bool> delete() async {
    bool ret = await DeckRepository.delete(widget.id);
    return ret;
  }

  editCards(BuildContext context, int deckId) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchCardPage(deckId: deckId)));
  }

  @override
  Widget build(BuildContext context) {
    return CapScaffold(
      appBarText: widget.id == 0 ? "Nova lista" : "Edite lista",
      body: Container(
        color: Colors.black.withOpacity(0.1),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: controllerName,
                  decoration: const InputDecoration(label: Text("Nova lista")),
                ),
              ),
              ListTile(
                title: const Text(
                  "Salvar",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () => myAction("Save"),
                leading: const Icon(
                  Icons.save,
                  color: Colors.white,
                ),
              ),
              if (widget.id != 0) ...[
                ListTile(
                  title: const Text(
                    "Excluir",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () => myAction("Excluir"),
                  leading: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                ListTile(
                    title: const Text("Edite Cartões",
                        style: TextStyle(color: Colors.white)),
                    leading: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    onTap: () {
                      editCards(context, widget.id);
                    }),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
