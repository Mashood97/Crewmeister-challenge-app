/*In This class we maintain all our api routes*/
class ApiRoutes {
  factory ApiRoutes() {
    return _instance;
  }

  ApiRoutes._internal();

  static final ApiRoutes _instance = ApiRoutes._internal();

  static const String kBaseUrl = 'https://run.mocky.io/v3';

  static const String fetchAbsencesRoute =
      '/99b8c986-ba27-4fd7-9df4-9e3b57dedd1d';
  static const String fetchUsersRoute =
      '/5d854afb-0f55-4c83-af35-b999c9ce2bee';
}
