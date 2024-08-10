import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

enum NetworkStatus { online, offline }

class ConnectProvider {
  StreamController<NetworkStatus> controller = StreamController();

  ConnectProvider() {
    Connectivity().checkConnectivity().then((connectivityResult) {
      controller.add(_networkStatus(connectivityResult));
    });

    Connectivity().onConnectivityChanged.listen((even) {
      controller.add(_networkStatus(even));
    });
  }

  NetworkStatus _networkStatus(ConnectivityResult connectivityResult) {
    return connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi
        ? NetworkStatus.online
        : NetworkStatus.offline;
  }
}
