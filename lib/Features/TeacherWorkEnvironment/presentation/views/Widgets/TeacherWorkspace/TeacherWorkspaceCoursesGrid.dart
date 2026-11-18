// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/AddCourseView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentBreakpoints.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentTheme.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeacherWorkspaceActions.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeacherWorkspaceCourseCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeacherWorkspaceCourseCardMetrics.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_courses_cubit/teacher_courses_cubit.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_workspace_insights_cubit/teacher_workspace_insights_cubit.dart';
import 'package:sintir/locale_keys.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TeacherWorkspaceCoursesGrid extends StatelessWidget {
  const TeacherWorkspaceCoursesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherCoursesCubit, TeacherCoursesState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.visibleCourses != current.visibleCourses ||
          previous.courses.isEmpty != current.courses.isEmpty,
      builder: (context, state) {
        switch (state.status) {
          case WorkspaceLoadStatus.initial:
          case WorkspaceLoadStatus.loading:
            return const _LoadingGrid();
          case WorkspaceLoadStatus.failure:
            return SliverToBoxAdapter(
              child: _CoursesFailure(
                message: state.errorMessage ?? LocaleKeys.errorOccurredMessage,
                onRetry: context.read<TeacherCoursesCubit>().load,
              ),
            );
          case WorkspaceLoadStatus.loaded:
            if (state.courses.isEmpty) {
              return const SliverToBoxAdapter(child: _NoCourses());
            }
            if (state.visibleCourses.isEmpty) {
              return SliverToBoxAdapter(
                child: _NoMatches(
                  searching: state.query.search.trim().isNotEmpty,
                  onClear: context.read<TeacherCoursesCubit>().clearFilters,
                ),
              );
            }
            return _CoursesGrid(courses: state.visibleCourses);
        }
      },
    );
  }
}

class _CoursesGrid extends StatelessWidget {
  const _CoursesGrid({required this.courses});

  final List<CourseEntity> courses;

  @override
  Widget build(BuildContext context) {
    final reports = context.select(
      (TeacherWorkspaceInsightsCubit cubit) =>
          cubit.state.summary?.openReportsByCourse,
    );
    return _GridLayout(
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return TeacherWorkspaceCourseCard(
          key: ValueKey('workspace-course-${course.id}'),
          course: course,
          openReports: reports?[course.id] ?? 0,
          onTap: () => TeacherWorkspaceActions.openCourse(context, course),
        );
      },
    );
  }
}

class _LoadingGrid extends StatelessWidget {
  const _LoadingGrid();

  static const int _rows = 2;

  @override
  Widget build(BuildContext context) {
    final placeholder = CourseEntity.empty();
    return Skeletonizer.sliver(
      enabled: true,
      child: _GridLayout(
        itemCountFor: (columns) => columns * _rows,
        itemBuilder: (context, index) => TeacherWorkspaceCourseCard(
          course: placeholder,
          onTap: () {},
        ),
      ),
    );
  }
}

class _GridLayout extends StatelessWidget {
  const _GridLayout({
    required this.itemBuilder,
    this.itemCount,
    this.itemCountFor,
  });

  final NullableIndexedWidgetBuilder itemBuilder;
  final int? itemCount;
  final int Function(int columns)? itemCountFor;

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.crossAxisExtent;
        final columns = TeacherWorkEnvironmentLayout.getGridColumnCount(width);
        const gap = TeacherWorkEnvironmentLayout.gridGap;
        final cellWidth = (width - gap * (columns - 1)) / columns;
        return SliverGrid.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            mainAxisSpacing: gap,
            crossAxisSpacing: gap,
            mainAxisExtent: TeacherWorkspaceCourseCardMetrics.heightForWidth(
              context,
              cellWidth,
            ),
          ),
          itemCount: itemCount ?? itemCountFor?.call(columns) ?? 0,
          itemBuilder: itemBuilder,
        );
      },
    );
  }
}

class _CoursesFailure extends StatelessWidget {
  const _CoursesFailure({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const ValueKey('workspace-courses-failure'),
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomErrorWidget(errormessage: message),
          TextButton(
            onPressed: onRetry,
            child: Text(LocaleKeys.workspaceRetry),
          ),
        ],
      ),
    );
  }
}

class _NoCourses extends StatelessWidget {
  const _NoCourses();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      key: const ValueKey('workspace-no-courses'),
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomEmptyWidget(text: LocaleKeys.noCourses),
          const SizedBox(height: 16),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => GoRouter.of(context).push(Addcourseview.routeName),
            icon: const Icon(Icons.add, size: 18),
            label: Text(LocaleKeys.addCourse),
          ),
        ],
      ),
    );
  }
}

class _NoMatches extends StatelessWidget {
  const _NoMatches({required this.searching, required this.onClear});

  final bool searching;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final tokens = WorkEnvironmentThemeExtension.of(context);
    final styles = AppTextStyles(context);
    return Padding(
      key: const ValueKey('workspace-no-matches'),
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off_rounded, size: 44, color: tokens.mutedText),
          const SizedBox(height: 12),
          Text(
            searching
                ? LocaleKeys.noMatchingCourses
                : LocaleKeys.noCoursesInFilter,
            textAlign: TextAlign.center,
            style: styles.semiBold14.copyWith(color: tokens.mutedText),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            key: const ValueKey('workspace-clear-filters'),
            onPressed: onClear,
            child: Text(LocaleKeys.clearSearchAndFilters),
          ),
        ],
      ),
    );
  }
}
