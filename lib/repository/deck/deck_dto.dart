import 'package:hive/hive.dart';
part 'deck_dto.g.dart';

@HiveType(typeId: 0)
class DeckDTO extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String description;

  DeckDTO({required this.id, required this.description});
}
