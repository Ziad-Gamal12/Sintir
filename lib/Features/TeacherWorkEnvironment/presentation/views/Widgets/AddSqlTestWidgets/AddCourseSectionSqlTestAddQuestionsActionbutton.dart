import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursSectionsListItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/navigateSQlReviewRequirmentsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/ReviewSQlExamView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/AddCourseSectionCubit/AddCourseSectionCubit.dart';
import 'package:sintir/constant.dart';

class AddCourseSectionSqlTestActionbuttons extends StatelessWidget {
  const AddCourseSectionSqlTestActionbuttons({
    super.key,
    required this.courseEntity,
  });
  final CourseEntity courseEntity;
  @override
  Widget build(BuildContext context) {
    CoursSectionsListItemEntity section =
        context.read<AddCourseSectionCubit>().coursSectionsListItemEntity;
    Coursetestentity courseTestEntity =
        context.read<AddCourseSectionCubit>().coursetestentity;
    return Positioned(
        bottom: 40,
        right: 0,
        left: 0,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                navigatetoReviewTestView(section, courseTestEntity, context);
              },
              child: CircleAvatar(
                radius: 35,
                backgroundColor: KMainColor,
                child: Transform.rotate(
                    angle: -25,
                    child: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: Colors.white)),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                context.read<AddCourseSectionCubit>().addNewQuestion();
              },
              child: const CircleAvatar(
                radius: 35,
                backgroundColor: KSecondaryColor,
                child: Icon(Icons.add, color: Colors.white),
              ),
            ),
          ],
        ));
  }

  void navigatetoReviewTestView(CoursSectionsListItemEntity section,
      Coursetestentity courseTestEntity, BuildContext context) {
    if (Variables.AddCourseSectionSQLtestFormKey.currentState!.validate()) {
      Variables.AddCourseSectionSQLtestFormKey.currentState!.save();
      GoRouter.of(context).push(Reviewsqlexamview.routeName,
          extra: Navigatesqlreviewrequirmentsentity(
              coursetestentity: courseTestEntity,
              section: section,
              courseEntity: courseEntity));
    }
  }
}
