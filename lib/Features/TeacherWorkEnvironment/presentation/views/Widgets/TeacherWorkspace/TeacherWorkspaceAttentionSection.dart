// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherAttentionItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentTheme.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeacherWorkspaceActions.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeacherWorkspaceAttentionRow.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeacherWorkspaceSectionTitle.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeacherWorkspaceSurface.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_workspace_insights_cubit/teacher_workspace_insights_cubit.dart';
import 'package:sintir/locale_keys.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TeacherWorkspaceAttentionSection extends StatelessWidget {
  const TeacherWorkspaceAttentionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      TeacherWorkspaceInsightsCubit,
      TeacherWorkspaceInsightsState
    >(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.summary != current.summary,
      builder: (context, state) {
        final summary = state.summary;
        if (summary == null) {
          if (state.status == WorkspaceLoadStatus.failure) {
            return const SizedBox.shrink();
          }
          return const _AttentionSkeleton();
        }
        return _AttentionContent(items: summary.attention);
      },
    );
  }
}

class _AttentionContent extends StatefulWidget {
  const _AttentionContent({required this.items});

  final List<TeacherAttentionItem> items;

  @override
  State<_AttentionContent> createState() => _AttentionContentState();
}

class _AttentionContentState extends State<_AttentionContent> {
  static const int collapsedCount = 4;

  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    final locale = Localizations.localeOf(context).languageCode;
    final visible = _expanded || items.length <= collapsedCount
        ? items
        : items.take(collapsedCount).toList();
    final canToggle = items.length > collapsedCount;

    return Column(
      key: const ValueKey('workspace-attention'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        TeacherWorkspaceSectionTitle(
          title: LocaleKeys.attentionTitle,
          subtitle: items.isEmpty
              ? null
              : LocaleKeys.attentionItemsCount(items.length, locale),
        ),
        const SizedBox(height: 12),
        if (items.isEmpty)
          const _AllClear()
        else
          TeacherWorkspaceSurface(
            padding: EdgeInsets.zero,
            child: Material(
              type: MaterialType.transparency,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(
                TeacherWorkspaceSurface.radius,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var index = 0; index < visible.length; index++) ...[
                    if (index > 0) const _RowDivider(),
                    TeacherWorkspaceAttentionRow(
                      item: visible[index],
                      onTap: () => TeacherWorkspaceActions.openAttention(
                        context,
                        visible[index],
                      ),
                    ),
                  ],
                  if (canToggle) ...[
                    const _RowDivider(),
                    TextButton(
                      key: const ValueKey('attention-toggle'),
                      onPressed: () => setState(() => _expanded = !_expanded),
                      child: Text(
                        _expanded
                            ? LocaleKeys.attentionShowLess
                            : LocaleKeys.attentionShowAll(
                                '${items.length}',
                              ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _RowDivider extends StatelessWidget {
  const _RowDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 16,
      endIndent: 16,
      color: WorkEnvironmentThemeExtension.of(context).cardBorder,
    );
  }
}

class _AllClear extends StatelessWidget {
  const _AllClear();

  @override
  Widget build(BuildContext context) {
    final tokens = WorkEnvironmentThemeExtension.of(context);
    return TeacherWorkspaceSurface(
      key: const ValueKey('attention-all-clear'),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline_rounded,
            color: tokens.successForeground,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              LocaleKeys.attentionAllClear,
              style: AppTextStyles(
                context,
              ).regular13.copyWith(color: tokens.mutedText),
            ),
          ),
        ],
      ),
    );
  }
}

class _AttentionSkeleton extends StatelessWidget {
  const _AttentionSkeleton();

  @override
  Widget build(BuildContext context) {
    final course = CourseEntity.empty();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        TeacherWorkspaceSectionTitle(title: LocaleKeys.attentionTitle),
        const SizedBox(height: 12),
        Skeletonizer(
          enabled: true,
          child: TeacherWorkspaceSurface(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                TeacherWorkspaceAttentionRow(
                  item: TeacherAttentionItem.openReports(course, 2),
                  onTap: () {},
                ),
                const _RowDivider(),
                TeacherWorkspaceAttentionRow(
                  item: TeacherAttentionItem.declined(course),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
