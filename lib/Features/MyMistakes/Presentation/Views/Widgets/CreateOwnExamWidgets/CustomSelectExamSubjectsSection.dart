import 'package:flutter/material.dart';
import 'package:sintir/Features/MyMistakes/Domain/Entities/CustomSebjectSelectorEntity.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Views/Widgets/CreateOwnExamWidgets/CustomSelectExamSubjectsSectionTitle.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Views/Widgets/CreateOwnExamWidgets/CustomSubjectSelectorItem.dart';

class CustomSelectExamSubjectsSection extends StatefulWidget {
  const CustomSelectExamSubjectsSection(
      {super.key, required this.onSubjectSelected});
  final Function(String?) onSubjectSelected;

  @override
  State<CustomSelectExamSubjectsSection> createState() =>
      _CustomSelectExamSubjectsSectionState();
}

class _CustomSelectExamSubjectsSectionState
    extends State<CustomSelectExamSubjectsSection> {
  String? selectedValue;
  final List<CustomSubjectSelectorEntity> subjects =
      CustomSubjectSelectorEntity.getSubjects();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomSelectExamSubjectsSectionTitle(),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 12,
          children: subjects.map((subject) {
            final isSelected = selectedValue == subject.subjectValue;
            return CustomSubjectSelectorItem(
              label: subject.subjectLabel,
              isSelected: isSelected,
              onTap: () {
                setState(() {
                  selectedValue = isSelected ? null : subject.subjectValue;
                });
                widget.onSubjectSelected(selectedValue);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
