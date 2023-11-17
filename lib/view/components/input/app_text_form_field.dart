import 'package:flutter/material.dart';

import '../../resources/colors/app_colors.dart';

class AppTextFormField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Color iconColor, textColor;
  final TextEditingController controller;
  final int validLength;
  final int? maxLength;
  final String? containElement;
  final RegExp? notContainElement;
  final String? invalidErrText;
  final String emptyErrText;
  final bool isPass, isReadOnly;
  final Widget? iconWidget;
  final Function? onTap;

  const AppTextFormField({
    Key? key,
    required this.hint,
    required this.controller,
    required this.emptyErrText,
    this.icon = Icons.email_outlined,
    this.iconColor = Colors.white,
    this.textColor = Colors.black,
    this.validLength = 5,
    this.maxLength,
    this.containElement,
    this.invalidErrText,
    this.isPass = false,
    this.isReadOnly = false,
    this.iconWidget,
    this.onTap,
    this.notContainElement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> obscureText = ValueNotifier(true);

    return ValueListenableBuilder(
      valueListenable: obscureText,
      builder: (context, obscure, child) {
        return TextFormField(
          onTap: () {
            if (onTap != null) {
              onTap!();
            }
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLength: maxLength,
          controller: controller,
          obscureText: isPass ? obscureText.value : false,
          readOnly: isReadOnly,
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.transparent,
            contentPadding: const EdgeInsets.all(8),
            hintText: hint,
            focusColor: AppColors.kcLightModeMain,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black54,
              ),
            ),
            suffixIcon: isPass
                ? IconButton(
                    icon: obscure ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                    onPressed: () {
                      obscureText.value = !obscure;
                    },
                  )
                : null,
            suffixIconColor: const Color(0xFF505050),
            prefixIcon: Container(
              margin: const EdgeInsets.only(
                right: 8,
                bottom: 12,
              ),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: iconColor,
                    width: 2,
                  ),
                ),
              ),
              child: iconWidget ??
                  Icon(
                    icon,
                    color: iconColor,
                  ),
            ),
          ),
          validator: (value) {
            if (value != null && value.length > validLength && value.trim().isNotEmpty) {
              if (notContainElement != null) {
                if (value.contains(notContainElement!)) {
                  return invalidErrText;
                } else {
                  if (containElement != null) {
                    if (value.contains(containElement!)) {
                      return null;
                    } else {
                      return invalidErrText;
                    }
                  } else {
                    return null;
                  }
                }
              } else {
                if (containElement != null) {
                  if (value.contains(containElement!)) {
                    return null;
                  } else {
                    return invalidErrText;
                  }
                } else {
                  return null;
                }
              }
            } else {
              return emptyErrText;
            }
          },
        );
      },
    );
  }
}
