import 'package:hive/hive.dart';

part 'card_dto.g.dart';

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
  CardDTO(
      {required this.id,
      required this.frontDescription,
      required this.backDescription,
      required this.deckId});

  factory CardDTO.empty() => CardDTO(
      id: -1,
      frontDescription: "Front empty card",
      backDescription: "back empty card",
      deckId: -1);
}
