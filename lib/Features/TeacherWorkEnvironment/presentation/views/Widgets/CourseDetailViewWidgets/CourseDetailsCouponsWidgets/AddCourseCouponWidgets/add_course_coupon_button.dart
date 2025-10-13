import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/course_coupons_cubit/course_coupons_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/constant.dart';

class AddCourseCouponButton extends StatelessWidget {
  const AddCourseCouponButton(
      {super.key, required this.formKey, required this.courseID});
  final GlobalKey<FormState> formKey;
  final String courseID;
  @override
  Widget build(BuildContext context) {
    return BlocSelector<CourseCouponsCubit, CourseCouponsState, bool>(
      selector: (state) {
        return state is AddCourseCouponLoading;
      },
      builder: (context, state) {
        return Custom_Loading_Widget(
          isLoading: state,
          child: Custombutton(
            text: "إضافة",
            color: KMainColor,
            textColor: Colors.white,
            onPressed: () {
              if (formKey.currentState != null) {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  context.read<CourseCouponsCubit>().addCourseCoupon(
                      coupon: context.read<CourseCouponEntity>(),
                      courseID: courseID);
                }
              }
            },
          ),
        );
      },
    );
  }
}
