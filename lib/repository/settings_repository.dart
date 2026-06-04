import 'package:hive/hive.dart';

class SettingsRepository {
  static const String _boxName = 'settingsBox';

  Future<void> setValue(String key, dynamic value) async {
    final box = await Hive.openBox(_boxName);
    await box.put(key, value);
  }

  Future<T?> getValue<T>(String key) async {
    final box = await Hive.openBox(_boxName);
    return box.get(key) as T?;
  }
}
