import 'package:dog_app/core/theme/theme.dart';
import 'package:dog_app/core/services/app_state/app_state_service.dart';
import 'package:dog_app/ui/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:layout/layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    final appStateService = ref.read(appStateServiceProvider);
    await appStateService.init();
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.read(appStateServiceProvider);

    final haveInitialisedApp = ref.watch(appState.haveInitialisedAppProvider);

    if (!haveInitialisedApp) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Color(0xff000058),
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      final theme = ref.watch(themeProvider).current.themeData;

      return Layout(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: const HomePage(),
          title: 'Dog App',
        ),
      );
    }
  }
}
