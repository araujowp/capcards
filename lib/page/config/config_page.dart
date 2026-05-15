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
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("ola sou o state"));
  }
}
