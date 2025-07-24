import 'package:capcards/page/home_page.dart';
import 'package:flutter/material.dart';

void main() {
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
        appBarTheme: const AppBarTheme(color: Colors.green),
        scaffoldBackgroundColor: const Color.fromARGB(110, 165, 245, 80),
        listTileTheme: const ListTileThemeData(tileColor: Colors.white),
        inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 2))),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
