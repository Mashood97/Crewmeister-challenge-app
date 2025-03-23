import 'package:absence_manager_app/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
