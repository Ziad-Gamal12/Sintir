import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/Managers/Cubits/course_coupons_cubit/course_coupons_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CourseCouponGridViewItemExpiry extends StatelessWidget {
  const CourseCouponGridViewItemExpiry(
      {super.key, required this.couponEntity, required this.courseId});
  final CourseCouponEntity couponEntity;
  final String courseId;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color primaryTextColor = theme.textTheme.bodyLarge!.color!;
    final Color deleteIconColor = theme.colorScheme.error;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Expiry Date Text
        Expanded(
          child: Text(
            "${LocaleKeys.expiresIn}: ${couponEntity.expiryDate.day} / ${couponEntity.expiryDate.month} / ${couponEntity.expiryDate.year}",
            style: AppTextStyles(context)
                .regular14
                .copyWith(color: primaryTextColor),
            overflow: TextOverflow.ellipsis,
          ),
        ),

        // Delete Button / Loading Indicator
        BlocSelector<CourseCouponsCubit, CourseCouponsState, bool>(
          selector: (state) {
            return state is DeleteCourseCouponLoading;
          },
          builder: (context, state) {
            if (state) {
              return const CircularProgressIndicator(
                color: Colors.red,
              );
            }

            return IconButton(
              onPressed: () {
                context.read<CourseCouponsCubit>().deleteCourseCoupon(
                    couponID: couponEntity.code, courseID: courseId);
              },
              icon: const Icon(
                FontAwesomeIcons.trash,
                color: Colors.red,
                size: 20,
              ),
            );
          },
        ),
      ],
    );
  }
}
