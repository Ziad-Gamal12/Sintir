import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/Managers/Cubits/course_coupons_cubit/course_coupons_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class SubscribtionViewBodyActionButton extends StatelessWidget {
  const SubscribtionViewBodyActionButton({
    super.key,
    required this.amount,
    required this.courseID,
    this.coupon,
  });

  final double amount;
  final String courseID;
  final CourseCouponEntity? coupon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<CourseCouponsCubit, CourseCouponsState>(
          builder: (context, state) {
            if (state is IsCouponExistLoading || state is UseCouponLoading) {
              return Text(
                LocaleKeys.applyingCoupon,
                style: AppTextStyles(context)
                    .regular16
                    .copyWith(color: Colors.grey),
              );
            } else if (state is IsCouponExistSuccess) {
              return Text(
                LocaleKeys.couponApplied,
                style: AppTextStyles(context)
                    .regular16
                    .copyWith(color: Colors.green),
              );
            } else if (state is IsCouponExistFailure) {
              return Text(
                state.errmessage,
                style: AppTextStyles(context)
                    .regular16
                    .copyWith(color: Colors.red),
              );
            } else {
              return Container();
            }
          },
        ),
        const SizedBox(height: 10),
        BlocSelector<CourseSubscribtionsCubit, CourseSubscribtionsState, bool>(
          selector: (state) {
            return state is PayWithWalletLoading;
          },
          builder: (context, state) {
            return Custom_Loading_Widget(
              isLoading: state,
              child: Custombutton(
                text: LocaleKeys.subscribeNow,
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
    final user = getUserData();

    if (coupon != null) {
      context.read<CourseCouponsCubit>().useCoupon(
            coupon: coupon!,
            courseID: courseID,
          );
    } else {
      context.read<CourseSubscribtionsCubit>().payWithWallet(
            userEntity: user,
            amount: amount,
          );
    }
  }
}
