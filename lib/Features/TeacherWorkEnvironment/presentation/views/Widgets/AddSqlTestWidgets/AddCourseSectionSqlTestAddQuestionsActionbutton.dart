import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/navigateSQlReviewRequirmentsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/ReviewSqlTestSectionView.dart';
import 'package:sintir/constant.dart';

class AddCourseSectionSqlTestActionbuttons extends StatelessWidget {
  const AddCourseSectionSqlTestActionbuttons({
    super.key,
    required this.courseTestEntity,
  });
  final Coursetestentity courseTestEntity;
  @override
  Widget build(BuildContext context) {
    Optionnavigationrequirementsentity optionnavigationrequirementsentity =
        Provider.of<Optionnavigationrequirementsentity>(context);
    return Positioned(
        bottom: 40,
        right: 0,
        left: 0,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                navigatetoReviewTestView(optionnavigationrequirementsentity,
                    courseTestEntity, context);
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
                context
                    .read<CourseSectionsCubit>()
                    .addNewQuestion(coursetestentity: courseTestEntity);
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

  void navigatetoReviewTestView(
      Optionnavigationrequirementsentity optionnavigationrequirementsentity,
      Coursetestentity courseTestEntity,
      BuildContext context) {
    if (Variables.AddCourseSectionSQLtestFormKey.currentState!.validate()) {
      Variables.AddCourseSectionSQLtestFormKey.currentState!.save();
      GoRouter.of(context).push(ReviewSqlTestSectionView.routeName,
          extra: Navigatesqlreviewrequirmentsentity(
              coursetestentity: courseTestEntity,
              section: optionnavigationrequirementsentity.section,
              courseID: optionnavigationrequirementsentity.courseID));
    }
  }
}
