import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../text/app_text_widget.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showGoBack, showNotification;
  final String title;
  final VoidCallback? openCloseDrawer;

  const AppAppBar({
    Key? key,
    required this.title,
    this.showGoBack = true,
    this.showNotification = true,
    this.openCloseDrawer,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    Size size = context.getSize;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(size.width * 0.04, size.height * 0.015, size.width * 0.04, size.height * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            showGoBack
                ? _rectangleBox(context: context, size: size, icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back, goBack: true)
                : _rectangleBoxDrawer(context: context, size: size),
            AppTextWidget(
              text: title,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              textColor: Colors.black,
            ),

                 SizedBox(width: size.width * 0.11),
          ],
        ),
      ),
    );
  }

  Widget _rectangleBox({required BuildContext context, required Size size, required IconData icon, required bool goBack, Widget? page}) {
    return GestureDetector(
      onTap: () => goBack ? context.pop() : context.push(page!),
      child: SizedBox.square(
        dimension: size.width * 0.11,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black26),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Center(
            child: Icon(icon),
          ),
        ),
      ),
    );
  }

  Widget _rectangleBoxDrawer({required BuildContext context, required Size size}) {
    return GestureDetector(
      onTap: openCloseDrawer,
      child: SizedBox.square(
        dimension: size.width * 0.11,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black26),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: const Center(
            child: Icon(Icons.dehaze_rounded),
          ),
        ),
      ),
    );
  }
}
