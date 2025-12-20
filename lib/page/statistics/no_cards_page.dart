import 'package:flutter/material.dart';

class NoCardsPage extends StatelessWidget {
  const NoCardsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Página de Teste"),
      ),
      body: const Center(
        child: Text('Nenhum cartão encontrado'),
      ),
    );
  }
}
