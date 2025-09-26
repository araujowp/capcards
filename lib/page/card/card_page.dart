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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Card"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextField(
              controller: textControllerFront,
              decoration: const InputDecoration(
                label: Text("Front of card"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextField(
              controller: textControllerBack,
              decoration: const InputDecoration(
                label: Text("Back of card"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
