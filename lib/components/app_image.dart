enum AppImage {
  floresta,
  floresta2,
  floresta3,
  noite,
  spidercap;

  String get path => 'assets/images/$fileName';

  static AppImage fromPath(String path) {
    return AppImage.values.firstWhere(
      (e) => e.path == path,
      orElse: () => AppImage.noite,
    );
  }

  String get fileName {
    switch (this) {
      case AppImage.floresta:
        return 'backgroundapp.jpg';
      case AppImage.floresta2:
        return 'floresta2.jpg';
      case AppImage.floresta3:
        return 'floresta3.png';
      case AppImage.noite:
        return 'noite.jpg';
      case AppImage.spidercap:
        return 'spidercap.png';
    }
  }
}
