import 'package:capcards/components/cap_button.dart';
import 'package:capcards/page/cap_page.dart';
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
  void myAction(String value) {
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CapButton(
            label: "Importar",
            icon: Icons.download,
            onTap: () => myAction("importar"),
          ),
          CapButton(
            label: "Exportar",
            icon: Icons.upload,
            onTap: () => myAction("exportar"),
          ),
        ],
      ),
    );
  }
}
