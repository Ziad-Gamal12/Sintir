import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Features/Search/Presentation/Managers/cubit/search_cubit.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/SearchViewBodyCoursesSliverGridView.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/SearchViewBodySearchAndFilterSection.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/SearchViewBodySearchViewBodyCoursesListHeader.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/search_teachers_section.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/search_view_controller.dart';
import 'package:sintir/constant.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  final SearchViewController _controller = SearchViewController();

  List<CourseEntity> defaultCourses = [];
  List<Contentcreaterentity> defaultTeachers = [];
  List<CourseEntity> searchedCourses = [];
  List<Contentcreaterentity> searchedTeachers = [];

  @override
  void initState() {
    super.initState();
    _controller.init(context, filters: null, userId: null);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {
        if (state is GetDefaultCoursesSuccess) {
          defaultCourses = state.searchResponse.fetchedTeachersCoursesList;
        } else if (state is GetDefaultTeachersSuccess) {
          defaultTeachers = state.searchResponse.fetchedTeachersList;
        } else if (state is SearchSuccess) {
          searchedCourses = state.searchResponse.fetchedTeachersCoursesList;
          searchedTeachers = state.searchResponse.fetchedTeachersList;
        }
      },
      builder: (context, state) {
        final bool isSearching = _controller.isSearching;
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: KHorizontalPadding, vertical: KVerticalPadding),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SearchViewBodySearchAndFilterSection(
                    isSearching: isSearching,
                    controller: _controller.textController),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverToBoxAdapter(
                child: SearchTeachersSection(
                  teachers:
                      isSearching == true ? searchedTeachers : defaultTeachers,
                ),
              ),
              const SliverToBoxAdapter(
                  child: Divider(height: 40, color: Color(0xffE5E5EA))),
              const SliverToBoxAdapter(
                child: SearchViewBodySearchViewBodyCoursesListHeader(),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 10),
              ),
              SearchCoursesSliverGridView(
                  courses:
                      isSearching == true ? searchedCourses : defaultCourses),
            ],
          ),
        );
      },
    );
  }
}
