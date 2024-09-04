import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Core/widgets/CustomTeaxtField.dart';

class ExperienceAndPhotoInput extends StatelessWidget {
  const ExperienceAndPhotoInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Customteaxtfield(
              hintText: "عدد سنين الخبرة",
              prefixIcon: Icons.work_history_outlined,
              obscureText: false,
              controller: Variables.TeacherSigninWorkExperienceController,
              textInputType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return "ادخل عدد سنين الخبرة الخاصة بك";
                }
                return null;
              }),
          const Customsizedbox(width: 0, height: 10),
          Container(
            alignment: Alignment.center,
            height: 40,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 1)),
            child: Row(
              children: [
                const Icon(Icons.upload),
                Text(
                  "الصورة الشخصية",
                  style: AppTextStyles.bold13
                      .copyWith(color: const Color(0xff818181)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
