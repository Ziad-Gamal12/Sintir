import 'package:sintir/locale_keys.dart';

class SubjectDropdownEntityItem {
  final String value;
  final String label;

  const SubjectDropdownEntityItem({required this.value, required this.label});

  static List<SubjectDropdownEntityItem> get subjects => [
    SubjectDropdownEntityItem(value: "Arabic", label: LocaleKeys.subjectArabic),
    SubjectDropdownEntityItem(
      value: "English",
      label: LocaleKeys.subjectEnglish,
    ),
    SubjectDropdownEntityItem(value: "French", label: LocaleKeys.subjectFrench),
    SubjectDropdownEntityItem(
      value: "Italian",
      label: LocaleKeys.subjectItalian,
    ),
    SubjectDropdownEntityItem(
      value: "Spanish",
      label: LocaleKeys.subjectSpanish,
    ),
    SubjectDropdownEntityItem(
      value: "Mathematics",
      label: LocaleKeys.subjectMathematics,
    ),
    SubjectDropdownEntityItem(
      value: "Physics",
      label: LocaleKeys.subjectPhysics,
    ),
    SubjectDropdownEntityItem(
      value: "Chemistry",
      label: LocaleKeys.subjectChemistry,
    ),
    SubjectDropdownEntityItem(
      value: "Biology",
      label: LocaleKeys.subjectBiology,
    ),
    SubjectDropdownEntityItem(
      value: "Biological Science",
      label: LocaleKeys.subjectBiologicalScience,
    ),
    SubjectDropdownEntityItem(
      value: "Science",
      label: LocaleKeys.subjectScience,
    ),
    SubjectDropdownEntityItem(
      value: "Philosophy",
      label: LocaleKeys.subjectPhilosophy,
    ),
    SubjectDropdownEntityItem(
      value: "History",
      label: LocaleKeys.subjectHistory,
    ),
    SubjectDropdownEntityItem(
      value: "Geography",
      label: LocaleKeys.subjectGeography,
    ),
    SubjectDropdownEntityItem(
      value: "Computer Science",
      label: LocaleKeys.subjectComputerScience,
    ),
    SubjectDropdownEntityItem(value: "Other", label: LocaleKeys.subjectOther),
  ];
  static List<String> getSubjectsLabels() {
    return subjects.map((e) {
      return e.label;
    }).toList();
  }

  static String getLabelByValue(String value) {
    for (final item in subjects) {
      if (item.value == value) return item.label;
    }
    return LocaleKeys.subjectOther;
  }

  static String getValueByLabel(String label) {
    for (final item in subjects) {
      if (item.label == label) return item.value;
    }
    return "Other";
  }
}
