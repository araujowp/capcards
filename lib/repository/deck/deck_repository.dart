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
}
