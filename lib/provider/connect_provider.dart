import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

class ConnectProvider extends ChangeNotifier {
  late StreamSubscription<List<ConnectivityResult>> _subscription;
  String messConnect = '';

  ConnectProvider() {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
          
      if (result.contains(ConnectivityResult.wifi)) {
        messConnect = 'Quay lại trực tuyến \nNgài đang sử dụng wifi !';
      } else if (result.contains(ConnectivityResult.mobile)) {
        messConnect = 'Quay lại trực tuyến \nNgài đang sử dụng dữ liệu di động';
      } else {
        messConnect = 'Không có kết nối';
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
