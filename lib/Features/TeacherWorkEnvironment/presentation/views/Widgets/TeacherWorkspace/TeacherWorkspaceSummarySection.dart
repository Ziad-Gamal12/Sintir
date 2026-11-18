// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/course_price_formatter.dart';
import 'package:sintir/Core/utils/locale_formatter.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/Rating/StarRatingDisplay.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherWorkspaceKpis.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentTheme.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeacherWorkspaceKpiTile.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeacherWorkspaceSectionTitle.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeacherWorkspaceSurface.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_workspace_insights_cubit/teacher_workspace_insights_cubit.dart';
import 'package:sintir/locale_keys.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TeacherWorkspaceSummarySection extends StatelessWidget {
  const TeacherWorkspaceSummarySection({super.key});

  static const TeacherWorkspaceKpis _placeholder = TeacherWorkspaceKpis(
    newStudents: 18,
    previousNewStudents: 12,
    netEarnings: 2340,
    ratingsSum: 46,
    ratingsCount: 10,
    totalStudents: 120,
    publishedCourses: 5,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('workspace-summary'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        TeacherWorkspaceSectionTitle(
          title: LocaleKeys.workspaceSummaryTitle,
          subtitle: LocaleKeys.workspaceSummarySubtitle,
        ),
        const SizedBox(height: 12),
        BlocBuilder<
          TeacherWorkspaceInsightsCubit,
          TeacherWorkspaceInsightsState
        >(
          buildWhen: (previous, current) =>
              previous.status != current.status ||
              previous.summary != current.summary,
          builder: (context, state) {
            final summary = state.summary;
            if (summary != null) return _KpiGrid(kpis: summary.kpis);
            if (state.status == WorkspaceLoadStatus.failure) {
              return _SummaryFailure(
                onRetry: context.read<TeacherWorkspaceInsightsCubit>().retry,
              );
            }
            return const Skeletonizer(
              enabled: true,
              child: _KpiGrid(kpis: _placeholder),
            );
          },
        ),
      ],
    );
  }
}

class _KpiGrid extends StatelessWidget {
  const _KpiGrid({required this.kpis});

  final TeacherWorkspaceKpis kpis;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final tokens = WorkEnvironmentThemeExtension.of(context);
    final ratingsCaption = kpis.hasRatings
        ? LocaleKeys.kpiRatingsFrom(
            LocaleKeys.ratingsCount(kpis.ratingsCount, locale),
          )
        : LocaleKeys.kpiNoRatings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _TileRow(
          start: TeacherWorkspaceKpiTile(
            key: const ValueKey('kpi-new-students'),
            label: LocaleKeys.kpiNewStudents,
            value: LocaleFormatter.number(kpis.newStudents, locale),
            caption: _StudentsChange(kpis: kpis),
          ),
          end: TeacherWorkspaceKpiTile(
            key: const ValueKey('kpi-net-earnings'),
            label: LocaleKeys.kpiNetEarnings,
            value: CoursePriceFormatter.egp(kpis.netEarnings, locale),
            caption: TeacherWorkspaceKpiCaption(
              text: LocaleKeys.kpiNetEarningsCaption,
            ),
          ),
        ),
        const SizedBox(height: 12),
        _TileRow(
          start: TeacherWorkspaceKpiTile(
            key: const ValueKey('kpi-average-rating'),
            label: LocaleKeys.kpiAverageRating,
            value: kpis.hasRatings
                ? kpis.averageRating.toStringAsFixed(1)
                : '—',
            leading: kpis.hasRatings
                ? const Icon(
                    Icons.star_rounded,
                    size: 22,
                    color: StarRatingDisplay.starColor,
                  )
                : null,
            caption: TeacherWorkspaceKpiCaption(text: ratingsCaption),
          ),
          end: TeacherWorkspaceKpiTile(
            key: const ValueKey('kpi-total-students'),
            label: LocaleKeys.kpiTotalStudents,
            value: LocaleFormatter.number(kpis.totalStudents, locale),
            caption: TeacherWorkspaceKpiCaption(
              text: LocaleKeys.kpiPublishedCourses(
                kpis.publishedCourses,
                locale,
              ),
              color: tokens.mutedText,
            ),
          ),
        ),
      ],
    );
  }
}

class _TileRow extends StatelessWidget {
  const _TileRow({required this.start, required this.end});

  final Widget start;
  final Widget end;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: start),
          const SizedBox(width: 12),
          Expanded(child: end),
        ],
      ),
    );
  }
}

class _StudentsChange extends StatelessWidget {
  const _StudentsChange({required this.kpis});

  final TeacherWorkspaceKpis kpis;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final tokens = WorkEnvironmentThemeExtension.of(context);
    final change = kpis.studentsChange;
    if (change == 0) {
      return TeacherWorkspaceKpiCaption(
        key: const ValueKey('kpi-change-same'),
        text: kpis.newStudents == 0
            ? LocaleKeys.kpiNoNewStudents
            : LocaleKeys.kpiChangeSame,
      );
    }
    final rising = change > 0;
    final amount = LocaleFormatter.number(change.abs(), locale);
    return TeacherWorkspaceKpiCaption(
      key: ValueKey(rising ? 'kpi-change-up' : 'kpi-change-down'),
      text: LocaleKeys.kpiChangeVsPrevious(
        '⁦${rising ? '+' : '−'}$amount⁩',
      ),
      icon: rising ? Icons.trending_up_rounded : Icons.trending_down_rounded,
      color: rising ? tokens.successForeground : tokens.dangerForeground,
    );
  }
}

class _SummaryFailure extends StatelessWidget {
  const _SummaryFailure({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final tokens = WorkEnvironmentThemeExtension.of(context);
    return TeacherWorkspaceSurface(
      key: const ValueKey('workspace-summary-failure'),
      padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 8, 8),
      child: Row(
        children: [
          Icon(Icons.cloud_off_rounded, size: 20, color: tokens.mutedText),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              LocaleKeys.workspaceSummaryFailed,
              style: AppTextStyles(
                context,
              ).regular13.copyWith(color: tokens.mutedText),
            ),
          ),
          TextButton(
            onPressed: onRetry,
            child: Text(LocaleKeys.workspaceRetry),
          ),
        ],
      ),
    );
  }
}
