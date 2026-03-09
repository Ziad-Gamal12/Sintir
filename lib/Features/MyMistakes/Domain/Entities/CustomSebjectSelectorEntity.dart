import 'package:sintir/locale_keys.dart';

class CustomSubjectSelectorEntity {
  final String subjectLabel;
  final String subjectValue;

  CustomSubjectSelectorEntity({
    required this.subjectLabel,
    required this.subjectValue,
  });

  static List<CustomSubjectSelectorEntity> getSubjects() {
    return [
      CustomSubjectSelectorEntity(
          subjectLabel: LocaleKeys.arabic, subjectValue: "Arabic"),
      CustomSubjectSelectorEntity(
          subjectLabel: LocaleKeys.english, subjectValue: "English"),
      CustomSubjectSelectorEntity(
          subjectLabel: LocaleKeys.french, subjectValue: "French"),
      CustomSubjectSelectorEntity(
          subjectLabel: LocaleKeys.italian, subjectValue: "Italian"),
      CustomSubjectSelectorEntity(
          subjectLabel: LocaleKeys.spanish, subjectValue: "Spanish"),
      CustomSubjectSelectorEntity(
          subjectLabel: LocaleKeys.mathematics, subjectValue: "Mathematics"),
      CustomSubjectSelectorEntity(
          subjectLabel: LocaleKeys.physics, subjectValue: "Physics"),
      CustomSubjectSelectorEntity(
          subjectLabel: LocaleKeys.chemistry, subjectValue: "Chemistry"),
      CustomSubjectSelectorEntity(
          subjectLabel: LocaleKeys.biology, subjectValue: "Biology"),
      CustomSubjectSelectorEntity(
          subjectLabel: LocaleKeys.biologicalScience,
          subjectValue: "Biological Science"),
      CustomSubjectSelectorEntity(
          subjectLabel: LocaleKeys.science, subjectValue: "Science"),
      CustomSubjectSelectorEntity(
          subjectLabel: LocaleKeys.philosophy, subjectValue: "Philosophy"),
      CustomSubjectSelectorEntity(
          subjectLabel: LocaleKeys.history, subjectValue: "History"),
      CustomSubjectSelectorEntity(
          subjectLabel: LocaleKeys.geography, subjectValue: "Geography"),
      CustomSubjectSelectorEntity(
          subjectLabel: LocaleKeys.computerScience,
          subjectValue: "Computer Science"),
      CustomSubjectSelectorEntity(
          subjectLabel: LocaleKeys.other, subjectValue: "Other"),
    ];
  }
}
