import 'package:absence_manager_app/feature/absence_manager/data/remote/service/absence_manager_chopper_service.dart';
import 'package:absence_manager_app/utils/chopper_client/interceptor/internet_connection_interceptor.dart';
import 'package:absence_manager_app/utils/constant/api_routes.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/foundation.dart';

class ChopperClientInstance {
  factory ChopperClientInstance() {
    return _singleton;
  }

  ChopperClientInstance._internal();

  static final ChopperClientInstance _singleton =
      ChopperClientInstance._internal();

  static ChopperClient? client;

  static void initializeChopperClient() {
    client ??= ChopperClient(
      baseUrl: Uri.parse(
        ApiRoutes.kBaseUrl,
      ),
      services: [
        // Create and pass an instance of the generated service to the client
        AbsenceManagerChopperService.create(),
      ],
      converter: const JsonConverter(),
      errorConverter: const JsonConverter(),
      interceptors: kDebugMode
          ? [
              InternetConnectionInterceptor(),
              HttpLoggingInterceptor(),
            ]
          : [
              InternetConnectionInterceptor(),
            ],
    );
  }
}
