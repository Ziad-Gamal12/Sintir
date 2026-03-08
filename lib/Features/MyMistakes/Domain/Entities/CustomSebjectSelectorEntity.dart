class CustomSubjectSelectorEntity {
  final String subjectLabel;
  final String subjectValue;

  CustomSubjectSelectorEntity({
    required this.subjectLabel,
    required this.subjectValue,
  });

  static List<CustomSubjectSelectorEntity> getSubjects() {
    final Map<String, String> subjectsMap = {
      "Arabic": "اللغة العربية",
      "English": "اللغة الإنجليزية",
      "French": "اللغة الفرنسية",
      "Italian": "اللغة الإيطالية",
      "Spanish": "اللغة الإسبانية",
      "Mathematics": "الرياضيات",
      "Physics": "الفيزياء",
      "Chemistry": "الكيمياء",
      "Biology": "الأحياء",
      "Biological Science": "العلوم البيولوجية",
      "Science": "العلوم",
      "Philosophy": "الفلسفة",
      "History": "التاريخ",
      "Geography": "الجغرافيا",
      "Computer Science": "حاسب آلي",
      "Other": "أخرى",
    };

    return subjectsMap.entries
        .map((e) => CustomSubjectSelectorEntity(
            subjectLabel: e.value, subjectValue: e.key))
        .toList();
  }
}
