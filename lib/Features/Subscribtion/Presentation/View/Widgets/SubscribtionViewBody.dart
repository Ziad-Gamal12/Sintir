import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Core
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/Managers/Cubits/course_coupons_cubit/course_coupons_cubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/entities/PayMobWebViewRequirmentsEntity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/widgets/WebViewer/WebView.dart';

// Features
import 'package:sintir/Features/Subscribtion/Presentation/View/Widgets/SubscribtionViewBodyActionButton.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/Widgets/SubscribtionViewBodyCouponTextField.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/Widgets/SubscribtionViewBodyCourseDetailsTitle.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/Widgets/SubscribtionViewBodyDiscountDetailsSection.dart';

// Constants
import 'package:sintir/constant.dart';

class SubscribtionViewBody extends StatefulWidget {
  const SubscribtionViewBody({super.key, required this.requirmentsEntity});

  final DisplayCourseBottomsheetNavigationRequirmentsEntity requirmentsEntity;

  @override
  State<SubscribtionViewBody> createState() => _SubscribtionViewBodyState();
}

class _SubscribtionViewBodyState extends State<SubscribtionViewBody> {
  CourseCouponEntity? coupon;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        /// Listen for payment-related states
        BlocListener<CourseSubscribtionsCubit, CourseSubscribtionsState>(
          listener: (context, state) {
            switch (state) {
              case PayWithWalletSuccess(:final response):
                GoRouter.of(context).push(
                  Webviewer.routeName,
                  extra: PayMobWebViewRequirmentsEntity(
                    course: widget.requirmentsEntity.course,
                    payMobResponse: response,
                  ),
                );
                break;

              case PayWithWalletFailure(:final errMessage):
                ShowErrorSnackBar(context: context, message: errMessage);
                break;

              default:
                break;
            }
          },
        ),

        /// Listen for coupon-related states
        BlocListener<CourseCouponsCubit, CourseCouponsState>(
          listener: (context, state) {
            switch (state) {
              case IsCouponExistSuccess(:final coupon):
                if (!coupon.isActive || coupon.isExpired) {
                  ShowErrorSnackBar(
                    context: context,
                    message: "هذا الكوبون غير صالح",
                  );
                  return;
                }
                setState(() => this.coupon = coupon);
                break;

              case IsCouponExistFailure(:final errmessage):
                ShowErrorSnackBar(context: context, message: errmessage);
                break;

              case UseCouponSuccess():
                context.read<CourseSubscribtionsCubit>().payWithWallet(
                      userEntity: getUserData(),
                      amount: coupon!.applyDiscount(
                        widget.requirmentsEntity.course.price.toDouble(),
                      ),
                    );
                break;

              case UseCouponFailure(:final errmessage):
                ShowErrorSnackBar(context: context, message: errmessage);
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

            /// Coupon Text Field
            SubscribtionViewBodyCouponTextFieldSection(
              courseID: widget.requirmentsEntity.course.id,
            ),
            const SizedBox(height: 20),

            /// Course Price Details
            SubscribtionViewBodyDiscountDetailsSection(
              requirmentsEntity: widget.requirmentsEntity,
            ),

            const Spacer(),

            /// Action Button
            SubscribtionViewBodyActionButton(
              courseID: widget.requirmentsEntity.course.id,
              coupon: coupon,
              amount: coupon?.applyDiscount(
                    widget.requirmentsEntity.course.price.toDouble(),
                  ) ??
                  widget.requirmentsEntity.course.price.toDouble(),
            ),
          ],
        ),
      ),
    );
  }
}
