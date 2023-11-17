import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/internet/internet_controller.dart';

class NetworkAwareWidget extends StatelessWidget {
  final Widget onlineChild;
  final Widget offlineChild;

  const NetworkAwareWidget({Key? key, required this.onlineChild, required this.offlineChild}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkResult>(builder: (context, data, child) {
      return data == NetworkResult.online ? onlineChild : offlineChild;
    });
  }
}
