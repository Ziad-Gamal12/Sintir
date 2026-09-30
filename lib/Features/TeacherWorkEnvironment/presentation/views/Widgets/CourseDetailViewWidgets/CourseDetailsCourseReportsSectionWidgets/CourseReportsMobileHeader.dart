import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/locale_keys.dart';

import 'ReportSearchField.dart';

class CourseReportsMobileHeader extends StatefulWidget {
  const CourseReportsMobileHeader({super.key});
  @override
  State<CourseReportsMobileHeader> createState() =>
      _CourseReportsMobileHeaderState();
}

class _CourseReportsMobileHeaderState extends State<CourseReportsMobileHeader> {
  bool searching = false;
  @override
  Widget build(BuildContext context) {
    final title =
        context.select((CourseReportsCubit cubit) => cubit.courseTitle);
    final theme = Theme.of(context);
    return Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(8, 4, 8, 12),
        child: Column(children: [
          Row(children: [
            const BackButton(),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(LocaleKeys.courseReportsTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  if (title.isNotEmpty)
                    Text(title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall),
                ])),
            IconButton(
                tooltip: LocaleKeys.reportSearchHint,
                onPressed: () => setState(() {
                      searching = !searching;
                      if (!searching) {
                        context.read<CourseReportsCubit>().setSearchQuery('');
                      }
                    }),
                icon: Icon(searching ? Icons.close : Icons.search)),
          ]),
          AnimatedSize(
              duration: const Duration(milliseconds: 200),
              child: searching
                  ? Padding(
                      padding: const EdgeInsetsDirectional.only(start: 48),
                      child: ReportSearchField(
                          onChanged:
                              context.read<CourseReportsCubit>().setSearchQuery,
                          autofocus: true))
                  : const SizedBox(width: double.infinity)),
        ]));
  }
}
