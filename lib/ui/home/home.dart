import 'package:dog_app/core/extensions/app_consumer_state.dart';
import 'package:dog_app/ui/home/home_view_model.dart';
import 'package:dog_app/ui/home/widgets/dogs_list_view.dart';
import 'package:dog_app/ui/home/widgets/inputs/breed_dropdown.dart';
import 'package:dog_app/ui/home/widgets/inputs/mode_switcher.dart';
import 'package:dog_app/ui/home/widgets/inputs/sub_breed_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_text.dart';
import 'widgets/random_dog_column.dart';

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

  @override
  Widget build(BuildContext context) {
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
        child: homeVM.connected
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const SizedBox(
                    height: 15,
                  ),
                  // Response UI
                  Expanded(
                    child: homeVM.selectedMode == 0
                        ? const RandomDogColumn()
                        : const DogsListView(),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  // API Mode Switcher
                  const ModeSwitcher(),

                  // Breed and Sub Breed Dropdowns
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(
                      left: 25,
                      right: 25,
                      bottom: 25,
                      top: 15,
                    ),
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
                                : const BreedDropdown()),
                        const SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          flex: 5,
                          child: homeVM.selectedBreed != null &&
                                  homeVM.subBreeds.isNotEmpty
                              ? const SubBreedDropdown()
                              : SizedBox(
                                  child: AppText(
                                    homeVM.selectedBreed == null
                                        ? 'Select Breed First'
                                        : 'No Sub Breeds',
                                    textAlign: TextAlign.center,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),

                  // Search from API Button
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
              )
            : const AppText(
                'App is offline. Please check your internet connection.',
                maxLines: 2,
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                ),
              ),
      ),
    );
  }
}
