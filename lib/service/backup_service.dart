import 'dart:convert';
import 'dart:io';

import 'package:capcards/repository/card/card_dto.dart';
import 'package:capcards/repository/card/card_repository.dart';
import 'package:capcards/repository/deck/deck_dto.dart';
import 'package:capcards/repository/deck/deck_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class BackupService {
  Future<bool> importBackup(PlatformFile file) async {
    try {
      // 1. Ler o arquivo
      final bytes = file.bytes;
      if (bytes == null) {
        // Se não tiver bytes em memória, tenta ler do path (caso mobile)
        if (file.path != null) {
          final fileFromPath = File(file.path!);
          final content = await fileFromPath.readAsString();
          return await _processBackup(content);
        }
        return false;
      }

      // 2. Converter bytes para String
      final jsonString = utf8.decode(bytes);
      return await _processBackup(jsonString);
    } catch (e) {
      print("Erro ao importar backup: $e");
      return false;
    }
  }

  Future<bool> _processBackup(String jsonString) async {
    try {
      final Map<String, dynamic> backup = jsonDecode(jsonString);

      // Verifica versão (para futuro)
      final int version = backup['version'] ?? 1;
      if (version != 1) {
        print("Versão de backup não suportada: $version");
        return false;
      }

      final List<dynamic> decksJson = backup['decks'] ?? [];
      final List<dynamic> cardsJson = backup['cards'] ?? [];

      // 3. Limpar dados atuais (backup completo)
      await DeckRepository.deleteAll();
      await CardRepository.deleteAll();

      // 4. Inserir Decks
      if (decksJson.isNotEmpty) {
        final decks = decksJson.map((json) => DeckDTO.fromJson(json)).toList();
        await DeckRepository.insertAll(decks); // ou saveAll / bulkInsert
      }

      // 5. Inserir Cards
      if (cardsJson.isNotEmpty) {
        final cards = cardsJson.map((json) => CardDTO.fromJson(json)).toList();
        await CardRepository.insertAll(cards);
      }

      print(
        "Backup importado com sucesso! Decks: ${decksJson.length} | Cards: ${cardsJson.length}",
      );
      return true;
    } catch (e) {
      print("Erro ao processar backup: $e");
      return false;
    }
  }

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
