import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
// Core
import 'package:sintir/Core/Managers/Cubits/course_checkout_cubit/course_checkout_cubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCourseHorizontalItem/CustomCourseHorizintalItem.dart';
import 'package:sintir/Core/widgets/WebViewer/WebView.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/PayMobWebViewRequirmentsEntity.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/PayMobResponse.dart';
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
  String? couponCode;
  int? quoteAmountCents;
  double discountPercent = 0;

  @override
  Widget build(BuildContext context) {
    final course = widget.requirmentsEntity.course;

    final double payableAmount = (quoteAmountCents ?? course.price * 100) / 100;

    return MultiBlocListener(
      listeners: [
        BlocListener<CourseCheckoutCubit, CourseCheckoutState>(
          listener: (context, state) {
            if (state is CourseCheckoutCreated) {
              context.push(Webviewer.routeName, extra: PayMobWebViewRequirmentsEntity(
                course: course,
                payMobResponse: PayMobResponse(
                  url: state.attempt.checkoutUrl,
                  paymentAttemptId: state.attempt.id,
                  status: state.attempt.status,
                ),
              ));
            } else if (state is CourseCheckoutQuoteReady) {
              setState(() {
                quoteAmountCents = state.quote.amountCents;
                discountPercent = state.quote.discountPercentage;
                couponCode = state.quote.couponCode;
              });
            } else if (state is CourseCheckoutFailure) {
              setState(() {
                quoteAmountCents = null;
                discountPercent = 0;
                couponCode = null;
              });
              CustomSnackBar.show(context, message: state.message, type: SnackType.error);
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
              discountPercent: discountPercent,
              payableAmount: payableAmount,
            ),
            const Spacer(),
            SubscribtionViewBodyActionButton(
              courseID: course.id,
              couponCode: couponCode,
            ),
          ],
        ),
      ),
    );
  }
}
