import 'package:sintir/locale_keys.dart';

class CustomAddExamStepsRowItemEntity {
  final String title;
  final int stepNumber;

  CustomAddExamStepsRowItemEntity(
      {required this.title, required this.stepNumber});

  static List<CustomAddExamStepsRowItemEntity> toList() {
    return [
      CustomAddExamStepsRowItemEntity(
          title: LocaleKeys.addExamDetailsTitle, stepNumber: 1),
      CustomAddExamStepsRowItemEntity(
          title: LocaleKeys.examQuestionsTitle, stepNumber: 2),
      CustomAddExamStepsRowItemEntity(
          title: LocaleKeys.examReviewTitle, stepNumber: 3),
    ];
  }
}
