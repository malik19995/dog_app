import 'package:dog_app/core/theme/app_text.dart';
import 'package:dog_app/ui/home/home_view_model.dart';
import 'package:dog_app/ui/home/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RandomDogColumn extends ConsumerWidget {
  const RandomDogColumn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeVM = ref.watch(homeViewModelProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.network(
              homeVM.dogData.values.first,
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: AppText('Image not found'));
              },
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Flexible(
            child: AppText(
          formatDogName(homeVM.dogData.keys.first),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ))
      ],
    );
  }
}
