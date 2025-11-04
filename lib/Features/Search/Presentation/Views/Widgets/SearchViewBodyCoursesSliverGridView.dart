import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Features/Search/Presentation/Managers/cubit/search_cubit.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/earch_courses_empty_widget.dart';

import 'search_courses_error_widget.dart';
import 'search_courses_grid.dart';
import 'search_courses_loading_grid.dart';

class SearchCoursesSliverGridView extends StatelessWidget {
  const SearchCoursesSliverGridView({super.key, required this.courses});

  final List<CourseEntity> courses;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (previous, current) {
        if (current is GetDefaultCoursesSuccess) {
          return true;
        } else if (current is SearchSuccess) {
          return true;
        } else if (current is GetDefaultCoursesFailure) {
          return true;
        } else if (current is SearchFailure) {
          return true;
        } else if (current is GetDefaultCoursesLoading) {
          return true;
        } else if (current is SearchLoading) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is GetDefaultCoursesFailure) {
          return SearchCoursesErrorWidget(errorMessage: state.errorMessage);
        } else if (state is SearchFailure) {
          return SearchCoursesErrorWidget(errorMessage: state.errorMessage);
        } else if (state is GetDefaultCoursesLoading ||
            state is SearchLoading) {
          return const SearchCoursesLoadingGrid();
        } else if ((state is GetDefaultCoursesSuccess ||
                state is SearchSuccess) &&
            courses.isEmpty) {
          return const SearchCoursesEmptyWidget();
        }
        return SearchCoursesGrid(courses: courses);
      },
    );
  }
}
