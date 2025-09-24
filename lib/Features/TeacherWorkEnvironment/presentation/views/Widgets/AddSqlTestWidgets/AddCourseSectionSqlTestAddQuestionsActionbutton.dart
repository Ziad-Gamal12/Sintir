import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/navigateSQlReviewRequirmentsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/ReviewSqlTestSectionView.dart';
import 'package:sintir/constant.dart';

class AddCourseSectionSqlTestActionbuttons extends StatelessWidget {
  const AddCourseSectionSqlTestActionbuttons({
    super.key,
    required this.courseTestEntity,
  });
  final CourseTestEntity courseTestEntity;
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
                    .read<TestItemCubit>()
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
      CourseTestEntity courseTestEntity,
      BuildContext context) {
    if (Variables.AddCourseSectionSQLtestFormKey.currentState!.validate()) {
      Variables.AddCourseSectionSQLtestFormKey.currentState!.save();
      GoRouter.of(context).push(ReviewSqlTestSectionView.routeName,
          extra: Navigatesqlreviewrequirmentsentity(
              isNewSection: optionnavigationrequirementsentity.isNewSection,
              coursetestentity: courseTestEntity,
              section: optionnavigationrequirementsentity.section,
              courseID: optionnavigationrequirementsentity.courseID));
    }
  }
}
