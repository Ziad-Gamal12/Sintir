// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherAttentionItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/CourseDetailView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/TeacherCourseReviewsView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CourseDetailsCouponsView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/CourseDetailsCourseReportsView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_courses_cubit/teacher_courses_cubit.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_workspace_insights_cubit/teacher_workspace_insights_cubit.dart';

abstract final class TeacherWorkspaceActions {
  static Future<void> openCourse(
    BuildContext context,
    CourseEntity course,
  ) async {
    final courses = context.read<TeacherCoursesCubit>();
    await GoRouter.of(context).push(CourseDetailView.routeName, extra: course);
    if (!courses.isClosed) await courses.refresh();
  }

  static Future<void> openAttention(
    BuildContext context,
    TeacherAttentionItem item,
  ) async {
    if (item.kind == TeacherAttentionKind.declined ||
        item.kind == TeacherAttentionKind.adminHidden) {
      return openCourse(context, item.course);
    }
    final insights = context.read<TeacherWorkspaceInsightsCubit>();
    final router = GoRouter.of(context);
    switch (item.kind) {
      case TeacherAttentionKind.openReports:
        await router.push(
          CourseDetailsCourseReportsView.routeName,
          extra: item.course.id,
        );
      case TeacherAttentionKind.lowRatings:
        await router.push(
          TeacherCourseReviewsView.routeName,
          extra: item.course,
        );
      case TeacherAttentionKind.couponEnding:
        await router.push(
          CourseDetailsCouponsView.routeName,
          extra: item.course.id,
        );
      case TeacherAttentionKind.declined:
      case TeacherAttentionKind.adminHidden:
        break;
    }
    if (!insights.isClosed) await insights.refresh();
  }
}
