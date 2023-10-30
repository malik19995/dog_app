import 'package:dog_app/core/theme/app_text.dart';
import 'package:dog_app/core/theme/theme.dart';
import 'package:dog_app/core/services/app_state/app_state_service.dart';
import 'package:dog_app/dog_app_view_model.dart';
import 'package:dog_app/ui/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:layout/layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: DogApp(),
    ),
  );
}

class DogApp extends ConsumerStatefulWidget {
  const DogApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DogAppState();
}

class _DogAppState extends ConsumerState<DogApp> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    final appStateService = ref.read(appStateServiceProvider);
    await appStateService.init();

    final dogAppVM = ref.watch(dogAppViewModelProvider);
    await dogAppVM.init();
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
      final dogAppVM = ref.watch(dogAppViewModelProvider);

      return Layout(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: dogAppVM.connected
              ? const HomePage()
              : const Scaffold(
                  body: Center(
                      child: AppText(
                    'App is Offline, Please check your internet connectivity.',
                    maxLines: 3,
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    fontSize: 14,
                  )),
                ),
          title: 'Dog App',
        ),
      );
    }
  }
}
