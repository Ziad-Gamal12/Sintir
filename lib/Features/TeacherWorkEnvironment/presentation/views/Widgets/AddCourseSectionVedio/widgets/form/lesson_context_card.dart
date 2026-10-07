import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/utils/add_video_dimens.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/widgets/shared/surface_card.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/widgets/shared/tinted_icon_tile.dart';

class LessonContextCard extends StatelessWidget {
  const LessonContextCard({super.key, required this.option});

  final OptionNavigationRequirementsEntity option;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final styles = AppTextStyles(context);
    final sectionTitle = option.section.title.trim();
    final subtitle = [option.courseEntity.subject, option.courseEntity.title]
        .map((value) => value.trim())
        .where((value) => value.isNotEmpty)
        .join(' • ');

    return SurfaceCard(
      radius: AddVideoDimens.largeRadius,
      hasBorder: false,
      hasShadow: true,
      child: Row(
        children: [
          const TintedIconTile(icon: Icons.video_library_outlined),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (sectionTitle.isNotEmpty)
                  Text(
                    sectionTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: styles.bold14,
                  ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: styles.regular12.copyWith(color: colors.secondary),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
