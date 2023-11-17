import 'package:flutter/cupertino.dart';

import '../../../main.dart';

extension NavigationExtension on BuildContext {
  void pushAndRemove(Widget page) {
    navigatorKey.currentState!.pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => page), (route) => false);
  }

  void pop<T extends Object?>([T? result]) {
    navigatorKey.currentState!.pop(result);
  }

  Future<T?> push<T extends Object?>(Widget page) async {
    return navigatorKey.currentState!.push(
      CupertinoPageRoute(
        builder: (context) => page,
      ),
    );
  }

  Future<T?> modalPush<T>(Widget page) async {
    return showCupertinoModalPopup(
      context: navigatorKey.currentContext!,
      builder: (context) => page,
    );
  }

  Future<T?> dialogPush<T>(Widget page, {bool barrierDismissible = true}) async {
    return showCupertinoDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: barrierDismissible,
      builder: (context) => page,
    );
  }
}
