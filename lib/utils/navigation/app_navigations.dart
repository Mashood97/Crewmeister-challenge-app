import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/*In This class we maintain all the app navigations.*/
class AppNavigations {
  factory AppNavigations() {
    return _instance;
  }

  AppNavigations._internal();

  static final AppNavigations _instance = AppNavigations._internal();

  void navigateBack(
      {required BuildContext context, dynamic value, bool isDialog = false}) {
    if (isDialog) {
      Navigator.of(context).pop();
    } else {
      context.pop(value);
    }
  }
}
