import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

class ConnectProvider extends ChangeNotifier {
  late StreamSubscription<List<ConnectivityResult>> _subscription;
  bool checknet = true;

  ConnectProvider() {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      checknet = checkConnect(result: result) ? true : false;
      notifyListeners();
    });
  }

  checkConnect({required List<ConnectivityResult> result}) {
    if (result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.mobile)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
