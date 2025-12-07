import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/CustomAddExamStepsRowItemEntity.dart';

class CustomAddExamStepsRowItem extends StatelessWidget {
  const CustomAddExamStepsRowItem(
      {super.key,
      required this.entity,
      required this.isCompleted,
      required this.isSelected});
  final CustomAddExamStepsRowItemEntity entity;
  final bool isSelected;
  final bool isCompleted;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: getStepColor(theme: theme),
          child: Text(
            "${entity.stepNumber}",
            style: AppTextStyles(context).bold14.copyWith(
                  color: theme.textTheme.titleMedium?.color,
                ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          entity.title,
          style: AppTextStyles(context).semiBold14.copyWith(
                color: getTextColor(theme: theme),
              ),
        )
      ],
    );
  }

  Color getStepColor({required ThemeData theme}) {
    if (isSelected) {
      return theme.colorScheme.secondary;
    } else if (isCompleted) {
      return theme.colorScheme.primary;
    } else {
      return theme.cardColor;
    }
  }

  Color getTextColor({required ThemeData theme}) {
    if (isSelected) {
      return theme.colorScheme.secondary;
    } else if (isCompleted) {
      return theme.colorScheme.primary;
    } else {
      return theme.textTheme.titleMedium?.color ?? Colors.black;
    }
  }
}
