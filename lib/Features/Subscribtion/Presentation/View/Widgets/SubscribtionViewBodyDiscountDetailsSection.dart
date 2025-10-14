import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/Managers/Cubits/course_coupons_cubit/course_coupons_cubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/Widgets/SubscribtionViewBodyPriceRow.dart';

class SubscribtionViewBodyDiscountDetailsSection extends StatelessWidget {
  const SubscribtionViewBodyDiscountDetailsSection({
    super.key,
    required this.requirmentsEntity,
  });

  final DisplayCourseBottomsheetNavigationRequirmentsEntity requirmentsEntity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseCouponsCubit, CourseCouponsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubscribtionViewBodyPriceRow(
              icon: FontAwesomeIcons.dollarSign,
              label: "السعر الاصلي: ",
              value: "${requirmentsEntity.course.price} جنيه",
            ),
            const SizedBox(height: 10),
            SubscribtionViewBodyPriceRow(
              icon: FontAwesomeIcons.dollarSign,
              label: "السعر بعد الخصم: ",
              value: state is IsCouponExistSuccess
                  ? "${state.coupon.applyDiscount(requirmentsEntity.course.price.toDouble()).toStringAsFixed(1)} جنيه"
                  : "${requirmentsEntity.course.price} جنيه",
            ),
            const SizedBox(height: 10),
            SubscribtionViewBodyPriceRow(
              icon: FontAwesomeIcons.percent,
              label: "نسبة الخصم: ",
              value: state is IsCouponExistSuccess &&
                      state.coupon.isActive &&
                      !state.coupon.isExpired
                  ? "${state.coupon.discountPercentage.toStringAsFixed(1)} %"
                  : "0 %",
            ),
          ],
        );
      },
    );
  }
}
