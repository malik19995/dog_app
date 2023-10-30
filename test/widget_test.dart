import 'package:dog_app/core/database/app_state/app_state_db.dart';
import 'package:dog_app/core/database/app_state/mock_app_state_db.dart';
import 'package:dog_app/core/services/dogs/dogs_service.dart';
import 'package:dog_app/core/services/dogs/dogs_service_mock.dart';
import 'package:dog_app/ui/home/home.dart';
import 'package:dog_app/ui/home/widgets/inputs/breed_dropdown.dart';
import 'package:dog_app/ui/home/widgets/inputs/mode_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app_widget.dart';

void main() {
  Future<void> setup(WidgetTester tester) async {
    final overrides = [
      appStateDBProvider.overrideWithValue(
        MockAppStateDB(),
      ),
      dogsServiceProvider.overrideWithValue(
        DogsServiceMock(),
      ),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: const TestAppWidget(
          child: Scaffold(
            body: HomePage(),
          ),
        ),
      ),
    );
  }

  testWidgets('End to End Random Test', (WidgetTester tester) async {
    await setup(tester);
    // Build our app and trigger a frame.
    await tester.pumpAndSettle(
      const Duration(milliseconds: 200),
    );

    expect(find.byType(ModeSwitcher), findsOneWidget);
    expect(find.byType(BreedDropdown), findsOneWidget);

    expect(find.text('Hound Afghan'), findsOneWidget);

    expect(find.byType(Image), findsOneWidget);

    await tester.tap(find.text("Search"));
    await tester.pump(
      const Duration(milliseconds: 300),
    );

    expect(find.text('Hound Afghan'), findsNothing);
  });
}
