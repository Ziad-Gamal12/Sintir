// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Managers/Cubits/content_creator_courses_cubit/content_creator_courses_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/AddCourseView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseStatus.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherEnvironmenCoursesGridDisplayedCourses.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherEnvironmentGridLoadingCourses.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentTheme.dart';
import 'package:sintir/locale_keys.dart';

class TeacherEnvironmentCoursesGrid extends StatelessWidget {
  const TeacherEnvironmentCoursesGrid({
    super.key,
    required this.selectedStatus,
    required this.searchQuery,
    required this.onClearFilters,
    this.crossAxisCount,
  });

  final TeacherCourseStatus selectedStatus;
  final String searchQuery;
  final VoidCallback onClearFilters;
  final int? crossAxisCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = WorkEnvironmentThemeExtension.of(context);
    final textStyles = AppTextStyles(context);

    return BlocBuilder<ContentCreatorCoursesCubit, ContentCreatorCoursesState>(
      builder: (context, state) {
        if (state is GetContentCreatorCoursesLoading ||
            state is SearchContentCreatorCoursesLoading) {
          return TeacherEnvironmentGridLoadingCourses(
            crossAxisCount: crossAxisCount,
          );
        } else if (state is GetContentCreatorCoursesFailure) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: CustomErrorWidget(errormessage: state.errmessage),
              ),
            ),
          );
        } else if (state is SearchContentCreatorCoursesFailure) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: CustomErrorWidget(errormessage: state.errmessage),
              ),
            ),
          );
        }

        final allCourses = state is GetContentCreatorCoursesSuccess
            ? state.coursesList
            : state is SearchContentCreatorCoursesSuccess
            ? state.coursesList
            : context.read<ContentCreatorCoursesCubit>().contentCreatorCourses;

        // If the teacher has no courses created at all
        if (allCourses.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomEmptyWidget(text: LocaleKeys.noCourses),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(12),
                      ),
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    onPressed: () =>
                        GoRouter.of(context).push(Addcourseview.routeName),
                    icon: const Icon(Icons.add, size: 18),
                    label: Text(
                      LocaleKeys.addCourse,
                      style: textStyles.semiBold14.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Apply status filter
        List<CourseEntity> filtered = allCourses;
        if (selectedStatus != TeacherCourseStatus.all) {
          filtered = filtered
              .where(
                (c) => TeacherCourseStatus.fromRaw(c.state) == selectedStatus,
              )
              .toList();
        }

        // Apply search query filter
        final query = searchQuery.trim();
        if (query.isNotEmpty) {
          final normalizedQuery =
              TeacherWorkEnvironmentFormatters.normalizeSearch(query);
          filtered = filtered.where((c) {
            final normalizedTitle =
                TeacherWorkEnvironmentFormatters.normalizeSearch(c.title);
            return normalizedTitle.contains(normalizedQuery);
          }).toList();
        }

        // If filtered list is empty (no matches for search or filter)
        if (filtered.isEmpty) {
          final isSearching = query.isNotEmpty;
          final message = isSearching
              ? LocaleKeys.noMatchingCourses
              : LocaleKeys.noCoursesInFilter;

          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 36),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off_rounded,
                    size: 48,
                    color: tokens.mutedText.withValues(alpha: 0.6),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    message,
                    style: textStyles.semiBold14.copyWith(
                      color: tokens.mutedText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 14),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: tokens.primaryBorder),
                      foregroundColor: theme.colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(12),
                      ),
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                    onPressed: onClearFilters,
                    child: Text(
                      LocaleKeys.clearSearchAndFilters,
                      style: textStyles.semiBold13.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return TeacherEnvironmenCoursesGridDisplayedCourses(
          coursesList: filtered,
          crossAxisCount: crossAxisCount,
        );
      },
    );
  }
}
