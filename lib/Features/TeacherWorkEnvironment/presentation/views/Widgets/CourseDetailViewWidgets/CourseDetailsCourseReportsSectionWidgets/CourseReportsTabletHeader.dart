import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';
import 'ReportSearchField.dart';

class CourseReportsTabletHeader extends StatelessWidget {
  const CourseReportsTabletHeader({super.key});
  @override
  Widget build(BuildContext context) {
    final title =
        context.select((CourseReportsCubit cubit) => cubit.courseTitle);
    final theme = Theme.of(context);
    return Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
            KHorizontalPadding, 12, KHorizontalPadding, 16),
        child: Row(children: [
          const BackButton(),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(LocaleKeys.courseReportsTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w700)),
                if (title.isNotEmpty)
                  Text(title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall),
              ])),
          const SizedBox(width: 20),
          SizedBox(
              width: 300,
              child: ReportSearchField(
                  onChanged:
                      context.read<CourseReportsCubit>().setSearchQuery)),
        ]));
  }
}
