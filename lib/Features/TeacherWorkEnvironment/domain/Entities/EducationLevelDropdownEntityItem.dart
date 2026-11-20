import 'package:sintir/locale_keys.dart';

class EducationLevelDropdownEntityItem {
  final String value;
  final String label;

  const EducationLevelDropdownEntityItem({
    required this.value,
    required this.label,
  });

  static List<EducationLevelDropdownEntityItem> get educationLevels => [
    EducationLevelDropdownEntityItem(
      value: "1st Grade Primary",
      label: LocaleKeys.grade1Primary,
    ),
    EducationLevelDropdownEntityItem(
      value: "2nd Grade Primary",
      label: LocaleKeys.grade2Primary,
    ),
    EducationLevelDropdownEntityItem(
      value: "3rd Grade Primary",
      label: LocaleKeys.grade3Primary,
    ),
    EducationLevelDropdownEntityItem(
      value: "4th Grade Primary",
      label: LocaleKeys.grade4Primary,
    ),
    EducationLevelDropdownEntityItem(
      value: "5th Grade Primary",
      label: LocaleKeys.grade5Primary,
    ),
    EducationLevelDropdownEntityItem(
      value: "6th Grade Primary",
      label: LocaleKeys.grade6Primary,
    ),
    EducationLevelDropdownEntityItem(
      value: "1st Grade Preparatory",
      label: LocaleKeys.grade1Preparatory,
    ),
    EducationLevelDropdownEntityItem(
      value: "2nd Grade Preparatory",
      label: LocaleKeys.grade2Preparatory,
    ),
    EducationLevelDropdownEntityItem(
      value: "3rd Grade Preparatory",
      label: LocaleKeys.grade3Preparatory,
    ),
    EducationLevelDropdownEntityItem(
      value: "1st Grade Secondary",
      label: LocaleKeys.grade1Secondary,
    ),
    EducationLevelDropdownEntityItem(
      value: "2nd Grade Secondary",
      label: LocaleKeys.grade2Secondary,
    ),
    EducationLevelDropdownEntityItem(
      value: "3rd Grade Secondary",
      label: LocaleKeys.grade3Secondary,
    ),
    EducationLevelDropdownEntityItem(value: "other", label: LocaleKeys.other),
  ];
  static List<String> getSubjectsLabels() {
    return educationLevels.map((e) {
      return e.label;
    }).toList();
  }

  static String getLabelByValue(String value) {
    for (final item in educationLevels) {
      if (item.value == value) return item.label;
    }
    return LocaleKeys.other;
  }

  static String getValueByLabel(String label) {
    for (final item in educationLevels) {
      if (item.label == label) return item.value;
    }
    return "other";
  }
}
