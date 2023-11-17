import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/colors/app_colors.dart';
import '../text/app_text_widget.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color, textColor;
  final double fontSize;
  final IconData? icon;
  final FontWeight fontWeight;

  const AppButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color = AppColors.kcLightModeMain,
    this.fontSize = 18,
    this.fontWeight = FontWeight.bold,
    this.textColor = Colors.white,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoButton(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        onPressed: onPressed,
        color: color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 6),
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 13.0),
              child: AppTextWidget(
                text: text,
                fontSize: fontSize.sp,
                textColor: textColor,
                fontWeight: fontWeight,
              ),
            ),
          ],
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 6),
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: AppTextWidget(
                text: text,
                fontSize: fontSize.sp,
                textColor: textColor,
                fontWeight: fontWeight,
              ),
            ),
          ],
        ),
      );
    }
  }
}
