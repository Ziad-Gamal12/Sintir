import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class Taskslistviewheader extends StatefulWidget {
  const Taskslistviewheader({super.key});

  @override
  State<Taskslistviewheader> createState() => _TaskslistviewheaderState();
}

class _TaskslistviewheaderState extends State<Taskslistviewheader> {
  String? currentvalue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "المهام الخاص بى",
          style: AppTextStyles.bold20Auto.copyWith(color: Colors.black),
        ),
        const Spacer(),
        DropdownButton(
            value: currentvalue,
            dropdownColor: Colors.white,
            hint: const Text("غير مكتملة"),
            style: AppTextStyles.semiBold12.copyWith(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
            alignment: AlignmentDirectional.center,
            elevation: 3,
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
            onChanged: (value) {
              currentvalue = value;
              setState(() {});
            })
      ],
    );
  }
}
