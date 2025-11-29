import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/Managers/Cubits/course_coupons_cubit/course_coupons_cubit.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/locale_keys.dart';

class SubscribtionViewBodyCouponTextFieldSection extends StatelessWidget {
  const SubscribtionViewBodyCouponTextFieldSection({
    super.key,
    required this.courseID,
  });

  final String courseID;

  @override
  Widget build(BuildContext context) {
    return SubscribtionViewBodyCouponTextField(courseID: courseID);
  }
}

class SubscribtionViewBodyCouponTextField extends StatefulWidget {
  const SubscribtionViewBodyCouponTextField({
    super.key,
    required this.courseID,
  });

  final String courseID;

  @override
  State<SubscribtionViewBodyCouponTextField> createState() =>
      _SubscribtionViewBodyCouponTextFieldState();
}

class _SubscribtionViewBodyCouponTextFieldState
    extends State<SubscribtionViewBodyCouponTextField> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String couponCode = "";

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CourseCouponsCubit, CourseCouponsState, bool>(
      selector: (state) => state is IsCouponExistLoading,
      builder: (context, isLoading) {
        return Form(
          key: formKey,
          child: CustomTextField(
            hintText: LocaleKeys.couponDiscount,
            obscureText: false,
            textInputType: TextInputType.text,
            prefixIcon: FontAwesomeIcons.tags,
            onSaved: (val) => couponCode = val?.trim() ?? "",
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return LocaleKeys.fieldCannotBeEmpty;
              }
              return null;
            },
            suffixIcon: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: Colors.black,
                      size: 20,
                    ),
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        formKey.currentState!.save();
                        context.read<CourseCouponsCubit>().isCouponExists(
                              couponCode: couponCode,
                              courseID: widget.courseID,
                            );
                      }
                    },
                  ),
          ),
        );
      },
    );
  }
}
