import 'package:dog_app/core/extensions/app_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dogAppViewModelProvider = ChangeNotifierProvider<DogAppViewModel>((ref) {
  return DogAppViewModel(ref);
});

class DogAppViewModel extends AppViewModel {
  DogAppViewModel(ref);
}
