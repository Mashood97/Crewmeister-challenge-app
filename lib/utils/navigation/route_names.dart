
/*In this class we maintain the app navigation route names*/
class NavigationRouteNames {

  factory NavigationRouteNames() {
    return _instance;
  }
  NavigationRouteNames._internal();
  static final NavigationRouteNames _instance =
      NavigationRouteNames._internal();

  static const String initialRoute = '/';


}
