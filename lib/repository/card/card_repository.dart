import 'package:capcards/repository/card/card_dto.dart';
import 'package:capcards/repository/card/card_dto_new.dart';

class CardRepository {
  static List<CardDTO> cards = [
    CardDTO(id: 1, frontDescription: "King", backDescription: "Rei", deckId: 1),
    CardDTO(
        id: 2, frontDescription: "Queen", backDescription: "Rainha", deckId: 1),
    CardDTO(
        id: 3, frontDescription: "Rook", backDescription: "Torre", deckId: 1),
    CardDTO(
        id: 4, frontDescription: "Pawn", backDescription: "Peão", deckId: 1),
    CardDTO(
        id: 5, frontDescription: "Castle", backDescription: "Roque", deckId: 1),
    CardDTO(
        id: 6,
        frontDescription: "Cartão 3 deck 1",
        backDescription: "verso 3:1",
        deckId: 1),
    CardDTO(
        id: 7,
        frontDescription: "Cartão 1 deck 2",
        backDescription: "verso 1:2",
        deckId: 2),
    CardDTO(
        id: 8,
        frontDescription: "Cartão 2 deck 2",
        backDescription: "verso 2:2",
        deckId: 2),
  ];

  static Future<List<CardDTO>> getByDeckId(int deckId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return cards.where((e) => e.deckId == deckId).toList();
  }

  static void save(CardDTONew card) {
    int count = cards.length;
    CardDTO dto = CardDTO(
        id: count,
        frontDescription: card.frontDescription,
        backDescription: card.backDescription,
        deckId: card.deckId);
    cards.add(dto);
  }

  static Future<bool> delete(int id) async {
    final index = cards.indexWhere((e) => e.id == id);

    if (index == -1) {
      throw Exception(" id $id not found!");
    }
    cards.removeAt(index);

    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }
}
