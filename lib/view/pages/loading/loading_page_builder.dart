import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/assets.gen.dart';
import '../../components/circular_progress_indicator/app_circular_progress_indicator.dart';
import '../../components/text/app_text_widget.dart';
import '../../resources/colors/app_colors.dart';

///For animation transition
ValueNotifier<bool> _redirectBusy = ValueNotifier(false);

///Listens app is busy or not
ValueNotifier<Map<String, dynamic>> appBusy = ValueNotifier({
  "busy": false,
  "message": null,
});

///Updates app status
void setBusy(bool value, [String? message]) {
  appBusy.value = {"busy": value, "message": message};
}


Future<void> addDelay(Function() func, {int delayTime = 100}) async {
  await Future.delayed(Duration(milliseconds: delayTime), func);
}

class LoadingPageBuilder {
  static TransitionBuilder init({TransitionBuilder? builder}) {
    return (BuildContext context, Widget? child) {
      if (builder != null) {
        return builder(context, LoadingDialog(child: child!));
      } else {
        return LoadingDialog(child: child!);
      }
    };
  }
}

class LoadingDialog extends StatelessWidget {
  final Widget child;

  const LoadingDialog({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = context.getSize;
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _redirectBusy,
        builder: (context, ignoring, child) {
          return Stack(
            children: [
              this.child,
              Positioned.fill(
                child: ValueListenableBuilder<Map<String, dynamic>>(
                  valueListenable: appBusy,
                  builder: (context, opacityVal, child) {
                    return IgnorePointer(
                      ignoring: !opacityVal['busy'],
                      child: TweenAnimationBuilder<Color?>(
                        tween: ColorTween(
                          begin: opacityVal['busy'] ? Colors.transparent : Colors.black87,
                          end: opacityVal['busy'] ? Colors.black87 : Colors.transparent,
                        ),
                        onEnd: () {
                          if (!appBusy.value['busy']) {
                            _redirectBusy.value = true;
                          } else {
                            _redirectBusy.value = false;
                          }
                        },
                        duration: const Duration(milliseconds: 300),
                        builder: (context, color, child) {
                          return Container(color: color);
                        },
                      ),
                    );
                  },
                ),
              ),
              ValueListenableBuilder<Map<String, dynamic>>(
                valueListenable: appBusy,
                builder: (context, opacityVal, child) {
                  return IgnorePointer(
                    ignoring: !opacityVal['busy'],
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: opacityVal['busy'] ? 1 : 0,
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Assets.images.garbageLorry.path,
                              width: size.width,
                              height: size.height * 0.15,
                              fit: BoxFit.contain,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
                              child: AppTextWidget(
                                text: opacityVal['message'] ?? 'Yükleniyor...',
                                textColor: AppColors.kcLightModeMain,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const AppCircularProgressIndicator(),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
