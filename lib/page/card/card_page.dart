import 'package:capcards/components/cap_list_tile.dart';
import 'package:capcards/page/cap_scaffold.dart';
import 'package:capcards/repository/card/card_dto_new.dart';
import 'package:capcards/repository/card/card_repository.dart';
import 'package:flutter/material.dart';

class CardPage extends StatefulWidget {
  final int deckId;
  const CardPage({super.key, required this.deckId});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  late TextEditingController textControllerFront;

  late TextEditingController textControllerBack;

  @override
  void initState() {
    super.initState();
    textControllerFront = TextEditingController();
    textControllerBack = TextEditingController();
  }

  @override
  void dispose() {
    textControllerFront.dispose();
    textControllerBack.dispose();
    super.dispose();
  }

  cancel() async {
    Navigator.pop(context);
  }

  save() async {
    if (textControllerFront.text.trim().isEmpty ||
        textControllerBack.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Frente e verso obrigatórios'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    CardDTONew card = CardDTONew(
        frontDescription: textControllerFront.text,
        backDescription: textControllerBack.text,
        deckId: widget.deckId);
    CardRepository.save(card);
    cancel();
  }

  @override
  Widget build(BuildContext context) {
    return CapScaffold(
      appBarText: "Edit Card",
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: textControllerFront,
                decoration: const InputDecoration(
                  label: Text("Frente"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: textControllerBack,
                decoration: const InputDecoration(
                  label: Text("Verso"),
                ),
              ),
            ),
            CapListTile(
              text: "Salvar",
              icon: Icons.save,
              action: save,
            ),
            CapListTile(
              text: "Cancelar",
              icon: Icons.cancel,
              action: cancel,
            ),
          ],
        ),
      ),
    );
  }
}
