import 'package:capcards/repository/card/card_dto.dart';
import 'package:capcards/repository/card/card_repository.dart';
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
  late Future<List<CardDTO>> cards;

  @override
  void initState() {
    super.initState();
    cards = CardRepository.getByDeckId(widget.deckId);
    cards = shuffle(cards);
  }

  Future<List<CardDTO>> shuffle(Future<List<CardDTO>> cardList) async {
    final list = await cardList;
    list.shuffle();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardWidth = size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Página de Teste"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<List<CardDTO>>(
          future: cards, // Usa o Future cards
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Exibe um loading enquanto o Future não está resolvido
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Trata erros
              return Center(child: Text('Erro: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              // Trata caso a lista esteja vazia
              return const Center(child: Text('Nenhum cartão encontrado'));
            }

            // Lista resolvida, pode acessar os dados
            final cardList = snapshot.data!;
            final firstCard = cardList[0];

            return Column(
              children: [
                FlipCard(
                  rotateSide: RotateSide.left,
                  onTapFlipping: true,
                  axis: FlipAxis.vertical,
                  controller: controller,
                  frontWidget: Container(
                    height: 200,
                    width: cardWidth,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        firstCard.frontDescription,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  backWidget: Container(
                    height: 200,
                    width: cardWidth,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        firstCard.backDescription,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    controller.flipcard(); // Vira o cartão via código
                  },
                  child: const Text('Virar Programaticamente'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
