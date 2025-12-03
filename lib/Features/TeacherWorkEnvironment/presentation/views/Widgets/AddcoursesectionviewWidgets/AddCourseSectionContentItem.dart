import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/AddcoursesectionOptionItem.dart';
import 'package:svg_flutter/svg.dart';

class AddCourseSectionContentItem extends StatelessWidget {
  const AddCourseSectionContentItem({super.key, required this.item});
  final Addcoursesectionoptionitem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.cardColor,
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.1),
                blurRadius: 4,
              ),
            ],
            border: Border.all(color: theme.dividerColor, width: 1.5),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            item.icon,
            color: theme.iconTheme.color,
            height: 28,
            width: 28,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          item.title,
          style: AppTextStyles(context)
              .semiBold16
              .copyWith(color: theme.textTheme.bodyMedium?.color),
        )
      ],
    );
  }
}
