import 'package:absence_manager_app/utils/internet_checker/network_event.dart';
import 'package:absence_manager_app/utils/internet_checker/network_helper.dart';
import 'package:absence_manager_app/utils/internet_checker/network_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {

  factory NetworkBloc() => _instance;
  NetworkBloc._() : super(NetworkInitial()) {
    on<NetworkObserve>(_observe);
    on<NetworkNotify>(_notifyStatus);
  }

  static final NetworkBloc _instance = NetworkBloc._();

  void _observe(NetworkObserve event, Emitter<NetworkState> emit) {
    NetworkHelper.observeNetwork();
  }

  void _notifyStatus(NetworkNotify event, Emitter<NetworkState> emit) {
    event.isConnected ? emit(NetworkSuccess()) : emit(NetworkFailure());
  }
}
