import 'package:flutter/material.dart';

abstract class CapPage extends StatefulWidget {
  const CapPage({super.key});

  String get title;
  List<Widget> get titleActions;
}
