class ReviewRepository {
  static Future<DateTime> nextDate(int cardId) async {
    return DateTime.now();
  }

  static Future<void> record(int cardId, bool correct) async {
    print("registrou o card $cardId");
  }
}
