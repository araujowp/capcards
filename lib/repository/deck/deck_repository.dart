import 'package:capcards/repository/card/card_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:capcards/repository/deck/deck_dto.dart';

class DeckRepository {
  static const String _boxName = 'decksBox';

  static Future<List<DeckDTO>> getAll() async {
    final box = Hive.box<DeckDTO>(_boxName);
    return box.values.toList();
  }

  static Future<int> add(String name) async {
    final box = Hive.box<DeckDTO>(_boxName);

    final int newId = (box.values.isEmpty)
        ? 1
        : box.values.map((d) => d.id).reduce((a, b) => a > b ? a : b) + 1;

    final deck = DeckDTO(id: newId, description: name);
    await box.put(newId, deck);
    return newId;
  }

  static Future<int> update(int id, String description) async {
    final box = Hive.box<DeckDTO>(_boxName);

    if (!box.containsKey(id)) {
      throw Exception("Deck $id not found!");
    }

    final deck = box.get(id)!;
    deck.description = description;
    await deck.save(); // Ou box.put(id, deck);
    return id;
  }

  static Future<bool> delete(int id) async {
    final box = Hive.box<DeckDTO>(_boxName);

    if (!box.containsKey(id)) {
      throw Exception("Deck $id not found!");
    }

    bool resultado = await CardRepository.deleteAllByDeckId(id);
    print("=========== resultado =========== $resultado");

    await box.delete(id);
    print("=========== deletou o deck =========== ");
    return true;
  }
}
