import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Managers/Cubits/course_coupons_cubit/course_coupons_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/responsive/breakpoints.dart';
import 'package:sintir/Core/responsive/max_width_box.dart';
import 'package:sintir/Core/widgets/AdaptiveFormRow.dart';
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
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
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
          // Hand the saved coupon back so the coupons list shows it at once.
          GoRouter.of(context).pop(context.read<CourseCouponEntity>());
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
      child: Form(
        key: _formKey,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= Breakpoints.medium;
            final button = AddCourseCouponButton(
              formKey: _formKey,
              courseID: widget.courseId,
            );
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      KHorizontalPadding,
                      KVerticalPadding,
                      KHorizontalPadding,
                      KVerticalPadding,
                    ),
                    child: MaxWidthBox(
                      child: Column(
                        children: [
                          const AdaptiveFormRow(
                            runSpacing: 20,
                            children: [
                              AddCourseCouponCodeField(),
                              AddCourseCouponDiscountField(),
                            ],
                          ),
                          const SizedBox(height: 20),
                          AdaptiveFormRow(
                            runSpacing: 20,
                            children: [
                              AddCourseCouponExpiryField(
                                pickedDate: pickedDate,
                                onTap: () => showDatePickerDialog(),
                              ),
                              const AddCourseCouponUsageLimitField(),
                            ],
                          ),
                          if (isWide) ...[
                            const SizedBox(height: 32),
                            button,
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
                if (!isWide)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      KHorizontalPadding,
                      0,
                      KHorizontalPadding,
                      KVerticalPadding,
                    ),
                    child: button,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
