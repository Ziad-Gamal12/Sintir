import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';

class AddCourseCouponDiscountField extends StatelessWidget {
  const AddCourseCouponDiscountField({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: "يرجى كتابه قيمة خصم الكوبون هنا ...",
      obscureText: false,
      prefixIcon: Icons.percent,
      textInputType: TextInputType.number,
      onSaved: (val) {
        context.read<CourseCouponEntity>().discountPercentage =
            double.tryParse(val ?? "") ?? 0;
      },
      validator: (val) {
        if (val == null || val.isEmpty) {
          return "ادخل قيمة خصم الكوبون";
        }
        return null;
      },
    );
  }
}
