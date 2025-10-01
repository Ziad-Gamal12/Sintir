import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/navigateSQlReviewRequirmentsEntity.dart';

class CustomReviewSqlTestNameAndDuration extends StatelessWidget {
  const CustomReviewSqlTestNameAndDuration({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    CourseTestEntity coursetestentity =
        context.read<Navigatesqlreviewrequirmentsentity>().coursetestentity;
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: "عنوان الامتحان: ",
              style: AppTextStyles(context)
                  .semiBold20
                  .copyWith(color: Colors.black),
            ),
            TextSpan(
              text: coursetestentity.title,
              style:
                  AppTextStyles(context).regular16.copyWith(color: Colors.grey),
            ),
          ])),
        ),
        const Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        Expanded(
          flex: 2,
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: "مده الامتحان: ",
              style: AppTextStyles(context)
                  .semiBold20
                  .copyWith(color: Colors.black),
            ),
            TextSpan(
              text: "${coursetestentity.durationTime.toString()} دقيقة",
              style:
                  AppTextStyles(context).regular16.copyWith(color: Colors.grey),
            ),
          ])),
        )
      ],
    );
  }
}
