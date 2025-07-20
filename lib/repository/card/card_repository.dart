import 'package:capcards/repository/card/card_dto.dart';

class CardRepositoy {
  static List<CardDTO> cards = [
    CardDTO(id: 1, description: "Cartão 1 deck 1", deckId: 1),
    CardDTO(id: 2, description: "Cartão 2 deck 1", deckId: 1),
    CardDTO(id: 3, description: "Cartão 3 deck 1", deckId: 1),
    CardDTO(id: 4, description: "Cartão 1 deck 2", deckId: 2),
    CardDTO(id: 5, description: "Cartão 1 deck 2", deckId: 2),
  ];
  static Future<List<CardDTO>> getList(int deckId) async {
    return cards.where((e) => e.deckId == deckId).toList();
  }
}
