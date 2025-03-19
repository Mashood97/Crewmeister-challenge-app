class AppConstant {
  factory AppConstant() {
    return _instance;
  }

  AppConstant._internal();

  static final AppConstant _instance = AppConstant._internal();

  static const double kAppSidePadding = 14;
}
