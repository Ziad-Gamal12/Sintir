import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/utils/report_type_ui.dart';
import 'package:sintir/locale_keys.dart';

class ReportTypeFilterButton extends StatelessWidget {
  const ReportTypeFilterButton({super.key, required this.isMobile});
  final bool isMobile;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CourseReportsCubit>();
    final selected = cubit.typeFilter;
    final label = selected?.label ?? LocaleKeys.reportFilterAll;
    final theme = Theme.of(context);
    final button = Container(
        constraints: const BoxConstraints(minHeight: 44, maxWidth: 245),
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(10)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.filter_list,
              size: 18, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 6),
          Flexible(
              child: Text('${LocaleKeys.reportTypeFilterLabel}: $label',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelMedium))
        ]));
    void apply(ReportType? value) => cubit.applyFilters(
        status: cubit.statusFilter, type: value, sortOrder: cubit.sortOrder);
    if (!isMobile)
      return PopupMenuButton<ReportType?>(
        tooltip: LocaleKeys.reportTypeFilterLabel,
        onSelected: apply,
        itemBuilder: (_) => [
          PopupMenuItem<ReportType?>(
              value: null, child: Text(LocaleKeys.reportFilterAll)),
          ...ReportType.values.map((type) =>
              PopupMenuItem<ReportType?>(value: type, child: Text(type.label))),
        ],
        child: button,
      );
    return InkWell(
        onTap: () => showModalBottomSheet<void>(
              context: context,
              showDragHandle: true,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              builder: (sheetContext) => SafeArea(
                  child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 8, 20, 24),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(LocaleKeys.reportTypeFilterLabel,
                                style: Theme.of(sheetContext)
                                    .textTheme
                                    .titleMedium)),
                        RadioListTile<ReportType?>(
                            value: null,
                            groupValue: selected,
                            title: Text(LocaleKeys.reportFilterAll),
                            onChanged: (_) {
                              Navigator.pop(sheetContext);
                              apply(null);
                            }),
                        ...ReportType.values
                            .map((type) => RadioListTile<ReportType?>(
                                value: type,
                                groupValue: selected,
                                title: Text(type.label),
                                onChanged: (_) {
                                  Navigator.pop(sheetContext);
                                  apply(type);
                                })),
                      ]))),
            ),
        child: button);
  }
}
