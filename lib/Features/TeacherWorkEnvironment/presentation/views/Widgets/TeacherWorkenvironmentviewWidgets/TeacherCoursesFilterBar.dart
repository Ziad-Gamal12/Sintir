// ignore_for_file: file_names

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseStatus.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentTheme.dart';
import 'package:sintir/locale_keys.dart';

class TeacherCoursesFilterBar extends StatelessWidget {
  const TeacherCoursesFilterBar({
    super.key,
    required this.searchController,
    required this.selectedStatus,
    required this.onStatusSelected,
    required this.allCount,
    required this.publishedCount,
    required this.inReviewCount,
    required this.archivedCount,
    this.onSearchChanged,
  });

  final TextEditingController searchController;
  final TeacherCourseStatus selectedStatus;
  final ValueChanged<TeacherCourseStatus> onStatusSelected;
  final int allCount;
  final int publishedCount;
  final int inReviewCount;
  final int archivedCount;
  final ValueChanged<String>? onSearchChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = WorkEnvironmentThemeExtension.of(context);
    final textStyles = AppTextStyles(context);

    final chips = [
      (TeacherCourseStatus.all, allCount),
      (TeacherCourseStatus.published, publishedCount),
      (TeacherCourseStatus.inReview, inReviewCount),
      (TeacherCourseStatus.archived, archivedCount),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Search text field
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: tokens.searchFill,
            borderRadius: BorderRadiusDirectional.circular(14),
            border: Border.all(color: tokens.searchBorder, width: 1),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 14),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  onChanged: onSearchChanged,
                  style: textStyles.regular13.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                  decoration: InputDecoration(
                    hintText: LocaleKeys.searchCoursesHint,
                    hintStyle: textStyles.regular13.copyWith(
                      color: tokens.mutedText,
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: false,
                  ),
                ),
              ),
              if (searchController.text.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    searchController.clear();
                    onSearchChanged?.call('');
                  },
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 6),
                    child: Icon(
                      Icons.close_rounded,
                      size: 18,
                      color: tokens.mutedText,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 8),
                child: Icon(
                  Icons.search_rounded,
                  size: 20,
                  color: tokens.mutedText,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Horizontally scrollable status filter chips
        SizedBox(
          height: 36,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: chips.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final item = chips[index];
              final status = item.$1;
              final count = item.$2;
              final isSelected = selectedStatus == status;

              return Semantics(
                button: true,
                selected: isSelected,
                label: status.chipLabel(count),
                child: GestureDetector(
                  onTap: () => onStatusSelected(status),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : tokens.cardBackground,
                      borderRadius: BorderRadiusDirectional.circular(100),
                      border: Border.all(
                        color: isSelected
                            ? theme.colorScheme.primary
                            : tokens.cardBorder,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      status.chipLabel(count),
                      style: textStyles.semiBold12.copyWith(
                        color: isSelected ? Colors.white : tokens.mutedText,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
