import 'package:capcards/page/card/no_cards_page.dart';
import 'package:capcards/page/statistics/result_page.dart';
import 'package:capcards/page/statistics/test_stats.dart';
import 'package:capcards/page/test/action_card.dart';
import 'package:capcards/page/test/flip_card.dart';
import 'package:capcards/page/test/swipable_card.dart';
import 'package:capcards/repository/card/card_dto.dart';
import 'package:capcards/repository/card/card_repository.dart';
import 'package:capcards/repository/deck/deck_dto.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  final DeckDTO deckDTO;
  const TestPage({super.key, required this.deckDTO});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late List<CardDTO> cards;
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
            SwipableCard(
              card: currentCard,
              height: cardHeight,
              width: cardWidth,
              onCorrect: correct,
              onWrong: wrong,
            ),
            const SizedBox(height: 20),
            ActionCard(onCorrect: correct, onWrong: wrong),
          ],
        ),
      ),
    );
  }
}
