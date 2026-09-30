import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';
import 'package:sintir/locale_keys.dart';

class ReportSortButton extends StatelessWidget {
  const ReportSortButton({super.key, required this.isMobile});
  final bool isMobile;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CourseReportsCubit>();
    final order = cubit.sortOrder;
    final label = order == ReportSortOrder.newestFirst
        ? LocaleKeys.reportSortNewest
        : LocaleKeys.reportSortOldest;
    final theme = Theme.of(context);
    final child = Container(
      constraints: const BoxConstraints(minHeight: 44, maxWidth: 230),
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(10)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.swap_vert,
            size: 18, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 6),
        Flexible(
            child: Text(label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelMedium)),
      ]),
    );
    void select(ReportSortOrder value) => cubit.applyFilters(
        status: cubit.statusFilter, type: cubit.typeFilter, sortOrder: value);
    if (isMobile)
      return InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => showModalBottomSheet<void>(
          context: context,
          showDragHandle: true,
          useSafeArea: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          builder: (sheetContext) => SafeArea(
              child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 24),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(LocaleKeys.reportSortNewest,
                      style: Theme.of(sheetContext).textTheme.titleMedium)),
              RadioListTile<ReportSortOrder>(
                  value: ReportSortOrder.newestFirst,
                  groupValue: order,
                  title: Text(LocaleKeys.reportSortNewest),
                  onChanged: (_) {
                    Navigator.pop(sheetContext);
                    select(ReportSortOrder.newestFirst);
                  }),
              RadioListTile<ReportSortOrder>(
                  value: ReportSortOrder.oldestFirst,
                  groupValue: order,
                  title: Text(LocaleKeys.reportSortOldest),
                  onChanged: (_) {
                    Navigator.pop(sheetContext);
                    select(ReportSortOrder.oldestFirst);
                  }),
            ]),
          )),
        ),
        child: child,
      );
    return PopupMenuButton<ReportSortOrder>(
      tooltip: LocaleKeys.reportSortNewest,
      onSelected: select,
      itemBuilder: (_) => [
        PopupMenuItem(
            value: ReportSortOrder.newestFirst,
            child: Text(LocaleKeys.reportSortNewest)),
        PopupMenuItem(
            value: ReportSortOrder.oldestFirst,
            child: Text(LocaleKeys.reportSortOldest)),
      ],
      child: child,
    );
  }
}
