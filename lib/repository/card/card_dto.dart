import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class CardDTO extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String frontDescription;

  @HiveField(2)
  String backDescription;

  @HiveField(3)
  int deckId;

  @HiveField(4)
  DateTime revisionDate;

  @HiveField(5)
  String? frontImage;

  @HiveField(6)
  String? backImage;

  static DateTime defaultDate = DateTime(2015, 9, 14, 0, 0, 0);

  CardDTO({
    required this.id,
    required this.frontDescription,
    required this.backDescription,
    required this.deckId,
    required this.revisionDate,
    required this.frontImage,
    required this.backImage,
  });

  factory CardDTO.empty() => CardDTO(
    id: -1,
    frontDescription: "Front empty card",
    backDescription: "back empty card",
    deckId: -1,
    revisionDate: defaultDate,
    frontImage: "",
    backImage: "",
  );

  static CardDTO build(int deckID) {
    return CardDTO(
      id: 0,
      frontDescription: "",
      backDescription: "",
      deckId: deckID,
      revisionDate: defaultDate,
      frontImage: "",
      backImage: "",
    );
  }
}
