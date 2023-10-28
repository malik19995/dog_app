import 'package:cached_network_image/cached_network_image.dart';
import 'package:dog_app/core/extensions/app_consumer_state.dart';
import 'package:dog_app/core/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:layout/layout.dart';

import '../../core/theme/app_text.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    super.key,
  });

  static String get name => 'Dashboard';

  static String get path => '/';

  @override
  AppConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends AppConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: Replace this with a list of dogs from the API
    // View Model init with this.
    final dogData = {
      'hound-afghan':
          "https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg",
      'corgi-cardigan':
          "https://images.dog.ceo/breeds/corgi-cardigan/n02113186_11073.jpg",
    };

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 85,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const AppText(
          'Dog App',
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: context.layout.width,
              height: 55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  selectorButton(
                    context,
                    'Random Image',
                    () {},
                  ),
                  selectorButton(
                    context,
                    'Images List',
                    () {},
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: context.layout.width,
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // TODO:
                  // List all Breeds to fetch all available breeds and sub breeds.

                  // Top buttons act as toggle for either random or image list.

                  // Text form fields to be changed to dropdowns.

                  SizedBox(
                    width: context.layout.width / 2.35,
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.bottom,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Breed',
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: context.layout.width / 2.35,
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.bottom,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Sub Breed',
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 0.5,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                  children: dogData.entries
                      .map((km) => SizedBox(
                            height: 80,
                            width: context.layout.width,
                            child: ListTile(
                              leading: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: km.value,
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                km.key
                                    .replaceAll('-', ' ')
                                    .split(' ')
                                    .map((word) => word.capitalize())
                                    .join(' '),
                              ),
                            ),
                          ))
                      .toList()),
            ),
          ],
        ),
      ),
    );
  }
}

Widget selectorButton(BuildContext context, String text, Function() onPressed) {
  return TextButton(
    onPressed: onPressed,
    child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white54),
        borderRadius: BorderRadius.circular(25),
      ),
      height: 55,
      width: context.layout.width / 2.35,
      child: AppText(
        text,
        maxLines: 3,
        textAlign: TextAlign.center,
      ),
    ),
  );
}
