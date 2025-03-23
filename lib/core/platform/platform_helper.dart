// platform_helper.dart
export 'platform_stub.dart'
    if (dart.library.io) 'platform_mobile.dart'
    if (dart.library.html) 'platform_web.dart';
