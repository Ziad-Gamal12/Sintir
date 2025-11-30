import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/content_creator_courses_cubit/content_creator_courses_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherEnvironmenCoursesGridDisplayedCourses.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherEnvironmentGridLoadingCourses.dart';
import 'package:sintir/locale_keys.dart';

class TeacherEnvironmentCoursesGrid extends StatefulWidget {
  const TeacherEnvironmentCoursesGrid({super.key, required this.isSearch});
  final bool isSearch;
  @override
  State<TeacherEnvironmentCoursesGrid> createState() =>
      _TeacherEnvironmentCoursesGridState();
}

class _TeacherEnvironmentCoursesGridState
    extends State<TeacherEnvironmentCoursesGrid> {
  List<CourseEntity> contentCreatorCourses = [];
  List<CourseEntity> searchContentCreatorCourses = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContentCreatorCoursesCubit, ContentCreatorCoursesState>(
        listener: (context, state) {
      if (state is GetContentCreatorCoursesSuccess) {
        contentCreatorCourses = state.coursesList;
      } else if (state is SearchContentCreatorCoursesSuccess) {
        searchContentCreatorCourses = state.coursesList;
      }
    }, builder: (context, state) {
      if (state is GetContentCreatorCoursesLoading ||
          state is SearchContentCreatorCoursesLoading) {
        return const TeacherEnvironmentGridLoadingCourses();
      } else if (state is GetContentCreatorCoursesFailure) {
        return SliverToBoxAdapter(
            child: Center(
                child: CustomErrorWidget(errormessage: state.errmessage)));
      } else if (state is SearchContentCreatorCoursesFailure) {
        return SliverToBoxAdapter(
            child: Center(
                child: CustomErrorWidget(errormessage: state.errmessage)));
      } else if (state is GetContentCreatorCoursesSuccess &&
          state.coursesList.isEmpty) {
        return SliverToBoxAdapter(
            child: Center(
                child: CustomEmptyWidget(text: LocaleKeys.emptyContent)));
      } else if (state is SearchContentCreatorCoursesSuccess &&
          state.coursesList.isEmpty) {
        return SliverToBoxAdapter(
            child: Center(
                child: CustomEmptyWidget(text: LocaleKeys.emptyContent)));
      } else {
        return TeacherEnvironmenCoursesGridDisplayedCourses(
          coursesList: widget.isSearch
              ? searchContentCreatorCourses
              : contentCreatorCourses,
        );
      }
    });
  }
}
