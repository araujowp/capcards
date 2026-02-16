import 'package:capcards/components/custom_botton_nav.dart';
import 'package:capcards/page/about_page.dart';
import 'package:capcards/page/cap_scaffold.dart';
import 'package:flutter/material.dart';

import 'deck/search_deck_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    SearchDeckPage(),
    AboutPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CapScaffold(
      body: IndexedStack(
        index: _selectedIndex, // Mantém o estado das páginas
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
