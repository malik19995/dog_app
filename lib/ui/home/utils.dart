import 'package:dog_app/core/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

// Formatter function for Dog Names.
String formatDogName(String name) {
  return name.replaceAll('-', ' ').capitalizeFirstofEach();
}

// Default border decoration for dropdowns.
final borderDecoration = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(
    color: Colors.white24,
  ),
);
