import 'dart:async';

import 'package:dog_app/core/database/app_state/app_state_db_hive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appStateDBProvider = Provider<AppStateDB>((_) => AppStateDBHive());

abstract class AppStateDB {
  Future<String?> getCurrentThemeId();

  Future<void> setCurrentThemeId(String theme);
}
