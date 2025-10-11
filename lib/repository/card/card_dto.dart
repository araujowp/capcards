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
}
