import 'package:capcards/components/app_image.dart';
import 'package:capcards/repository/settings_repository.dart';

class SettingsService {
  static const String _backgroundKey = 'backgroundImage';

  final SettingsRepository _repository = SettingsRepository();

  Future<void> setBackground(String background) async {
    await _repository.setValue(_backgroundKey, background);
  }

  Future<String> getBackground() async {
    return await _repository.getValue<String>(_backgroundKey) ??
        AppImage.noite.path;
  }
}
