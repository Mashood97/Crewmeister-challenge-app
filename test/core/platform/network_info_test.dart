import 'package:absence_manager_app/core/platform/network_information.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockInternetConnectionChecker extends Mock implements Connectivity {}

void main() {
  late final NetworkInfoImpl networkInfoImpl;
  late final MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfoImpl =
        NetworkInfoImpl(networkConnectionCheck: mockInternetConnectionChecker);
  });

  group('IsConnected', () {
    test('Should forward the call to Internet connection checker.hasConnection',
        () async {
      ///since we already created Future.value(true) as var then we dont need
      /// to set ThenAnswer(()) as async because return type is already future.
      final tHasConnectionFuture = Future.value([ConnectivityResult.wifi]);

      //arrange
      when(() => mockInternetConnectionChecker.checkConnectivity()).thenAnswer(
        (_) => tHasConnectionFuture,
      );

      //act

      final result = networkInfoImpl.networkConnectionCheck.checkConnectivity();
      //assert

      verify(() => mockInternetConnectionChecker.checkConnectivity());
      expect(result, tHasConnectionFuture);
    });
  });
}
