import 'package:capcards/repository/card/card_dto.dart';
import 'package:capcards/repository/card/card_repository.dart';
import 'package:capcards/repository/deck/deck_dto.dart';
import 'package:capcards/repository/deck/deck_repository.dart';
import 'package:capcards/service/my_deck.dart';

class DeckService {
  static const int idAllDecks = 0;

  static Future<List<MyDeck>> getAll() async {
    final deckDTOs = await DeckRepository.getAll();

    final List<MyDeck> decks = [];

    var allCards = await CardRepository.getAll();
    int allCardsReview = allCards
        .where((card) => card.revisionDate.isBefore(DateTime.now().toUtc()))
        .length;

    decks.add(
      MyDeck(
        id: idAllDecks,
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
        MyDeck(
          id: dto.id,
          description: dto.description,
          countCards: count,
          cardsReview: cardsReview,
        ),
      );
    }
    return decks;
  }

  static Future<MyDeck?> getById(int id) async {
    if (id == idAllDecks) {
      final allCards = await CardRepository.getAll();

      final cardsReview = allCards
          .where((card) => card.revisionDate.isBefore(DateTime.now().toUtc()))
          .length;

      return MyDeck(
        id: idAllDecks,
        description: "Todas as listas",
        countCards: allCards.length,
        cardsReview: cardsReview,
      );
    }

    final dto = await DeckRepository.getById(id);
    if (dto == null) {
      return null;
    }

    final cards = await CardRepository.getByDeckId(dto.id);
    final count = cards.length;
    final cardsReview = cards
        .where((card) => card.revisionDate.isBefore(DateTime.now().toUtc()))
        .length;

    return MyDeck(
      id: dto.id,
      description: dto.description,
      countCards: count,
      cardsReview: cardsReview,
    );
  }

  static Future<bool> delete(int id) async {
    if (id != 0) {
      return await DeckRepository.delete(id);
    } else {
      List<DeckDTO> decks = await DeckRepository.getAll();

      Set<int> validDeckIds = decks.map((deck) => deck.id).toSet();

      List<CardDTO> cards = await CardRepository.getAll();

      for (var card in cards) {
        if (!validDeckIds.contains(card.deckId)) {
          bool deleted = await CardRepository.delete(card.id);
          if (!deleted) {
            return false;
          }
        }
      }
      return true;
    }
  }
}
