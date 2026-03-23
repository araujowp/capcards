import 'package:capcards/page/cap_scaffold.dart';
import 'package:capcards/page/card/no_cards_page.dart';
import 'package:capcards/page/statistics/result_page.dart';
import 'package:capcards/page/statistics/test_stats.dart';
import 'package:capcards/page/test/action_card.dart';
import 'package:capcards/page/test/second_chance_widget.dart';
import 'package:capcards/page/test/swipable_card.dart';
import 'package:capcards/repository/card/card_dto.dart';
import 'package:capcards/repository/card/card_repository.dart';
import 'package:capcards/repository/review/review_repository.dart';
import 'package:capcards/service/Deck.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  final Deck deck;
  const TestPage({super.key, required this.deck});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late List<CardDTO> cards;
  List<CardDTO> secondCards = [];
  bool isLoading = true;
  int currentCardIndex = 0;
  CardDTO currentCard = CardDTO.empty();
  TestStats stats = TestStats();
  bool startedTest = false;
  bool secondChance = false;
  bool showOnlyErrosTime = false;

  @override
  void initState() {
    super.initState();
    _loadShuffleCards();
  }

  Future<void> _loadShuffleCards() async {
    try {
      cards = await CardRepository.getByDeckId(widget.deck.id);
      cards.sort((a, b) => a.revisionDate.compareTo(b.revisionDate));
      cards = cards.take(12).toList();
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
    if (cards.isEmpty && secondCards.isEmpty) return CardDTO.empty();

    if (cards.isEmpty) {
      cards = secondCards;
      secondCards = [];
      currentCardIndex = -1;
      secondChance = true;
      showOnlyErrosTime = true;
    }
    currentCardIndex++;
    if (currentCardIndex > cards.length - 1) currentCardIndex = 0;

    return cards[currentCardIndex];
  }

  Future<void> updateStatistic(bool correct) async {
    if (correct) {
      stats.correct();
    } else {
      stats.fail();
    }

    await ReviewRepository.record(cards[currentCardIndex].id, correct);
    cards[currentCardIndex].revisionDate = await ReviewRepository.nextDate(
      cards[currentCardIndex].id,
    );
    CardRepository.update(cards[currentCardIndex]);
  }

  void fixErros() {
    setState(() {
      showOnlyErrosTime = false;
    });
  }

  void correct() async {
    startedTest = true;

    if (!secondChance) {
      await updateStatistic(true);
    }

    cards.removeAt(currentCardIndex);
    currentCardIndex--;

    setState(() {
      currentCard = getNext();
    });
  }

  void wrong() async {
    startedTest = true;

    if (!secondChance) {
      await updateStatistic(false);
      secondCards.add(cards[currentCardIndex]);
      cards.removeAt(currentCardIndex);
      currentCardIndex--;
    }

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
          backgroundColor: Colors.transparent,
          title: Text(widget.deck.description),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (cards.isEmpty) {
      if (startedTest) {
        return ResultPage(stats);
      } else {
        return NoCardsPage(widget.deck);
      }
    }

    return CapScaffold(
      appBarText: widget.deck.description,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: showOnlyErrosTime
              ? SecondChanceWidget(onReviewPressed: fixErros)
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }
}
