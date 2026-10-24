import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
// Core
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/Managers/Cubits/course_coupons_cubit/course_coupons_cubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCourseHorizontalItem/CustomCourseHorizintalItem.dart';
import 'package:sintir/Core/widgets/WebViewer/WebView.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/PayMobWebViewRequirmentsEntity.dart';
// Features
import 'package:sintir/Features/Subscribtion/Presentation/View/Widgets/SubscribtionViewBodyActionButton.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/Widgets/SubscribtionViewBodyCouponTextField.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/Widgets/SubscribtionViewBodyCourseDetailsTitle.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/Widgets/SubscribtionViewBodyDiscountDetailsSection.dart';
// Constants
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class SubscribtionViewBody extends StatefulWidget {
  const SubscribtionViewBody({
    super.key,
    required this.requirmentsEntity,
  });

  final DisplayCourseBottomsheetNavigationRequirmentsEntity requirmentsEntity;

  @override
  State<SubscribtionViewBody> createState() => _SubscribtionViewBodyState();
}

class _SubscribtionViewBodyState extends State<SubscribtionViewBody> {
  CourseCouponEntity? coupon;

  /// Returns the selected coupon only while it is usable.
  ///
  /// The same result is passed to the price section and action button,
  /// preventing them from displaying different coupon selections.
  CourseCouponEntity? _getUsableCoupon() {
    final selectedCoupon = coupon;

    if (selectedCoupon == null) {
      return null;
    }

    final couponCubit = context.read<CourseCouponsCubit>();

    return couponCubit.isCouponUsable(selectedCoupon) ? selectedCoupon : null;
  }

  @override
  Widget build(BuildContext context) {
    final course = widget.requirmentsEntity.course;

    final selectedCoupon = _getUsableCoupon();

    final double payableAmount = selectedCoupon != null
        ? selectedCoupon.applyDiscount(course.price)
        : course.price.toDouble();

    return MultiBlocListener(
      listeners: [
        BlocListener<CourseSubscribtionsCubit, CourseSubscribtionsState>(
          listener: (context, state) {
            switch (state) {
              case PayWithWalletSuccess(:final response):
                context.push(
                  Webviewer.routeName,
                  extra: PayMobWebViewRequirmentsEntity(
                    course: course,
                    payMobResponse: response,
                  ),
                );
                break;

              case PayWithWalletFailure(:final errMessage):
                CustomSnackBar.show(
                  context,
                  message: errMessage,
                  type: SnackType.error,
                );
                break;

              default:
                break;
            }
          },
        ),
        BlocListener<CourseCouponsCubit, CourseCouponsState>(
          listener: (context, state) {
            switch (state) {
              case IsCouponExistLoading():
                // Do not keep applying the previous coupon
                // while another coupon code is being validated.
                setState(() {
                  coupon = null;
                });
                break;

              case IsCouponExistSuccess(:final coupon):
                final couponCubit = context.read<CourseCouponsCubit>();

                if (!couponCubit.isCouponUsable(coupon)) {
                  setState(() {
                    this.coupon = null;
                  });

                  CustomSnackBar.show(
                    context,
                    message: LocaleKeys.invalidCoupon,
                    type: SnackType.error,
                  );

                  return;
                }

                setState(() {
                  this.coupon = coupon;
                });
                break;

              case IsCouponExistFailure(:final errmessage):
                setState(() {
                  coupon = null;
                });

                CustomSnackBar.show(
                  context,
                  message: errmessage,
                  type: SnackType.error,
                );
                break;

              case UseCouponSuccess():
                final selectedCoupon = _getUsableCoupon();

                if (selectedCoupon == null) {
                  CustomSnackBar.show(
                    context,
                    message: LocaleKeys.invalidCoupon,
                    type: SnackType.error,
                  );
                  return;
                }

                context.read<CourseSubscribtionsCubit>().payWithWallet(
                      userEntity: getUserData(),
                      amount: selectedCoupon.applyDiscount(
                        course.price,
                      ),
                    );
                break;

              case UseCouponFailure(:final errmessage):
                CustomSnackBar.show(
                  context,
                  message: errmessage,
                  type: SnackType.error,
                );
                break;

              default:
                break;
            }
          },
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: KHorizontalPadding,
          vertical: KVerticalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SubscribtionViewBodyCourseDetailsTitle(),
            const SizedBox(height: 20),
            AspectRatio(
              aspectRatio: 16 / 10,
              child: CustomCourseHorizontalItem(
                course: course,
              ),
            ),
            Divider(
              color: Colors.grey.shade200,
              thickness: 2,
              height: 40,
            ),
            Text(
              LocaleKeys.discountedPrice,
              style: AppTextStyles(context).semiBold20,
            ),
            const SizedBox(height: 20),
            SubscribtionViewBodyCouponTextFieldSection(
              courseID: course.id,
            ),
            const SizedBox(height: 20),
            PremiumSubscriptionPriceSection(
              originalPrice: course.price,
              coupon: selectedCoupon,
              payableAmount: payableAmount,
            ),
            const Spacer(),
            SubscribtionViewBodyActionButton(
              courseID: course.id,
              coupon: selectedCoupon,
              amount: payableAmount,
            ),
          ],
        ),
      ),
    );
  }
}
