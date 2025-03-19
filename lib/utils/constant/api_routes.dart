/*In This class we maintain all our api routes*/
class ApiRoutes {
  factory ApiRoutes() {
    return _instance;
  }

  ApiRoutes._internal();

  static final ApiRoutes _instance = ApiRoutes._internal();

  static const String kBaseUrl = 'https://run.mocky.io/v3';

  static const String fetchAbsencesRoute =
      '/8c3cbc94-d330-45fb-9431-9856df605706';
}
