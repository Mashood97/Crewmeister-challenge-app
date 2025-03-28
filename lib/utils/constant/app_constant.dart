import 'dart:convert';

import 'package:absence_manager_app/core/platform/platform_helper.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/entities/response_entity/absence_response_entity.dart';
import 'package:flutter/services.dart'; // Use rootBundle for web compatibility

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

class MockLocalData {
  factory MockLocalData() {
    return _instance;
  }

  MockLocalData._internal();

  static final MockLocalData _instance = MockLocalData._internal();

  /// Path to json files in assets folder.

  static const String _jsonDir = 'assets/json';
  static const String absencesPath = '$_jsonDir/absences.json';
  static const String membersPath = '$_jsonDir/members.json';

  Future<List<dynamic>> _readJsonFile(String path) async {
    try {
      final content = await rootBundle.loadString(path);
      final data = jsonDecode(content) as Map<String, dynamic>;
      final items = data['payload'] as List<dynamic>?;
      return items ?? []; // Ensure a default empty list
    } catch (e) {
      return [];
    }
  }

  Future<List<dynamic>> absences() async => _readJsonFile(absencesPath);

  Future<List<dynamic>> members() async => _readJsonFile(membersPath);
}
