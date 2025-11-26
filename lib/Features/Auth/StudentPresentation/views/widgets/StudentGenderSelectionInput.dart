// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomRadioWidget.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/locale_keys.dart';

class StudentGenderSelectionInput extends StatefulWidget {
  const StudentGenderSelectionInput({
    super.key,
  });

  @override
  State<StudentGenderSelectionInput> createState() =>
      _StudentGenderSelectionInputState();
}

class _StudentGenderSelectionInputState
    extends State<StudentGenderSelectionInput> {
  String radiovalue = "";
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              CustomRadioWidget(
                  value: "Male",
                  groupValue: radiovalue,
                  onchange: (val) {
                    setState(() {
                      radiovalue = val ?? "";
                    });
                    context.read<UserEntity>().gender = val ?? "";
                  }),
              const SizedBox(
                width: 12,
              ),
              Text(
                LocaleKeys.male,
                style: AppTextStyles(context)
                    .bold16
                    .copyWith(color: const Color(0xff818181)),
              ),
            ],
          ),
          Row(
            children: [
              CustomRadioWidget(
                  value: "Female",
                  groupValue: radiovalue,
                  onchange: (val) {
                    setState(() {
                      radiovalue = val ?? "";
                    });
                    context.read<UserEntity>().gender = val ?? "";
                  }),
              const SizedBox(
                width: 12,
              ),
              Text(
                LocaleKeys.female,
                style: AppTextStyles(context)
                    .bold16
                    .copyWith(color: const Color(0xff818181)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
