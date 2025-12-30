import 'package:hive_flutter/hive_flutter.dart';
import 'package:capcards/repository/card/card_dto.dart';
import 'package:capcards/repository/card/card_dto_new.dart';

class CardRepository {
  static const String _boxName = 'cardsBox';

  static Future<List<CardDTO>> getByDeckId(int deckId) async {
    final box = Hive.box<CardDTO>(_boxName);
    final allCards = box.values.toList();
    return allCards.where((card) => card.deckId == deckId).toList();
  }

  static Future<void> save(CardDTONew cardNew) async {
    final box = Hive.box<CardDTO>(_boxName);

    final int newId = (box.values.isEmpty)
        ? 1
        : box.values.map((c) => c.id).reduce((a, b) => a > b ? a : b) + 1;

    final card = CardDTO(
      id: newId,
      frontDescription: cardNew.frontDescription,
      backDescription: cardNew.backDescription,
      deckId: cardNew.deckId,
    );

    await box.put(newId, card);
  }

  static Future<bool> delete(int id) async {
    final box = Hive.box<CardDTO>(_boxName);

    if (!box.containsKey(id)) {
      throw Exception("Cartão com id $id não encontrado!");
    }

    await box.delete(id);
    return true;
  }

  static Future<List<CardDTO>> getAll() async {
    final box = Hive.box<CardDTO>(_boxName);
    return box.values.toList();
  }

  static Future<void> update(CardDTO updatedCard) async {
    final box = Hive.box<CardDTO>(_boxName);
    if (!box.containsKey(updatedCard.id)) {
      throw Exception("Cartão com id ${updatedCard.id} não encontrado!");
    }
    await box.put(updatedCard.id, updatedCard);
  }
}
