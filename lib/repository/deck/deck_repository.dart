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
    int id = decks.length;
    print(" meu id: $id");
    DeckDTO deckDTO = DeckDTO(id: id, description: name);
    await Future.delayed(const Duration(milliseconds: 500));
    decks.add(deckDTO);
    return id;
  }
}
