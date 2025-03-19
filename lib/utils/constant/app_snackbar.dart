import 'package:flutter/material.dart';

class AppSnackBar {
  factory AppSnackBar() {
    return _instance;
  }

  AppSnackBar._internal();

  static final AppSnackBar _instance = AppSnackBar._internal();

  void showErrorSnackBar({
    required BuildContext context,
    required String error,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();

    final snackBar = SnackBar(
      content: Text(
        error,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red.shade900,
      showCloseIcon: true,
      closeIconColor: Colors.white,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showSuccessSnackBar({
    required BuildContext context,
    required String successMsg,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();

    final snackBar = SnackBar(
      content: Text(
        successMsg,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green.shade900,
      showCloseIcon: true,
      closeIconColor: Colors.white,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
