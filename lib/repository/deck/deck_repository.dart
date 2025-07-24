import 'package:capcards/repository/deck/deck_dto.dart';

class DeckRepository {
  static List<DeckDTO> decks = [
    DeckDTO(id: 1, description: "meu primeiro deck"),
    DeckDTO(id: 2, description: "Segundo deck de exemplos"),
    DeckDTO(id: 3, description: "Outro deck de exemplos"),
  ];

  static Future<List<DeckDTO>> getAll() async {
    return decks;
  }

  static Future<int> add(String name) async {
    int maxId = decks.isEmpty
        ? 0
        : decks.map((deck) => deck.id).reduce((a, b) => a > b ? a : b);
    int newId = maxId + 1;
    DeckDTO deckDTO = DeckDTO(id: newId, description: name);
    await Future.delayed(const Duration(milliseconds: 500));
    decks.add(deckDTO);
    return newId;
  }

  static Future<int> update(int id, String description) async {
    int index = decks.indexWhere((e) => e.id == id);

    if (index == -1) {
      throw Exception("Deck $id not found !");
    }

    decks[index].description = description;
    await Future.delayed(const Duration(milliseconds: 500));
    return id;
  }

  static Future<bool> delete(int id) async {
    final index = decks.indexWhere((e) => e.id == id);

    if (index == -1) {
      throw Exception(" id $id not found!");
    }
    decks.removeAt(index);

    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }
}
