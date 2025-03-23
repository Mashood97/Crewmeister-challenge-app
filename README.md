## Absence Manager 🏢📆

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]


A Flutter application that allows company owners to manage employee absences, including sick leaves and vacations. The app provides a smooth user experience with filtering, pagination, and an option to export data as an iCal file for Outlook.

📌 Features
✅ Display a list of absences with employee names.
✅ Show the first 10 absences with pagination support.
✅ Display total absence count.
✅ Each absence entry includes:
1. Employee name
2. Type of absence
3. Period (start & end date)
4. Employee note (if available)
5. Status (Requested, Confirmed, Rejected)
6. Admitter note (if available)
✅ Filter absences by type and date.
✅ Show a loading state until the list is available.
✅ Show an error state if data retrieval fails.
✅ Show an empty state if no results match the filters.
✅ (Bonus) Generate an iCal file to import into Outlook.

---
## 🛠️ Tech Stack
Flutter (Framework)

Dart (Programming Language)

Clean Architecture (Architecture)

BLoC (State Management)

flutter_bloc (For managing application state)

chopper (API calls)

intl (Date formatting)

flutter_test (Unit Testing)

---

## Getting Started 🚀

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*Absence Manager App works on iOS, Android, Web._

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

---

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
  
}
```

2. Then add a new key/value and description

```arb
{
    "@@locale": "en",
  
}
```

3. Use the new string

```dart
import 'package:absence_manager_app/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_es.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
     "@@locale": "en",

}
```

`app_es.arb`

```arb
{
      "@@locale": "es",

}
```

### Generating Translations

To use the latest translations changes, you will need to generate them:

1. Generate localizations for the current project:

```sh
flutter gen-l10n --arb-dir="lib/l10n/arb"
```

Alternatively, run `flutter run` and code generation will take place automatically.

---

🐛 Troubleshooting
                    
1. flutter: command not found -> Ensure Flutter SDK is installed and added to the system path.
2. Error: Missing plugin -> Run flutter clean and flutter pub get again.
3. App crashes on startup -> Check error logs using flutter run --verbose.

📌 Additional Notes
1. This project does not use API-based pagination, it implements manual pagination in Flutter.

2. Filters & Pagination are applied dynamically on the frontend.


If you find any issues or have suggestions, feel free to open a GitHub Issue.


[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
