import 'package:capcards/page/cap_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  AboutPageState createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  String _version = 'Carregando...';

  @override
  void initState() {
    super.initState();
    _getVersion();
  }

  Future<void> _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = packageInfo.version; // Exibe "1.0.23"
    });
  }

  @override
  Widget build(BuildContext context) {
    return CapScaffold(
      appBar: AppBar(
        title: const Text('Sobre o Capcards'),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Text('Versão: $_version', style: const TextStyle(fontSize: 40)),
      ),
    );
  }
}
