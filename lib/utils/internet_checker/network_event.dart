abstract class NetworkEvent {
  const NetworkEvent();
}

class NetworkObserve extends NetworkEvent {
  const NetworkObserve();
}

class NetworkNotify extends NetworkEvent {
  const NetworkNotify({this.isConnected = false});

  final bool isConnected;
}
