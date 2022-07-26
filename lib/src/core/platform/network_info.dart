import 'package:connectivity_plus/connectivity_plus.dart';

enum ConnectionType {
  wired,
  wifi,
  mobile,
  bluetooth,
  none,
}

abstract class NetworkInfo {
  Future<bool> get isConnected;

  Future<ConnectionType> get connectionType;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  final List<ConnectionType> onlineTypes = [
    ConnectionType.bluetooth,
    ConnectionType.wired,
    ConnectionType.wifi,
    ConnectionType.mobile
  ];

  @override
  Future<bool> get isConnected async =>
      onlineTypes.contains(await connectionType);

  final Map<ConnectivityResult, ConnectionType> map = {
    ConnectivityResult.mobile: ConnectionType.mobile,
    ConnectivityResult.wifi: ConnectionType.wifi,
    ConnectivityResult.bluetooth: ConnectionType.bluetooth,
    ConnectivityResult.ethernet: ConnectionType.wired,
    ConnectivityResult.none: ConnectionType.none,
  };

  @override
  Future<ConnectionType> get connectionType async =>
      map[await connectivity.checkConnectivity()] ?? ConnectionType.none;
}
