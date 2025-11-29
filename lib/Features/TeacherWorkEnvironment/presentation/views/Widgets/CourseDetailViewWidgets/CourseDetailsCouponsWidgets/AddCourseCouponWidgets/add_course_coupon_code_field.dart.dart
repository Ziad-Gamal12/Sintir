import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/locale_keys.dart';

class AddCourseCouponCodeField extends StatelessWidget {
  const AddCourseCouponCodeField({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: LocaleKeys.enterCouponCodeHere,
      obscureText: false,
      textInputType: TextInputType.text,
      prefixIcon: Icons.copy_rounded,
      onSaved: (val) {
        context.read<CourseCouponEntity>().code = val ?? "";
      },
      validator: (val) {
        if (val == null || val.isEmpty) {
          return LocaleKeys.enterCouponCode;
        }
        return null;
      },
    );
  }
}
