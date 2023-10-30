// ignore_for_file: prefer_null_aware_method_calls

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:dog_app/core/extensions/app_consumer_state.dart';

class AppViewModel extends ChangeNotifier {
  late final StreamSubscription<ConnectivityResult>
      connectivityChangedSubscription;

  AppViewModel() {
    connectivityChangedSubscription =
        Connectivity().onConnectivityChanged.listen(onConnectivityChanged);
  }

  bool loading = false;

  bool initialised = false;

  bool disposed = false;

  bool connected = false;

  Function(String)? _navigationGo;

  Function(String)? _navigationPush;

  VoidCallback? _navigationPop;

  Function(String, Color? color)? _showSnackBarMessage;

  Function(String, String?, String?, VoidCallback?, VoidCallback?)? _showDialog;

  BuildContext? context;

  void setAppConsumerState(AppConsumerState state) {
    _navigationGo = state.navigationGo;
    _navigationPush = state.navigationPush;
    _navigationPop = state.navigationPop;
    _showSnackBarMessage = state.showSnackBarMessage;
    _showDialog = state.showMessageDialog;

    context = state.context;
  }

  @mustCallSuper
  Future<void> init() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    connected = connectivityResult != ConnectivityResult.none;

    notifyListeners();
  }

  void setLoading(bool loading) {
    this.loading = loading;
    notifyListeners();
  }

  void navigationGo(String path) {
    if (_navigationGo != null) {
      _navigationGo!(path);
    }
  }

  void navigationPush(String path) {
    if (_navigationPush != null) {
      _navigationPush!(path);
    }
  }

  void navigationPop() {
    if (_navigationPop != null) {
      _navigationPop!();
    }
  }

  void showSnackBarMessage(
    String message, {
    Color? backgroundColour = const Color(0xFF993265),
  }) {
    if (_showSnackBarMessage != null) {
      _showSnackBarMessage!(message, backgroundColour);
    }
  }

  void showDialog({
    required String message,
    String? positiveButtonText,
    String? negativeButtonText,
    VoidCallback? onPositiveButtonTapped,
    VoidCallback? onNegativeButtonTapped,
  }) {
    if (_showDialog != null) {
      _showDialog!(
        message,
        positiveButtonText,
        negativeButtonText,
        onPositiveButtonTapped,
        onNegativeButtonTapped,
      );
    }
  }

  void onConnectivityChanged(ConnectivityResult result) {
    connected = result != ConnectivityResult.none;
    notifyListeners();
  }

  @mustCallSuper
  @override
  void dispose() {
    disposed = true;

    _navigationGo = null;
    _navigationPush = null;
    _navigationPop = null;
    _showSnackBarMessage = null;
    _showDialog = null;

    connectivityChangedSubscription.cancel();

    super.dispose();
  }
}
