import 'package:capcards/page/deck/search_deck_page.dart';
import 'package:capcards/page/main_page.dart';
import 'package:capcards/repository/deck/deck_dto.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:capcards/repository/card/card_dto.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(CardDTOAdapter());
  Hive.registerAdapter(DeckDTOAdapter());

  await Hive.openBox<CardDTO>('cardsBox');
  await Hive.openBox<DeckDTO>('decksBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'cap-cards',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF66813A)),
        scaffoldBackgroundColor: const Color(0xFF66813A),
        listTileTheme: const ListTileThemeData(tileColor: Colors.white),
        inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 2))),
        useMaterial3: true,
      ),
      home: const MainPage(),
      navigatorObservers: [routeObserver],
    );
  }
}
