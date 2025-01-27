import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/TeacherWorkenvironmentview.dart';
import 'package:sintir/constant.dart';

class CustomWorkEnvironmentText extends StatelessWidget {
  const CustomWorkEnvironmentText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).push(TeacherWorkenvironmentview.routeName);
      },
      child: Row(
        children: [
          Text(
            "بيئة العمل",
            style: AppTextStyles.semiBold14.copyWith(color: KMainColor),
          ),
          const SizedBox(
            width: 5,
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 15,
            color: KMainColor,
          ),
        ],
      ),
    );
  }
}
