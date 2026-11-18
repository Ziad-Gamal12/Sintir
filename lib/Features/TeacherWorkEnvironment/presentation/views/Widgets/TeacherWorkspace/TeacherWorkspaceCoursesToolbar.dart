// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherCoursesQuery.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentTheme.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_courses_cubit/teacher_courses_cubit.dart';
import 'package:sintir/locale_keys.dart';

class TeacherWorkspaceCoursesToolbar extends StatelessWidget {
  const TeacherWorkspaceCoursesToolbar({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
  });

  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: _SearchField(
                controller: searchController,
                onChanged: onSearchChanged,
              ),
            ),
            const SizedBox(width: 8),
            const _SortButton(),
          ],
        ),
        const SizedBox(height: 12),
        const _FilterChips(),
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final tokens = WorkEnvironmentThemeExtension.of(context);
    final styles = AppTextStyles(context);
    return Container(
      height: 48,
      padding: const EdgeInsetsDirectional.only(start: 14, end: 4),
      decoration: BoxDecoration(
        color: tokens.searchFill,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tokens.searchBorder),
      ),
      child: Row(
        children: [
          Icon(Icons.search_rounded, size: 20, color: tokens.mutedText),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              key: const ValueKey('workspace-courses-search'),
              controller: controller,
              onChanged: onChanged,
              textInputAction: TextInputAction.search,
              style: styles.regular13.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              decoration: InputDecoration(
                hintText: LocaleKeys.searchCoursesHint,
                hintStyle: styles.regular13.copyWith(color: tokens.mutedText),
                isDense: true,
                filled: false,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, _) => value.text.isEmpty
                ? const SizedBox(width: 8)
                : IconButton(
                    tooltip: MaterialLocalizations.of(
                      context,
                    ).deleteButtonTooltip,
                    onPressed: () {
                      controller.clear();
                      onChanged('');
                    },
                    icon: Icon(
                      Icons.close_rounded,
                      size: 18,
                      color: tokens.mutedText,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _SortButton extends StatelessWidget {
  const _SortButton();

  static String labelOf(TeacherCoursesSort sort) {
    switch (sort) {
      case TeacherCoursesSort.newest:
        return LocaleKeys.coursesSortNewest;
      case TeacherCoursesSort.mostStudents:
        return LocaleKeys.coursesSortMostStudents;
      case TeacherCoursesSort.topRated:
        return LocaleKeys.coursesSortTopRated;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = WorkEnvironmentThemeExtension.of(context);
    final selected = context.select(
      (TeacherCoursesCubit cubit) => cubit.state.query.sort,
    );
    return SizedBox(
      width: 48,
      height: 48,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: tokens.searchFill,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: tokens.searchBorder),
        ),
        child: PopupMenuButton<TeacherCoursesSort>(
          key: const ValueKey('workspace-courses-sort'),
          tooltip: '${LocaleKeys.coursesSortTooltip}: ${labelOf(selected)}',
          initialValue: selected,
          onSelected: context.read<TeacherCoursesCubit>().setSort,
          icon: Icon(Icons.sort_rounded, color: tokens.mutedText),
          itemBuilder: (context) => [
            for (final sort in TeacherCoursesSort.values)
              CheckedPopupMenuItem<TeacherCoursesSort>(
                key: ValueKey('workspace-courses-sort-${sort.name}'),
                value: sort,
                checked: sort == selected,
                child: Text(labelOf(sort)),
              ),
          ],
        ),
      ),
    );
  }
}

class _FilterChips extends StatelessWidget {
  const _FilterChips();

  static String labelOf(TeacherCoursesFilter filter, int count) {
    switch (filter) {
      case TeacherCoursesFilter.all:
        return LocaleKeys.filterAll(count);
      case TeacherCoursesFilter.published:
        return LocaleKeys.filterPublished(count);
      case TeacherCoursesFilter.inReview:
        return LocaleKeys.filterInReview(count);
      case TeacherCoursesFilter.declined:
        return LocaleKeys.filterDeclined(count);
      case TeacherCoursesFilter.archived:
        return LocaleKeys.filterArchived(count);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = WorkEnvironmentThemeExtension.of(context);
    final styles = AppTextStyles(context);
    final counts = context.select(
      (TeacherCoursesCubit cubit) => cubit.state.counts,
    );
    final selected = context.select(
      (TeacherCoursesCubit cubit) => cubit.state.query.filter,
    );
    final filters = [
      for (final filter in TeacherCoursesFilter.values)
        if (filter == TeacherCoursesFilter.all ||
            filter == TeacherCoursesFilter.published ||
            filter == TeacherCoursesFilter.inReview ||
            counts.of(filter) > 0 ||
            filter == selected)
          filter,
    ];

    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = filter == selected;
          final label = labelOf(filter, counts.of(filter));
          return Semantics(
            button: true,
            selected: isSelected,
            label: label,
            child: ExcludeSemantics(
              child: Material(
                key: ValueKey('workspace-filter-${filter.name}'),
                color: isSelected
                    ? theme.colorScheme.primary
                    : tokens.cardBackground,
                shape: StadiumBorder(
                  side: BorderSide(
                    color: isSelected
                        ? theme.colorScheme.primary
                        : tokens.cardBorder,
                  ),
                ),
                child: InkWell(
                  customBorder: const StadiumBorder(),
                  onTap: () =>
                      context.read<TeacherCoursesCubit>().setFilter(filter),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Center(
                      child: Text(
                        label,
                        style: styles.semiBold12.copyWith(
                          color: isSelected ? Colors.white : tokens.mutedText,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
