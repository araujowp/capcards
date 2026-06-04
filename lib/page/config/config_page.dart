import 'package:capcards/components/app_image.dart';
import 'package:capcards/components/app_service.dart';
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
    //await _configService.saveBackground(image.path);
    //AppSettings.backgroundImage = image.path;
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
          DropdownButton<AppImage>(
            hint: const Text('Escolha o fundo'),
            items: AppImage.values.map((image) {
              return DropdownMenuItem(value: image, child: Text(image.name));
            }).toList(),
            onChanged: (image) {
              if (image != null) {
                changeBackground(image);
              }
            },
          ),
        ],
      ),
    );
  }
}
