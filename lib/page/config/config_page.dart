import 'package:capcards/components/app_image.dart';
import 'package:capcards/components/app_service.dart';
import 'package:capcards/components/cap_button.dart';
import 'package:capcards/components/cap_text.dart';
import 'package:capcards/page/cap_page.dart';
import 'package:capcards/service/backup_service.dart';
import 'package:capcards/service/settings_service.dart';
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
  final SettingsService _settingsService = SettingsService();

  void import() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json', 'bak', 'backup', 'txt'],
        allowMultiple: false,
      );

      if (result == null || result.files.isEmpty) {
        _showMessage('Importação cancelada pelo usuário');
        return;
      }

      final file = result.files.first;

      final success = await _backupService.importBackup(file);

      if (success) {
        _showMessage('✅ Backup importado com sucesso!');
      } else {
        _showMessage('❌ Falha ao importar o backup');
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

  Future<void> changeBackground(AppImage image) async {
    await _settingsService.setBackground(image.path);
    AppSettings.backgroundImage.value = image.path;
    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Plano de fundo alterado')));

    setState(() {});
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const CapText("Fundo"),
                const SizedBox(width: 8),
                DropdownButton<AppImage>(
                  value: AppImage.fromPath(AppSettings.backgroundImage.value),
                  items: AppImage.values.map((image) {
                    return DropdownMenuItem(
                      value: image,
                      child: CapText(image.name, color: Colors.yellow),
                    );
                  }).toList(),
                  onChanged: (image) {
                    if (image != null) {
                      changeBackground(image);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
