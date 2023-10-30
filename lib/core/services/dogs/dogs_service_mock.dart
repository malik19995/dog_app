import 'package:dog_app/core/services/dogs/dogs_service.dart';

class DogsServiceMock implements DogsService {
  @override
  Future<Map<String, String>> fetchDogData(String url) async {
    return await Future.value({
      'terrier-sealyham':
          'https://images.dog.ceo/breeds/terrier-sealyham/n02095889_3926.jpg',
    });
  }

  @override
  Future<List<String>> fetchSubBreeds(String breed) async {
    return await Future.value([
      "afghan",
      "basset",
      "blood",
      "english",
      "ibizan",
      "plott",
      "walker",
    ]);
  }

  @override
  Future<Map<String, List>> getAllBreeds() async {
    return await Future.value({
      "affenpinscher": [],
      "african": [],
      "airedale": [],
      "akita": [],
      "appenzeller": [],
      "australian": ["shepherd"],
      "basenji": [],
    });
  }
}
