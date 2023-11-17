import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../internet_controller.dart';

class ConnectivityPlusProvider extends InternetController {
  StreamController<NetworkResult> networkResultController = StreamController<NetworkResult>();

  ConnectivityPlusProvider() {
    //checks for connectivity situation
    Connectivity().onConnectivityChanged.listen((status) async {
      networkResultController.add(await _getNetworkResult(status));
    });
  }

  Future<NetworkResult> _getNetworkResult(ConnectivityResult status) async {
    switch (status) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.mobile:
        //sometimes it has connection but there is no internet
        bool res = await _hasInternet();
        return res ? NetworkResult.online : NetworkResult.offline;
      case ConnectivityResult.none:
        return NetworkResult.offline;
      default:
        return NetworkResult.offline;
    }
  }

  Future<bool> _hasInternet() async {
    bool isOnline = false;
    try {
      // ping to f1.com for validating internet
      final result = await InternetAddress.lookup('google.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    return isOnline;
  }

  @override
  Future<void> disposeController() async {
    //dispose controller for prevent memory leaking
    await networkResultController.close();
  }
}
