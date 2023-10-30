import 'package:dog_app/core/database/app_state/app_state_db.dart';

class MockAppStateDB implements AppStateDB {
  String? _currentThemeId;

  @override
  Future<String?> getCurrentThemeId() async {
    return _currentThemeId;
  }

  @override
  Future<void> setCurrentThemeId(String theme) async {
    _currentThemeId = theme;
  }
}
