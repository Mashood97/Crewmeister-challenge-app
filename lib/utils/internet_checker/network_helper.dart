import 'package:absence_manager_app/utils/internet_checker/network_bloc.dart';
import 'package:absence_manager_app/utils/internet_checker/network_event.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

/*This class is used to observe the network change and add event to the network
bloc.
*/
class NetworkHelper {
  static void observeNetwork() {
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.none)) {
        NetworkBloc().add(const NetworkNotify());
      } else {
        NetworkBloc().add(const NetworkNotify(isConnected: true));
      }
    });
  }
}
