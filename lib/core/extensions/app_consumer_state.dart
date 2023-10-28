import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

abstract class AppConsumerState<T extends ConsumerStatefulWidget>
    extends ConsumerState<T> {
  void navigationGo(String path) {
    if (mounted) {
      context.go(path);
    }
  }

  void navigationPush(String path) {
    if (mounted) {
      context.push(path);
    }
  }

  void navigationPop() {
    if (mounted) {
      context.pop();
    }
  }

  void showSnackBarMessage(String message, Color? backgroundColour) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                10,
              ),
              topRight: Radius.circular(
                10,
              ),
            ),
          ),
          backgroundColor: backgroundColour,
          content: Text(message),
        ),
      );
    }
  }

  Future<void> showMessageDialog(
    String message,
    String? positiveButtonText,
    String? negativeButtonText,
    VoidCallback? positiveButtonTapped,
    VoidCallback? negativeButtonTapped,
  ) async {
    if (mounted) {
      return showDialog<int>(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
          );
        },
      ).then((value) {});
    }
  }
}
