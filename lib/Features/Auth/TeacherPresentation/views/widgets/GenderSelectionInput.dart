// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/constant.dart';

class GenderSelectionInput extends StatefulWidget {
  const GenderSelectionInput({
    super.key,
  });

  @override
  State<GenderSelectionInput> createState() => _GenderSelectionInputState();
}

class _GenderSelectionInputState extends State<GenderSelectionInput> {
  String radiovalue = "";
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Radio(
                  activeColor: KMainColor,
                  value: "ذكر",
                  groupValue: radiovalue,
                  onChanged: (val) {
                    setState(() {
                      radiovalue = val ?? "";
                    });
                    context.read<UserEntity>().gender = val ?? "";
                  }),
              const Customsizedbox(width: 20, height: 0),
              Text(
                "ذكر",
                style: AppTextStyles.bold14Auto
                    .copyWith(color: const Color(0xff818181)),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                  activeColor: KMainColor,
                  value: "أنثى",
                  groupValue: radiovalue,
                  onChanged: (val) {
                    setState(() {
                      radiovalue = val ?? "";
                    });
                    context.read<UserEntity>().gender = val ?? "";
                  }),
              const Customsizedbox(width: 20, height: 0),
              Text(
                "أنثى",
                style: AppTextStyles.bold14Auto
                    .copyWith(color: const Color(0xff818181)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
