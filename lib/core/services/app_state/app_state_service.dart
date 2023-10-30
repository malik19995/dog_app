import 'dart:async';

import 'package:dog_app/core/database/app_state/app_state_db.dart';
import 'package:dog_app/core/theme/theme.dart';
import 'package:dog_app/ui/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final appStateServiceProvider = Provider<AppStateService>((ref) {
  return AppStateServiceImpl(ref);
});

abstract class AppStateService {
  Future<void> init();

  StateProvider<bool> get haveInitialisedAppProvider;

  StateProvider<String> get routeProvider;
}

// Base App State Service from Infrastructure.
// Initialises Local App Cache, Theme etc.
class AppStateServiceImpl extends AppStateService {
  final Ref _ref;

  final AppStateDB _appStateDB;

  final _haveInitialisedAppProvider = StateProvider<bool>((ref) {
    return false;
  });

  final _currentRouteProvider = StateProvider<String>((ref) {
    return '/';
  });

  @override
  StateProvider<bool> get haveInitialisedAppProvider =>
      _haveInitialisedAppProvider;

  @override
  StateProvider<String> get routeProvider => _currentRouteProvider;

  AppStateServiceImpl(Ref ref)
      : _ref = ref,
        _appStateDB = ref.read(appStateDBProvider);

  Future<void> initCrashlytics() async {
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  Future<void> init() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    await Hive.initFlutter();
    final currentRoute = _ref.read(_currentRouteProvider.notifier);

    currentRoute.state = HomePage.path;

    var currentThemeId = await _appStateDB.getCurrentThemeId();

    if (currentThemeId == null) {
      currentThemeId = defaultThemeId;
      await _appStateDB.setCurrentThemeId(currentThemeId);
    }

    _ref.read(themeProvider).setCurrentThemeId(currentThemeId);
    _ref.read(_haveInitialisedAppProvider.notifier).state = true;
  }
}
