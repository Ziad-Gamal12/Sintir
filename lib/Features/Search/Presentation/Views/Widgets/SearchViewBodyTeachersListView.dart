import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';
import 'package:sintir/Features/Search/Presentation/Managers/cubit/search_cubit.dart';

import 'search_teachers_empty_widget.dart';
import 'search_teachers_error_widget.dart';
import 'search_teachers_list.dart';
import 'search_teachers_loading_list.dart';

class SearchTeachersListView extends StatelessWidget {
  const SearchTeachersListView({
    super.key,
    required this.teachersList,
  });

  final List<Contentcreaterentity> teachersList;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (previous, current) =>
          current is GetDefaultTeachersSuccess ||
          current is GetDefaultTeachersFailure ||
          current is GetDefaultTeachersLoading ||
          current is SearchLoading ||
          current is SearchFailure ||
          current is SearchSuccess,
      builder: (context, state) {
        if (state is GetDefaultTeachersFailure) {
          return SearchTeachersErrorWidget(errorMessage: state.errorMessage);
        } else if (state is SearchFailure) {
          return SearchTeachersErrorWidget(errorMessage: state.errorMessage);
        } else if (state is GetDefaultTeachersSuccess ||
            state is SearchSuccess && teachersList.isEmpty) {
          return const SearchTeachersEmptyWidget();
        } else if (state is GetDefaultTeachersLoading ||
            state is SearchLoading) {
          return const SearchTeachersLoadingList();
        }

        return SearchTeachersList(teachersList: teachersList);
      },
    );
  }
}
