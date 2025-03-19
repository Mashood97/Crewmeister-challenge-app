/*In This class we maintain all our api routes*/
class ApiRoutes {
  factory ApiRoutes() {
    return _instance;
  }

  ApiRoutes._internal();

  static final ApiRoutes _instance = ApiRoutes._internal();

  static const String kBaseUrl = 'https://run.mocky.io/v3';
}
