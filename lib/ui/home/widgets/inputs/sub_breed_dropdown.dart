import 'package:dog_app/core/extensions/string_extensions.dart';
import 'package:dog_app/core/theme/app_text.dart';
import 'package:dog_app/ui/home/home_view_model.dart';
import 'package:dog_app/ui/home/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubBreedDropdown extends ConsumerWidget {
  const SubBreedDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeVM = ref.watch(homeViewModelProvider);
    return DropdownButtonFormField(
      menuMaxHeight: 200,
      decoration: InputDecoration(
        enabledBorder: borderDecoration,
        border: borderDecoration,
        focusedBorder: borderDecoration,
      ),
      hint: const AppText(
        'Select Sub Breed',
        fontSize: 12,
        color: Colors.grey,
      ),
      value: homeVM.selectedSubBreed,
      isExpanded: true,
      onChanged: (value) {
        if (value != null) {
          homeVM.selectSubBreed(value as String);
        }
      },
      items: homeVM.subBreeds
          .map(
            (key) => DropdownMenuItem(
              value: key,
              alignment: Alignment.center,
              child: AppText(
                (key as String).capitalize(),
                color: Colors.white,
                fontSize: 12,
                textAlign: TextAlign.center,
              ),
            ),
          )
          .toList(),
    );
  }
}
