import 'package:capcards/components/botton_nav/custom_botton_nav.dart';
import 'package:capcards/page/about_page.dart';
import 'package:capcards/page/cap_page.dart';
import 'package:capcards/page/cap_scaffold.dart';
import 'package:flutter/material.dart';

import 'deck/search_deck_page.dart';

final ValueNotifier<bool> _editModeNotifier = ValueNotifier(false);

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final GlobalKey<SearchDeckPageState> _searchDeckKey =
      GlobalKey<SearchDeckPageState>();

  late final List<CapPage> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      SearchDeckPage(
        stateKey: _searchDeckKey,
        editModeNotifier: _editModeNotifier,
      ),
      const AboutPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentPage = _pages[_selectedIndex];

    return CapScaffold(
      appBarText: currentPage.title,
      appBarActions: currentPage.titleActions,
      body: SafeArea(
        child: IndexedStack(index: _selectedIndex, children: _pages),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
