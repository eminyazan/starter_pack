import 'package:flutter/material.dart';

import '../../resources/colors/app_colors.dart';

class AppCircularProgressIndicator extends StatelessWidget {
  final Color mainColor, backgroundColor;

  const AppCircularProgressIndicator({
    Key? key,
    this.mainColor = AppColors.kcLightModeMain,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator.adaptive(
      backgroundColor: backgroundColor,
      strokeWidth: 1,
      valueColor: AlwaysStoppedAnimation<Color>(
        mainColor,
      ),
    );
  }
}
