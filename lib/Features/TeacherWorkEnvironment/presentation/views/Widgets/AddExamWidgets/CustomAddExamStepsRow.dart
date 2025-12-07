import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/CustomAddExamStepsRowItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/CustomAddExamStepsRowItem.dart';

class CustomAddExamStepsRow extends StatelessWidget {
  const CustomAddExamStepsRow(
      {super.key, required this.pageController, required this.currentStep});

  final PageController pageController;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    final items = CustomAddExamStepsRowItemEntity.toList();

    return IntrinsicHeight(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: items.asMap().entries.map((e) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  if (e.key < currentStep) {
                    pageController.animateToPage(e.key,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                  }
                },
                child: CustomAddExamStepsRowItem(
                    isCompleted: e.key < currentStep,
                    entity: e.value,
                    isSelected: currentStep == e.key),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
