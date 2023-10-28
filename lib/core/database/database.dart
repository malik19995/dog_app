import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

Future<String?> getDatabaseDirectory() async {
  if (!kIsWeb) {
    final path = '${(await getApplicationDocumentsDirectory()).path}/dog-app';
    final directory = Directory(path);

    if (!directory.existsSync()) {
      await directory.create();
    }

    return path;
  } else {
    return null;
  }
}
