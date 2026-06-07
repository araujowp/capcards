import 'package:capcards/repository/card/card_dto.dart';
import 'package:capcards/repository/card/card_repository.dart';
import 'package:capcards/service/card/my_card.dart';
import 'package:capcards/service/deck_service.dart';
import 'package:capcards/service/my_deck.dart';

class CardService {
  static Future<List<MyCard>> getAll() async {
    final List<CardDTO> cardDtos = await CardRepository.getAll();

    final List<MyDeck> decks = await DeckService.getAll();

    final Map<int, String> deckDescriptionMap = {
      for (final deck in decks) deck.id: deck.description,
    };

    final List<MyCard> myCards = cardDtos.map((dto) {
      return MyCard.fromDTO(
        dto,
        deckDescription: deckDescriptionMap[dto.deckId],
      );
    }).toList();

    return myCards;
  }

  static Future<List<MyCard>> getByDeckId(int deckId) async {
    final List<CardDTO> cardDtos = await CardRepository.getByDeckId(deckId);

    final MyDeck? deck = await DeckService.getById(deckId);

    return cardDtos.map((dto) {
      return MyCard.fromDTO(dto, deckDescription: deck?.description);
    }).toList();
  }

  static Future<void> update(MyCard updatedCard) async {
    await CardRepository.update(updatedCard.toDTO());
  }
}
