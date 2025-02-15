import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/widget_function.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String errorText;
  final FilteringTextInputFormatter? inputFormater;
  final TextStyle? textStyle;
  final String title;
  const CustomTextFormField(
      {super.key,
      required this.controller,
      this.hintText,
      required this.errorText,
      this.inputFormater,
      this.textStyle,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: textStyle),
        addVerticalSpace(10),
        TextFormField(
          controller: controller,
          validator: (value) {
            return (value != null && value.isEmpty) ? errorText : null;
          },
          inputFormatters: [
            inputFormater ?? FilteringTextInputFormatter.digitsOnly
          ],
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
              focusColor: Colors.green,
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              hintText: hintText,
              hintFadeDuration: const Duration(seconds: 3),
              errorBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
        ),
      ],
    );
  }
}
