import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/navigateExamReviewRequirmentsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/ReviewExamSectionView.dart';
import 'package:sintir/constant.dart';

class AddCourseSectionExamActionButtons extends StatelessWidget {
  const AddCourseSectionExamActionButtons({
    super.key,
    required this.courseTestEntity,
  });
  final CourseTestEntity courseTestEntity;
  @override
  Widget build(BuildContext context) {
    OptionNavigationRequirementsEntity optionnavigationrequirementsentity =
        Provider.of<OptionNavigationRequirementsEntity>(context);
    return Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        child: Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20,
                spreadRadius: 6,
                offset: Offset(5, -15),
              )
            ],
            border: Border.all(color: Colors.grey.shade300, width: 1),
          ),
          child: Custombutton(
              text: "حفظ",
              color: KSecondaryColor,
              textColor: Colors.white,
              onPressed: () {
                navigatetoReviewTestView(optionnavigationrequirementsentity,
                    courseTestEntity, context);
              }),
        ));
  }

  void navigatetoReviewTestView(
      OptionNavigationRequirementsEntity optionnavigationrequirementsentity,
      CourseTestEntity courseTestEntity,
      BuildContext context) {
    if (Variables.AddCourseSectionExamFormKey.currentState!.validate()) {
      Variables.AddCourseSectionExamFormKey.currentState!.save();
      GoRouter.of(context).push(ReviewExamSectionView.routeName,
          extra: NavigateExamReviewRequirmentsEntity(
              isNewSection: optionnavigationrequirementsentity.isNewSection,
              coursetestentity: courseTestEntity,
              section: optionnavigationrequirementsentity.section,
              courseEntity: optionnavigationrequirementsentity.courseEntity));
    }
  }
}
