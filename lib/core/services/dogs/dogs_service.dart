import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

// Core App Service for Dogs API.
// This is the only place where we make API calls.

final dogsServiceProvider = Provider<DogsService>(
  (ref) {
    return DogsServiceImpl();
  },
);

abstract class DogsService {
  Future<Map<String, List>> getAllBreeds();
  Future<Map<String, String>> fetchDogData(String url);
  Future<List<String>> fetchSubBreeds(String breed);
}

class DogsServiceImpl implements DogsService {
  @override
  Future<Map<String, List<dynamic>>> getAllBreeds() async {
    try {
      final response = await http.get(
        Uri.parse('https://dog.ceo/api/breeds/list/all'),
      );

      final responseData = jsonDecode(response.body);

      if (responseData['status'] == 'success') {
        return Map<String, List<dynamic>>.from(responseData['message']);
      }
      return {};
    } catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(
          msg: 'Something went wrong fetching the breeds, please retry.');
      return {};
    }
  }

  @override
  Future<List<String>> fetchSubBreeds(String breed) async {
    try {
      final response = await http.get(
        Uri.parse('https://dog.ceo/api/breed/$breed/list'),
      );

      final responseData = jsonDecode(response.body);
      if (responseData['status'] == 'success') {
        return responseData['message'];
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(msg: 'Something went wrong, please retry.');
      return [];
    }
  }

  @override
  Future<Map<String, String>> fetchDogData(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      final responseData = jsonDecode(response.body);

      if (responseData['status'] == 'success') {
        if (responseData['message'].runtimeType == String) {
          final String breedName = responseData['message'].split('/')[4];
          return {breedName: responseData['message']};
        } else {
          Map<String, String> responseDogData = {};
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
    } catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(msg: 'Something went wrong, please retry.');
      return {};
    }
  }
}
