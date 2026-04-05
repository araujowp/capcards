class SearchDeckActions {
  final void Function() onAdd;
  final void Function(int id, String description) onEdit;

  SearchDeckActions({required this.onAdd, required this.onEdit});
}
