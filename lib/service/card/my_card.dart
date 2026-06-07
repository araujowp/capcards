import 'package:capcards/repository/card/card_dto.dart';

class MyCard {
  final int id;
  final String frontDescription;
  final String backDescription;
  final int deckId;
  final String? deckDescription;
  DateTime revisionDate;
  final String? frontImage;
  final String? backImage;

  MyCard({
    this.id = 0,
    required this.frontDescription,
    required this.backDescription,
    required this.deckId,
    this.deckDescription,
    required this.revisionDate,
    this.frontImage,
    this.backImage,
  });

  factory MyCard.fromDTO(CardDTO dto, {String? deckDescription}) {
    return MyCard(
      id: dto.id,
      frontDescription: dto.frontDescription,
      backDescription: dto.backDescription,
      deckId: dto.deckId,
      deckDescription: deckDescription,
      revisionDate: dto.revisionDate,
      frontImage: dto.frontImage,
      backImage: dto.backImage,
    );
  }

  factory MyCard.empty() => MyCard(
    id: -1,
    frontDescription: "Front empty card",
    backDescription: "back empty card",
    deckId: -1,
    revisionDate: CardDTO.defaultDate,
    frontImage: "",
    backImage: "",
  );

  CardDTO toDTO() {
    return CardDTO(
      id: id,
      frontDescription: frontDescription,
      backDescription: backDescription,
      deckId: deckId,
      revisionDate: revisionDate,
      frontImage: frontImage,
      backImage: backImage,
    );
  }
}
