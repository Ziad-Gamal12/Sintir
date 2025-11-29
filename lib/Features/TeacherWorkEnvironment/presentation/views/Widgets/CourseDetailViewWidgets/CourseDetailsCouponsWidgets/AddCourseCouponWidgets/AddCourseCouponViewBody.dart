import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Managers/Cubits/course_coupons_cubit/course_coupons_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/AddCourseCouponWidgets/add_course_coupon_code_field.dart.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

import 'add_course_coupon_button.dart';
import 'add_course_coupon_discount_field.dart';
import 'add_course_coupon_expiry_field.dart';
import 'add_course_coupon_usage_limit_field.dart';

class AddCourseCouponViewBody extends StatefulWidget {
  const AddCourseCouponViewBody({super.key, required this.courseId});
  final String courseId;
  @override
  State<AddCourseCouponViewBody> createState() =>
      _AddCourseCouponViewBodyState();
}

class _AddCourseCouponViewBodyState extends State<AddCourseCouponViewBody> {
  DateTime? pickedDate;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> showDatePickerDialog() async {
    final value = await showDatePicker(
      context: context,
      firstDate: DateTime(1990),
      lastDate: DateTime(2100),
    );
    if (value != null) {
      setState(() => pickedDate = value);
      if (mounted) {
        context.read<CourseCouponEntity>().expiryDate = pickedDate!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CourseCouponsCubit, CourseCouponsState>(
      listener: (context, state) {
        if (state is AddCourseCouponSuccess) {
          GoRouter.of(context).pop();
          CustomSnackBar.show(
            context,
            message: LocaleKeys.couponAddedSuccessfully,
            type: SnackType.success,
          );
        } else if (state is AddCourseCouponFailure) {
          CustomSnackBar.show(
            context,
            message: state.errmessage,
            type: SnackType.error,
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: KVerticalPadding,
          horizontal: KHorizontalPadding,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const AddCourseCouponCodeField(),
              const SizedBox(height: 20),
              const AddCourseCouponDiscountField(),
              const SizedBox(height: 20),
              AddCourseCouponExpiryField(
                  pickedDate: pickedDate, onTap: () => showDatePickerDialog()),
              const SizedBox(height: 20),
              const AddCourseCouponUsageLimitField(),
              const Spacer(),
              AddCourseCouponButton(
                formKey: _formKey,
                courseID: widget.courseId,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
