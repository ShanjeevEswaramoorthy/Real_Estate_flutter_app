import 'package:flutter/material.dart';

import '../utils/constant.dart';

class BorderBoxUI extends StatelessWidget {
  final double? height, width;
  final void Function()? onTap;
  final IconData icons;
  const BorderBoxUI(
      {super.key, this.height, this.width, this.onTap, required this.icons});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: COLOR_GREY.withAlpha(40), width: 2),
            color: COLOR_WHITE),
        height: height,
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Icon(icons)),
        ),
      ),
    );
  }
}
