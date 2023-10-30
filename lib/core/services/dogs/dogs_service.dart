import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final dogsServiceProvider = Provider<DogsService>(
  (ref) {
    return DogsServiceImpl();
  },
);

abstract class DogsService {
  Future<Map<String, dynamic>> getAllBreeds();
  Future<Map<String, dynamic>> fetchDogData(String url);
  Future<List> fetchSubBreeds(String breed);
}

class DogsServiceImpl implements DogsService {
  @override
  Future<Map<String, dynamic>> getAllBreeds() async {
    final response = await http.get(
      Uri.parse('https://dog.ceo/api/breeds/list/all'),
    );

    final responseData = jsonDecode(response.body);

    if (responseData['status'] == 'success') {
      return responseData['message'];
    }
    return {};
  }

  @override
  Future<List> fetchSubBreeds(String breed) async {
    final response = await http.get(
      Uri.parse('https://dog.ceo/api/breed/$breed/list'),
    );

    final responseData = jsonDecode(response.body);
    if (responseData['status'] == 'success') {
      return responseData['message'];
    } else {
      return [];
    }
  }

  @override
  Future<Map<String, dynamic>> fetchDogData(String url) async {
    final response = await http.get(Uri.parse(url));

    final responseData = jsonDecode(response.body);

    if (responseData['status'] == 'success') {
      if (responseData['message'].runtimeType == String) {
        final String breedName = responseData['message'].split('/')[4];
        return {breedName: responseData['message']};
      } else {
        Map<String, dynamic> responseDogData = {};
        int tt = 0;
        for (var dogUrl in responseData['message']) {
          final String breedName = dogUrl.split('/')[4] + ' $tt';
          tt++;
          responseDogData[breedName] = dogUrl;
        }
        return responseDogData;
      }
    } else {
      return {};
    }
  }
}
