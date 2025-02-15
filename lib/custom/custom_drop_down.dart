import 'package:flutter/material.dart';
import 'package:real_estate_app/utils/constant.dart';

class CustomDropDown extends StatefulWidget {
  final String hintText;
  const CustomDropDown({super.key, required this.hintText});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  int? countValue;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    List<int> count = List.generate(10, (index) => index + 1);
    return Container(
      width: 185,
      decoration: BoxDecoration(
          color: COLOR_GREY, borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: DropdownButtonFormField(
          /// this will remove the underline below the dropdown
          decoration: const InputDecoration.collapsed(hintText: ''),
          autovalidateMode: AutovalidateMode.always,
          iconSize: 25,
          iconDisabledColor: Colors.white,
          iconEnabledColor: Colors.white,
          menuMaxHeight: 200,
          borderRadius: BorderRadius.circular(15),
          enableFeedback: true,
          style: themeData.textTheme.headlineSmall,
          value: countValue,
          dropdownColor: COLOR_BLACK,
          hint: Text(
            widget.hintText,
            style: const TextStyle(
                color: COLOR_WHITE, fontWeight: FontWeight.w400, fontSize: 15),
          ),
          onChanged: (int? newValue) {
            setState(() {
              countValue = newValue;
            });
          },
          icon: const Icon(Icons.arrow_drop_down),
          items: count.map(
            (e) {
              return DropdownMenuItem(
                  value: e,
                  child: Text(
                    e.toString(),
                    style: const TextStyle(
                        color: COLOR_WHITE,
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  ));
            },
          ).toList(),
        ),
      ),
    );
  }
}
