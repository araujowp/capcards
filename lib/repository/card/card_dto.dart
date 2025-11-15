class CardDTO {
  int id;
  String frontDescription;
  String backDescription;
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
