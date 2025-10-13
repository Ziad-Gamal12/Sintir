import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';

class AddCourseCouponUsageLimitField extends StatelessWidget {
  const AddCourseCouponUsageLimitField({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: "يرجى كتابه عدد الكوبونات هنا ...",
      obscureText: false,
      textInputType: TextInputType.number,
      prefixIcon: Icons.numbers,
      onSaved: (val) {
        context.read<CourseCouponEntity>().usageLimit =
            int.tryParse(val ?? "") ?? 0;
      },
      validator: (val) {
        if (val == null || val.isEmpty) {
          return "ادخل عدد الكوبونات";
        }
        return null;
      },
    );
  }
}
