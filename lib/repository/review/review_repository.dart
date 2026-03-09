import 'package:hive/hive.dart';
import 'package:fsrs/fsrs.dart';

class ReviewRepository {
  static const String _fsrsBoxName = 'fsrs_cards';

  static final ReviewRepository _instance = ReviewRepository._internal();
  factory ReviewRepository() => _instance;
  ReviewRepository._internal();

  static Scheduler? _scheduler;
  static Box? _fsrsBox;

  static Future<void> init() async {
    if (_scheduler != null) return;

    _fsrsBox = Hive.box(_fsrsBoxName);
    _scheduler = Scheduler();
  }

  static Future<DateTime> nextDate(int cardId) async {
    await _ensureInitialized();

    final card = await _loadOrCreateFsrsCard(cardId);
    final now = DateTime.now().toUtc();

    return card.due.isBefore(now) ? now : card.due;
  }

  static Future<DateTime> record(int cardId, bool correct) async {
    await _ensureInitialized();

    final card = await _loadOrCreateFsrsCard(cardId);
    final now = DateTime.now().toUtc();

    final rating = correct ? Rating.good : Rating.again;

    final scheduling = _scheduler!.reviewCard(card, rating);
    final updatedCard = scheduling.card;

    await _saveFsrsCard(cardId, updatedCard);

    return updatedCard.due;
  }

  static Future<void> _ensureInitialized() async {
    if (_scheduler == null || _fsrsBox == null) {
      await init();
    }
    if (!_fsrsBox!.isOpen) {
      _fsrsBox = await Hive.openBox(_fsrsBoxName);
    }
  }

  static Future<Card> _loadOrCreateFsrsCard(int cardId) async {
    final key = 'card_$cardId';
    final rawValue = _fsrsBox!.get(key);

    Map<String, dynamic>? map;

    if (rawValue is Map) {
      map = rawValue
          .cast<String, dynamic>(); // cast seguro, só se as chaves forem String
    }

    if (map != null) {
      try {
        return Card.fromMap(map);
      } catch (e) {
        print("Erro ao restaurar Card do map: $e");
        // Opcional: deletar entrada corrompida
        // await _fsrsBox!.delete(key);
      }
    }

    // Novo cartão se não existir ou falhar
    final newCard = Card(cardId: cardId);
    await _saveFsrsCard(cardId, newCard);
    return newCard;
  }

  static Future<void> _saveFsrsCard(int cardId, Card card) async {
    final key = 'card_$cardId';
    await _fsrsBox!.put(key, card.toMap());
  }
}
