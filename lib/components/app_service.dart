import 'package:capcards/components/app_image.dart';
import 'package:flutter/material.dart';

class AppSettings {
  static final ValueNotifier<String> backgroundImage = ValueNotifier(
    AppImage.noite.path,
  );
}
