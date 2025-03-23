import 'dart:io';

import 'package:absence_manager_app/feature/absence_manager/domain/entities/response_entity/absence_response_entity.dart';
import 'package:absence_manager_app/utils/constant/app_snackbar.dart';
import 'package:absence_manager_app/utils/extensions/string_extensions.dart';
import 'package:absence_manager_app/utils/navigation/go_router_navigation_delegate.dart';
import 'package:path_provider/path_provider.dart';

Future<void> saveCalendarFile({
  required AbsenceResponseEntity entity,
  required String userName,
}) async {
  try {
    // Ensure proper UTC date formatting
    final now = DateTime.now();
    final startDate = DateTime.parse(
      entity.absenceStartDate ?? DateTime.now().toIso8601String(),
    );
    final endDate = DateTime.parse(
      entity.absenceEndDate ?? DateTime.now().toIso8601String(),
    );

    // Corrected iCal content
    final icsContent = '''
BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//MyApp//EN
CALSCALE:GREGORIAN
METHOD:PUBLISH
BEGIN:VEVENT
UID:${now.millisecondsSinceEpoch}@myapp.com
DTSTAMP:${_formatDate(now)}
DTSTART:${_formatDate(startDate)}
DTEND:${_formatDate(endDate)}
SUMMARY:$userName Absence Event
DESCRIPTION:This person will be unavailable from ${startDate.toIso8601String().getFormattedDate} till ${endDate.toIso8601String().getFormattedDate}.
LOCATION:Online
STATUS:CONFIRMED
SEQUENCE:0
BEGIN:VALARM
TRIGGER:-PT15M
ACTION:DISPLAY
DESCRIPTION:Reminder
END:VALARM
END:VEVENT
END:VCALENDAR
''';


    // Mobile (Android/iOS): Save the file
    late Directory directory;

    directory = await getApplicationDocumentsDirectory();

    final folderPath = '${directory.path}/Absence_Manager';

    // Ensure directory exists
    final folder = Directory(folderPath);
    if (!await folder.exists()) {
      await folder.create(recursive: true);
    }

    final sanitizedFileName =
        "${userName}_${DateTime.now().toUtc().toIso8601String().replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '')}";

    final filePath = '$folderPath/$sanitizedFileName.ics';

    final file = File(filePath);

    await file.writeAsString(icsContent);
    AppSnackBar().showSuccessSnackBar(
      context: GoRouterNavigationDelegate().parentNavigationKey.currentContext!,
      successMsg: 'File downloaded successfully',
    );
  } catch (_) {
    AppSnackBar().showErrorSnackBar(
      context: GoRouterNavigationDelegate().parentNavigationKey.currentContext!,
      error: 'File downloading failed',
    );
  }
}

// Helper function to format date for iCal
String _formatDate(DateTime date) {
  return '${date.toUtc().toIso8601String().replaceAll('-', '').replaceAll(':', '').split('.')[0]}Z';
}
