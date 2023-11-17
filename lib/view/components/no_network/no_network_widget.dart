import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../text/app_text_widget.dart';

class NoNetworkWidget extends StatefulWidget {
  const NoNetworkWidget({super.key});

  @override
  State<NoNetworkWidget> createState() => _NoNetworkWidgetState();
}

class _NoNetworkWidgetState extends State<NoNetworkWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = context.getSize;
    return Container(
      height: size.height * 0.045,
      color: Colors.black87,
      child: Center(
        child: AppTextWidget(
          text: 'İnternet bağlantısı koptu',
          style: TextStyle(
            fontSize: 15.sp,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
