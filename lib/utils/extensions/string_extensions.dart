import 'package:intl/intl.dart';

extension StringExtensions on String? {
  bool get isTextNullAndEmpty => this == null && this?.isEmpty == true;

  bool get isTextNotNullAndNotEmpty => this != null && this?.isNotEmpty == true;

  String get getFormattedDate => DateFormat().add_yMd().format(
        DateTime.parse(
          this ?? DateTime.now().toIso8601String(),
        ),
      );
}

extension XStringExtensions on String {
  String get convertRoutePathToRouteName => replaceAll('/', '');
}
