import 'package:capcards/components/cap_button.dart';
import 'package:capcards/page/cap_page.dart';
import 'package:capcards/service/backup_service.dart';
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
    print("in construction");
  }

  void export() async {
    print("antes do export");
    await _backupService.exportBackup();
    print("depois do export");
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
