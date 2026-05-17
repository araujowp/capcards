import 'package:capcards/components/cap_button.dart';
import 'package:capcards/page/cap_page.dart';
import 'package:capcards/service/backup_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ConfigPage extends CapPage {
  const ConfigPage({super.key});

  @override
  ConfigPageState createState() => ConfigPageState();

  @override
  String get title => 'Configurações';

  @override
  List<Widget> get titleActions => const [];
}

class ConfigPageState extends State<ConfigPage> {
  final BackupService _backupService = BackupService();

  void import() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowedExtensions: [
          'json',
          'bak',
          'backup',
        ], // ajuste conforme seu formato
        allowMultiple: false,
      );

      if (result == null || result.files.isEmpty) {
        _showMessage('Importação cancelada');
        return;
      }

      final file = result.files.first;

      final success = await _backupService.importBackup(file);

      if (success) {
        _showMessage('Backup importado com sucesso!');
      } else {
        _showMessage('Falha ao importar o backup');
      }
    } catch (e) {
      _showMessage('Erro ao importar: $e');
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void export() async {
    await _backupService.exportBackup();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CapButton(
            label: "Importar",
            icon: Icons.download,
            onTap: () => import(),
          ),
          CapButton(
            label: "Exportar",
            icon: Icons.upload,
            onTap: () => export(),
          ),
        ],
      ),
    );
  }
}
