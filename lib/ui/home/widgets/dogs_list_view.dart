import 'package:dog_app/core/theme/app_text.dart';
import 'package:dog_app/ui/home/home_view_model.dart';
import 'package:dog_app/ui/home/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:layout/layout.dart';

// This is the Output Widget for the List Mode of the app.
// It displays the list of all the dogs returned from the API.

class DogsListView extends ConsumerWidget {
  const DogsListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeVM = ref.watch(homeViewModelProvider);
    return ListView(
      children: homeVM.dogData.entries
          .map(
            (km) => SizedBox(
              height: 80,
              width: context.layout.width,
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    km.value,
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                title: AppText(
                  formatDogName(km.key),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
