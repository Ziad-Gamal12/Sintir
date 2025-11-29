import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CourseCouponGridViewItemIsExpired.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CourseCouponGridViewItemIsInActive.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CourseCouponGridViewItemIsUsed.dart';
import 'package:sintir/locale_keys.dart';

class CourseCouponGridViewItemCode extends StatelessWidget {
  const CourseCouponGridViewItemCode({super.key, required this.couponEntity});
  final CourseCouponEntity couponEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Clipboard.setData(ClipboardData(text: couponEntity.code));
            CustomSnackBar.show(
              context,
              message: LocaleKeys.operationSuccessful,
              type: SnackType.success,
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.copy, color: Colors.grey, size: 20),
              const SizedBox(width: 10),
              Text(
                couponEntity.code,
                style: AppTextStyles(context)
                    .regular21
                    .copyWith(color: Colors.red),
              ),
            ],
          ),
        ),
        if (couponEntity.isExpired)
          const CourseCouponGridViewItemIsExpired()
        else if (couponEntity.usageLimit == 0)
          const CourseCouponGridViewItemIsUsed()
        else if (couponEntity.isActive == false)
          const CourseCouponGridViewItemIsInActive(),
      ],
    );
  }
}
