import 'package:flutter/material.dart';
import 'package:real_estate_app/utils/constant.dart';

class LeadingIconWithText extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onPressed;
  const LeadingIconWithText(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return TextButton(
        style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(COLOR_WHITE.withAlpha(55)),
            backgroundColor: const WidgetStatePropertyAll(COLOR_DARK_BLUE)),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: COLOR_WHITE,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: themeData.textTheme.bodyMedium,
              )
            ],
          ),
        ));
  }
}
