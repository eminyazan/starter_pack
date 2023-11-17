import 'package:flutter/material.dart';

import '../../../view/components/text/app_text_widget.dart';
import '../../../view/resources/colors/app_colors.dart';

extension SnackBarExtension on BuildContext {
  createSnackBar(String content, [int second = 3]) {
    SnackBar snackBar = SnackBar(
      backgroundColor: AppColors.kcLightModeMain,
      content: AppTextWidget(
        text: content,
        textColor: Colors.white,
      ),
      duration: Duration(seconds: second),
    );

    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}
