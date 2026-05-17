import 'dart:convert';
import 'dart:io';

import 'package:capcards/repository/card/card_repository.dart';
import 'package:capcards/repository/deck/deck_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class BackupService {
  Future<void> exportBackup() async {
    try {
      final decks = await DeckRepository.getAll();
      final cards = await CardRepository.getAll();

      final backup = {
        "version": 1,
        "exportDate": DateTime.now().toIso8601String(),
        "decks": decks.map((deck) => deck.toJson()).toList(),
        "cards": cards.map((card) => card.toJson()).toList(),
      };

      final jsonString = const JsonEncoder.withIndent('  ').convert(backup);

      final directory = await getApplicationDocumentsDirectory();
      final fileName =
          "capcards_backup_${DateTime.now().millisecondsSinceEpoch}.json";
      final file = File('${directory.path}/$fileName');

      await file.writeAsString(jsonString);

      await Share.shareXFiles(
        [XFile(file.path)],
        text: "Backup do CapCards\nImporte este arquivo no novo dispositivo.",
        subject: "Backup CapCards",
      );
    } catch (e) {
      print("Erro ao exportar backup: $e");
    }
  }
}
