import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';

class AddCourseEditeWidget extends StatelessWidget {
  const AddCourseEditeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).pop();
      },
      child: Row(
        children: [
          const Icon(
            Icons.edit,
            color: KMainColor,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            "تعديل",
            style: AppTextStyles.semiBold14.copyWith(color: KMainColor),
          )
        ],
      ),
    );
  }
}
