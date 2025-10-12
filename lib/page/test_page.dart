import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

class TestPage extends StatefulWidget {
  final int deckId;
  const TestPage({super.key, required this.deckId});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final FlipCardController controller = FlipCardController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardWidh = size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("pagina de teste"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            FlipCard(
              rotateSide:
                  RotateSide.left, // Lado de rotação (top, bottom, left, right)
              onTapFlipping: true, // Ativa flip ao tocar (padrão: true)
              axis: FlipAxis.vertical, // Eixo: horizontal ou vertical
              controller: controller, // Opcional: para controle programático
              frontWidget: Container(
                height: 200,
                width: cardWidh,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'frente do cartão',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              backWidget: Container(
                height: 200,
                width: cardWidh,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'traseira do cartao!)',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Botão para flip programático
            ElevatedButton(
              onPressed: () {
                controller.flipcard(); // Vira o cartão via código
              },
              child: Text('Virar Programaticamente'),
            ),
          ],
        ),
      ),
    );
  }
}
