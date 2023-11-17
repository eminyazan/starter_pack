import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../main.dart';

enum AlertType { success, error, warning }

class AppAlert {
  static Future<dynamic> show({
    required String description,
    String? title,
    String? destructiveCancelText,
    String? activeText,
    VoidCallback? whenCancelPressed,
    VoidCallback? whenActivePressed,
    AlertType alertType = AlertType.error,
  }) {
    if (Platform.isIOS) {
      return showCupertinoDialog(
        context: navigatorKey.currentState!.context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(
              title ?? "Uyarı!",
              style: TextStyle(
                color: alertType == AlertType.error
                    ? CupertinoColors.destructiveRed
                    : alertType == AlertType.success
                        ? CupertinoColors.activeGreen
                        : CupertinoColors.activeOrange,
              ),
            ),
            content: Text(description),
            actions: <Widget>[
              if (destructiveCancelText != null)
                CupertinoDialogAction(
                  isDefaultAction: false,
                  child: Text(
                    destructiveCancelText,
                    style: TextStyle(fontSize: 14.sp, color: CupertinoColors.activeBlue),
                  ),
                  onPressed: () {
                    if (whenCancelPressed != null) {
                      whenCancelPressed();
                    } else {
                      context.pop();
                    }
                  },
                ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text(
                  activeText ?? "Tamam",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: CupertinoColors.destructiveRed,
                  ),
                ),
                onPressed: () {
                  if (whenActivePressed != null) {
                    whenActivePressed();
                  } else {
                    context.pop();
                  }
                },
              ),
            ],
          );
        },
      );
    } else {
      return showDialog(
        context: navigatorKey.currentState!.context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              title ?? "Uyarı!",
              style: TextStyle(
                color: alertType == AlertType.error
                    ? CupertinoColors.destructiveRed
                    : alertType == AlertType.success
                        ? CupertinoColors.activeGreen
                        : CupertinoColors.activeOrange,
              ),
            ),
            content: Text(description),
            actions: <Widget>[
              if (destructiveCancelText != null)
                TextButton(
                  child: Text(
                    destructiveCancelText,
                    style: TextStyle(fontSize: 14.sp, color: CupertinoColors.activeBlue),
                  ),
                  onPressed: () {
                    if (whenCancelPressed != null) {
                      whenCancelPressed();
                    } else {
                      context.pop();
                    }
                  },
                ),
              TextButton(
                child: Text(
                  activeText ?? "Tamam",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: CupertinoColors.destructiveRed,
                  ),
                ),
                onPressed: () {
                  if (whenActivePressed != null) {
                    whenActivePressed();
                  } else {
                    context.pop();
                  }
                },
              ),
            ],
          );
        },
      );
    }
  }
}
