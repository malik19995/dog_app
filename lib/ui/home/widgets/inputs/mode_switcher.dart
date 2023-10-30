import 'package:dog_app/core/theme/theme.dart';
import 'package:dog_app/ui/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:layout/layout.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ModeSwitcher extends ConsumerWidget {
  const ModeSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeVM = ref.watch(homeViewModelProvider);
    final appTheme = ref.watch(themeProvider).current.themeData;
    return SizedBox(
      width: context.layout.width - 50,
      height: 55,
      child: ToggleSwitch(
        initialLabelIndex: homeVM.selectedMode,
        animate: true,
        minHeight: 44,
        cornerRadius: 30.0,
        borderWidth: 0.5,
        borderColor: [
          appTheme.colorScheme.primary,
          appTheme.colorScheme.secondary,
        ],
        customWidths: [
          context.layout.maxWidth / 2 - 26,
          context.layout.maxWidth / 2 - 26,
        ],
        activeFgColor: Colors.white,
        inactiveBgColor: appTheme.colorScheme.background,
        inactiveFgColor: Colors.white,
        totalSwitches: 2,
        labels: const ['Random', 'List'],
        icons: const [
          Icons.shuffle,
          Icons.list,
        ],
        activeBgColors: [
          [
            appTheme.colorScheme.primary,
            appTheme.colorScheme.secondary,
          ],
          [
            appTheme.colorScheme.primary,
            appTheme.colorScheme.secondary,
          ],
        ],
        onToggle: (index) {
          homeVM.selectMode(index!);
        },
      ),
    );
  }
}
