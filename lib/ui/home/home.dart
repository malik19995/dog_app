import 'package:cached_network_image/cached_network_image.dart';
import 'package:dog_app/core/extensions/app_consumer_state.dart';
import 'package:dog_app/core/extensions/string_extensions.dart';
import 'package:dog_app/core/theme/theme.dart';
import 'package:dog_app/ui/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:layout/layout.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../core/theme/app_text.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    super.key,
  });

  static String get name => 'Home';

  static String get path => '/';

  @override
  AppConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends AppConsumerState<HomePage> {
  @override
  void initState() {
    final viewModel = ref.read(homeViewModelProvider);
    viewModel.setAppConsumerState(this);
    viewModel.init();

    super.initState();
  }

  final borderDecoration = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: Colors.white24,
    ),
  );

  String formatDogName(String name) {
    return name
        .replaceAll('-', ' ')
        .split(' ')
        .map((String word) => word.capitalize())
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = ref.read(themeProvider).current.themeData;
    final homeVM = ref.watch(homeViewModelProvider);

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
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: homeVM.selectedMode == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: CachedNetworkImage(
                              errorWidget: (context, url, error) =>
                                  const Center(
                                      child: AppText('Image not found')),
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
                    )
                  : ListView(
                      children: homeVM.dogData.entries
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
                                  title: AppText(
                                    formatDogName(km.key),
                                  ),
                                ),
                              ))
                          .toList()),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
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
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 25),
              height: 55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    flex: 5,
                    child: homeVM.allBreeds.isEmpty
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : DropdownButtonFormField(
                            menuMaxHeight: 200,
                            decoration: InputDecoration(
                              enabledBorder: borderDecoration,
                              border: borderDecoration,
                              focusedBorder: borderDecoration,
                            ),
                            hint: const AppText(
                              'Select Breed',
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            value: homeVM.selectedBreed,
                            isExpanded: true,
                            onChanged: (value) {
                              if (value != null) {
                                homeVM.selectBreed(value as String);
                              }
                            },
                            items: homeVM.allBreeds.keys
                                .toSet()
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
                          ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    flex: 5,
                    child: homeVM.selectedBreed != null &&
                            homeVM.subBreeds.isNotEmpty
                        ? DropdownButtonFormField(
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
                          )
                        : SizedBox(
                            child: AppText(
                              homeVM.selectedBreed == null
                                  ? 'Select Breed First'
                                  : 'No Sub Breeds',
                              textAlign: TextAlign.center,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                            ),
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(222, 255, 255, 255),
                fixedSize: const Size(300, 25),
              ),
              onPressed: () => homeVM.search(),
              child: const AppText(
                'Search',
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 47, 39, 96),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
