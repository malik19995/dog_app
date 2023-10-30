import 'package:cached_network_image/cached_network_image.dart';
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
            child: CachedNetworkImage(
              errorWidget: (context, url, error) =>
                  const Center(child: AppText('Image not found')),
              imageUrl: homeVM.dogData.values.first,
              fit: BoxFit.fitWidth,

              // alignment: Alignment.topCenter,
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
