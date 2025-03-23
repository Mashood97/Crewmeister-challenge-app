import 'package:absence_manager_app/core/platform/platform_helper.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/entities/response_entity/absence_response_entity.dart';

class AppConstant {
  factory AppConstant() {
    return _instance;
  }

  AppConstant._internal();

  static final AppConstant _instance = AppConstant._internal();

  static const double kAppSidePadding = 14;

  Future<void> generateAndDownloadICalFile({
    required AbsenceResponseEntity entity,
    required String userName,
  }) async {
    // Ensure proper UTC date formatting
    await saveCalendarFile(
      entity: entity,
      userName: userName,
    );
  }

// Helper function to format date for iCal
  String _formatDate(DateTime date) {
    return '${date.toUtc().toIso8601String().replaceAll('-', '').replaceAll(':', '').split('.')[0]}Z';
  }
}
