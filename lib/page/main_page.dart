import 'package:capcards/components/botton_nav/custom_botton_nav.dart';
import 'package:capcards/page/about_page.dart';
import 'package:capcards/page/cap_scaffold.dart';
import 'package:capcards/page/deck/deck_page.dart';
import 'package:capcards/page/deck/search_deck_actions.dart';
import 'package:flutter/material.dart';

import 'deck/search_deck_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final ValueNotifier<bool> _editModeNotifier = ValueNotifier(false);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      SearchDeckPage(
        editModeNotifier: _editModeNotifier,
        actions: SearchDeckActions(
          onAdd: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const DeckPage(id: 0, description: ""),
              ),
            );
          },
          onEdit: (deckId, description) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DeckPage(id: deckId, description: description),
              ),
            );
          },
        ),
      ),
      const AboutPage(),
    ];

    final currentPage = pages[_selectedIndex];

    return CapScaffold(
      appBarText: currentPage.title,
      appBarActions: currentPage.titleActions,
      body: SafeArea(
        child: IndexedStack(index: _selectedIndex, children: pages),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
