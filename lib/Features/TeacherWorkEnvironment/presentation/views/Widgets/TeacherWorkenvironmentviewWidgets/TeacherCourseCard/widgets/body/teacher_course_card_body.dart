import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/utils/teacher_course_card_data.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/utils/teacher_course_card_metrics.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/widgets/body/teacher_course_footer_row.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/widgets/body/teacher_course_price_row.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentTheme.dart';

/// Title, price/students row and content summary (+ "New" chip) under the
/// poster.
///
/// Its minimum height is [TeacherCourseCardMetrics.bodyExtent]; keep the two
/// in sync when adding or resizing rows.
class TeacherCourseCardBody extends StatelessWidget {
  const TeacherCourseCardBody({super.key, required this.data});

  final TeacherCourseCardData data;

  @override
  Widget build(BuildContext context) {
    final tokens = WorkEnvironmentThemeExtension.of(context);
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return Padding(
      padding: TeacherCourseCardMetrics.bodyPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            data.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TeacherCourseCardMetrics.titleStyle(
              context,
            ).copyWith(color: onSurface),
          ),
          const SizedBox(height: TeacherCourseCardMetrics.titleToMetaGap),
          TeacherCoursePriceRow(
            priceLabel: data.priceLabel,
            isFree: data.isFree,
            studentsLabel: data.studentsLabel,
          ),
          const Spacer(),
          Divider(
            height: TeacherCourseCardMetrics.dividerExtent,
            thickness: 1,
            color: tokens.cardBorder,
          ),
          TeacherCourseFooterRow(
            contentLabel: data.contentLabel,
            isNew: data.isNew,
          ),
        ],
      ),
    );
  }
}
