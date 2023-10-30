import 'package:dog_app/core/extensions/app_view_model.dart';
import 'package:dog_app/core/services/dogs/dogs_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

final homeViewModelProvider = ChangeNotifierProvider<HomeViewModel>((ref) {
  return HomeViewModel(ref);
});

class HomeViewModel extends AppViewModel {
  HomeViewModel(Ref ref) : dogService = ref.read(dogsServiceProvider);

  final DogsService dogService;

  Map allBreeds = {};
  List subBreeds = [];
  String? selectedBreed;
  String? selectedSubBreed;
  int selectedMode = 0;

  // Default Data
  Map dogData = {
    'hound-afghan':
        "https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg",
    'corgi-cardigan':
        "https://images.dog.ceo/breeds/corgi-cardigan/n02113186_11073.jpg",
  };

  @override
  Future<void> init() async {
    fetchBreeds();
    return super.init();
  }

  Future<void> fetchBreeds() async {
    allBreeds = await dogService.getAllBreeds();
    notifyListeners();
  }

  void selectMode(int mode) {
    selectedMode = mode;
    notifyListeners();
  }

  void selectSubBreed(String subBreed) {
    selectedSubBreed = subBreed;
    notifyListeners();
  }

  Future<void> selectBreed(String breed) async {
    selectedBreed = breed;
    subBreeds = await dogService.fetchSubBreeds(breed);
    selectedSubBreed = null;
    notifyListeners();
  }

  Future<void> search() async {
    String apiUrl;

    if (selectedMode == 0) {
      if (selectedBreed == null) {
        apiUrl = 'https://dog.ceo/api/breeds/image/random';
      } else if (selectedBreed != null && selectedSubBreed == null) {
        apiUrl = 'https://dog.ceo/api/breed/$selectedBreed/images/random';
      } else {
        apiUrl =
            'https://dog.ceo/api/breed/$selectedBreed/$selectedSubBreed/images/random';
      }
    } else {
      if (selectedBreed == null) {
        await Fluttertoast.showToast(
          msg: 'Please select a breed first for list',
        );
        return;
      } else if (selectedBreed != null && selectedSubBreed == null) {
        apiUrl = 'https://dog.ceo/api/breed/$selectedBreed/images';
      } else {
        apiUrl =
            'https://dog.ceo/api/breed/$selectedBreed/$selectedSubBreed/images';
      }
    }
    dogData = await fetchDog(apiUrl);
    notifyListeners();
  }

  Future<Map> fetchDog(String url) {
    return dogService.fetchDogData(
      url,
    );
  }
}
