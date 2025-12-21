import 'package:capcards/page/statistics/no_cards_page.dart';
import 'package:capcards/page/statistics/result_page.dart';
import 'package:capcards/page/statistics/test_stats.dart';
import 'package:capcards/repository/card/card_dto.dart';
import 'package:capcards/repository/card/card_repository.dart';
import 'package:capcards/repository/deck/deck_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

class TestPage extends StatefulWidget {
  final DeckDTO deckDTO;
  const TestPage({super.key, required this.deckDTO});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final FlipCardController controller = FlipCardController();
  late List<CardDTO> cards;
  String message = "default";
  bool isLoading = true;
  int currentCardIndex = 0;
  CardDTO currentCard = CardDTO.empty();
  TestStats stats = TestStats();
  bool startedTest = false;

  @override
  void initState() {
    super.initState();
    _loadShuffleCards();
  }

  Future<void> _loadShuffleCards() async {
    try {
      cards = await CardRepository.getByDeckId(widget.deckDTO.id);
      cards.shuffle();
    } catch (e) {
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
    startedTest = true;
    stats.correct();
    setState(() {
      cards.removeAt(currentCardIndex);
      currentCard = getNext();
    });
  }

  void wrong() {
    startedTest = true;
    stats.fail();

    final card = cards[currentCardIndex];
    cards.removeAt(currentCardIndex);
    cards.add(card);

    setState(() {
      currentCard = getNext();
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
          title: Text(widget.deckDTO.description),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (cards.isEmpty) {
      if (startedTest) {
        return ResultPage(stats);
      } else {
        return NoCardsPage(widget.deckDTO);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.deckDTO.description),
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
                  message =
                      "tentativas: ${stats.tries} erros: ${stats.wrongs} $action";
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
