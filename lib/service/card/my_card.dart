import 'package:capcards/repository/card/card_dto.dart';

class MyCard {
  final int? id;
  final String frontDescription;
  final String backDescription;
  final int deckId;
  final String? deckDescription;
  final DateTime revisionDate;
  final String? frontImage;
  final String? backImage;

  const MyCard({
    this.id,
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
}
