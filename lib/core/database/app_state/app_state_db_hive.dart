import 'dart:async';

import 'package:dog_app/core/database/app_state/app_state_db.dart';
import 'package:dog_app/core/database/database.dart';
import 'package:dog_app/core/database/hive.dart';
import 'package:hive_flutter/adapters.dart';

const _keyCurrentTheme = 'currentTheme';

class AppStateDBHive implements AppStateDB {
  LazyBox? _box;

  FutureOr<LazyBox> _getBox() async {
    if (_box == null) {
      final appDocDir = await getDatabaseDirectory();
      _box ??= await Hive.openLazyBox(storeAppState, path: appDocDir);
    }

    return _box!;
  }

  @override
  Future<String?> getCurrentThemeId() async {
    final box = await _getBox();
    return await box.get(_keyCurrentTheme) as String?;
  }

  @override
  Future<void> setCurrentThemeId(String theme) async {
    final box = await _getBox();
    return box.put(_keyCurrentTheme, theme);
  }
}
