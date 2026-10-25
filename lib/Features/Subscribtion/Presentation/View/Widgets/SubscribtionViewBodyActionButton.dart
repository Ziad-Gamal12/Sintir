import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/course_checkout_cubit/course_checkout_cubit.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class SubscribtionViewBodyActionButton extends StatelessWidget {
  const SubscribtionViewBodyActionButton({
    super.key,
    required this.courseID,
    this.couponCode,
  });

  final String courseID;
  final String? couponCode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<CourseCheckoutCubit, CourseCheckoutState>(
          builder: (context, state) {
            if (state is CourseCheckoutLoading) {
              return Text(
                LocaleKeys.applyingCoupon,
                style: AppTextStyles(context)
                    .regular16
                    .copyWith(color: Colors.grey),
              );
            } else if (state is CourseCheckoutQuoteReady) {
              return Text(
                LocaleKeys.couponApplied,
                style: AppTextStyles(context)
                    .regular16
                    .copyWith(color: Colors.green),
              );
            } else if (state is CourseCheckoutFailure) {
              return Text(
                state.message,
                style: AppTextStyles(context)
                    .regular16
                    .copyWith(color: Colors.red),
              );
            } else if (state is CourseCheckoutRecoveryRequired) {
              return Text(
                state.message,
                style: AppTextStyles(context)
                    .regular16
                    .copyWith(color: Colors.orange.shade800),
              );
            } else if (state is CourseCheckoutReviewRequired) {
              return Text(
                state.message,
                style: AppTextStyles(context)
                    .regular16
                    .copyWith(color: Colors.orange.shade800),
              );
            } else {
              return Container();
            }
          },
        ),
        const SizedBox(height: 10),
        BlocSelector<CourseCheckoutCubit, CourseCheckoutState, bool>(
          selector: (state) {
            return state is CourseCheckoutLoading;
          },
          builder: (context, state) {
            return Custom_Loading_Widget(
              isLoading: state,
              child: Custombutton(
                text: context.select<CourseCheckoutCubit, String>((cubit) {
                  final current = cubit.state;
                  if (current is CourseCheckoutRecoveryRequired) {
                    return LocaleKeys.retryCheckout;
                  }
                  if (current is CourseCheckoutReviewRequired) {
                    return LocaleKeys.checkPaymentStatus;
                  }
                  return LocaleKeys.subscribeNow;
                }),
                color: KSecondaryColor,
                textColor: Colors.white,
                onPressed: () => _handleSubscription(context),
              ),
            );
          },
        ),
      ],
    );
  }

  void _handleSubscription(BuildContext context) {
    context.read<CourseCheckoutCubit>().createPayment(
          courseID,
          couponCode: couponCode,
        );
  }
}
