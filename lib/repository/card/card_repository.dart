import 'package:flutter/material.dart';
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

  static Future<bool> deleteAllByDeckId(int deckId) async {
    try {
      final box = Hive.box<CardDTO>(_boxName);

      final keysToDelete = <dynamic>[];
      for (var key in box.keys) {
        final card = box.get(key);
        if (card != null && card.deckId == deckId) {
          keysToDelete.add(key);
        }
      }

      if (keysToDelete.isEmpty) {
        return true;
      }

      await box.deleteAll(keysToDelete);
      return true;
    } catch (e, stackTrace) {
      debugPrint('Erro ao deletar cartões do deck $deckId: $e');
      debugPrintStack(stackTrace: stackTrace);
      return false;
    }
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
