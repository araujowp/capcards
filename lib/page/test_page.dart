import 'package:capcards/repository/card/card_dto.dart';
import 'package:capcards/repository/card/card_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

class TestPage extends StatefulWidget {
  final int deckId;
  final String deckDescription;
  const TestPage(
      {super.key, required this.deckId, required this.deckDescription});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final FlipCardController controller = FlipCardController();
  late List<CardDTO> cards;
  String message = "default";
  bool isLoading = true;
  int errorCount = 0;
  int currentCardIndex = 0;
  CardDTO currentCard = CardDTO.empty();
  int tries = 0;

  @override
  void initState() {
    super.initState();
    _loadShuffleCards();
  }

  Future<void> _loadShuffleCards() async {
    try {
      cards = await CardRepository.getByDeckId(widget.deckId);
      cards.shuffle();
    } catch (e) {
      print('Erro ao carregar cards: $e');
      cards = [];
    }
    setState(() {
      isLoading = false;
      currentCard = cards.isNotEmpty ? cards[0] : CardDTO.empty();
    });
  }

  CardDTO getNext() {
    if (cards.isEmpty) return CardDTO.empty();

    if (cards.length >= currentCardIndex - 1) {
      return cards[0];
    } else {
      currentCardIndex++;
    }

    return cards[currentCardIndex];
  }

  void correct() {
    print("passou no correct ");
    setState(() {
      cards.removeAt(currentCardIndex);
      currentCard = getNext();
      print(" ---- acertou -----  ${currentCard.id}");
    });
  }

  void wrong() {
    errorCount++;

    final card = cards[currentCardIndex];
    cards.removeAt(currentCardIndex);
    cards.add(card);

    setState(() {
      currentCard = getNext();
      print(" ---- errou -----  ${currentCard.id}");
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardWidth = size.width;
    final cardHeight = size.height - 250;

    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.deckDescription),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (cards.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Página de Teste"),
        ),
        body: const Center(child: Text('Nenhum cartão encontrado')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.deckDescription),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            GestureDetector(
              onVerticalDragEnd: (vDrag) {
                String action = "";
                if (vDrag.primaryVelocity! < 0) {
                  correct();
                  action = "cima";
                } else if (vDrag.primaryVelocity! > 0) {
                  action = "baixo";
                  wrong();
                }

                if (vDrag.primaryVelocity != null) {
                  tries++;
                  message = "tentativas: $tries erros: $errorCount $action";
                }
              },
              child: FlipCard(
                rotateSide: RotateSide.left,
                onTapFlipping: true,
                axis: FlipAxis.vertical,
                controller: controller,
                frontWidget: Container(
                  height: cardHeight,
                  width: cardWidth,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      currentCard.frontDescription,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                backWidget: Container(
                  height: cardHeight,
                  width: cardWidth,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      currentCard.backDescription,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Text(message),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.flipcard();
              },
              child: const Text('Virar Programaticamente'),
            ),
          ],
        ),
      ),
    );
  }
}
