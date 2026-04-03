import 'package:capcards/page/cap_page.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutPage extends CapPage {
  const AboutPage({super.key});

  @override
  String get title => 'Sobre o Capcards';

  @override
  List<Widget> get titleActions => const [];

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
      _version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Versão: $_version',
        style: const TextStyle(fontSize: 40, color: Colors.white),
      ),
    );
  }
}
