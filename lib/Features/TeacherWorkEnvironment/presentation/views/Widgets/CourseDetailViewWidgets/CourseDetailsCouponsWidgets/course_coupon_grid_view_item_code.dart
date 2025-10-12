import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CourseCouponGridViewItemCode extends StatelessWidget {
  const CourseCouponGridViewItemCode({super.key, required this.couponEntity});
  final CourseCouponEntity couponEntity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Clipboard.setData(ClipboardData(text: couponEntity.code));
        showSuccessSnackBar(context: context, message: "تم نسخ الكود بنجاح");
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.copy, color: Colors.grey, size: 20),
          const SizedBox(width: 10),
          Text(
            couponEntity.code,
            style: AppTextStyles(context).regular21.copyWith(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
