import 'package:capcards/repository/card/card_repository.dart';
import 'package:capcards/repository/deck/deck_repository.dart';
import 'package:capcards/service/Deck.dart';

class DeckService {
  static Future<List<Deck>> getAll() async {
    final deckDTOs = await DeckRepository.getAll();

    final List<Deck> decks = [];

    var allCards = await CardRepository.getAll();
    int allCardsReview = allCards
        .where((card) => card.revisionDate.isBefore(DateTime.now().toUtc()))
        .length;

    decks.add(
      Deck(
        id: 0,
        description: "Todas as listas",
        countCards: allCards.length,
        cardsReview: allCardsReview,
      ),
    );
    for (final dto in deckDTOs) {
      var cards = await CardRepository.getByDeckId(dto.id);
      final count = cards.length;
      int cardsReview = cards
          .where((card) => card.revisionDate.isBefore(DateTime.now().toUtc()))
          .length;
      decks.add(
        Deck(
          id: dto.id,
          description: dto.description,
          countCards: count,
          cardsReview: cardsReview,
        ),
      );
    }
    return decks;
  }
}
