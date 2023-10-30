import 'package:dog_app/core/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

String formatDogName(String name) {
  return name
      .replaceAll('-', ' ')
      .split(' ')
      .map((String word) => word.capitalize())
      .join(' ');
}

final borderDecoration = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(
    color: Colors.white24,
  ),
);
