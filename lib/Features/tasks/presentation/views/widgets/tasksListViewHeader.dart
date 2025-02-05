import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomDropdownButton.dart';
import 'package:sintir/Core/widgets/CustomListORGridTextHeader.dart';

class Taskslistviewheader extends StatefulWidget {
  const Taskslistviewheader({super.key});

  @override
  State<Taskslistviewheader> createState() => _TaskslistviewheaderState();
}

class _TaskslistviewheaderState extends State<Taskslistviewheader> {
  String? currentvalue;

  @override
  Widget build(BuildContext context) {
    return CustomListORGridTextHeader(
      text: "المهام الخاص بى",
      trailing: CustomDropdownButton(
        valueChanged: (value) {
          currentvalue = value;
        },
        hintText: "غير مكتملة",
        items: [
          DropdownMenuItem(
            value: "الكل",
            child: Text(
              "الكل",
              style: AppTextStyles.semiBold12.copyWith(color: Colors.black),
            ),
          ),
          DropdownMenuItem(
            value: "مكتملة",
            child: Text(
              "مكتملة",
              style: AppTextStyles.semiBold12.copyWith(color: Colors.black),
            ),
          ),
          DropdownMenuItem(
            value: "غير مكتملة",
            child: Text(
              "غير مكتملة",
              style: AppTextStyles.semiBold12.copyWith(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
