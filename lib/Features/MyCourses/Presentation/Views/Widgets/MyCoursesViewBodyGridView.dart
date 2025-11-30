import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/MyCourses/Presentation/Manager/cubit/my_courses_cubit.dart';
import 'package:sintir/Features/MyCourses/Presentation/Views/Widgets/MyCoursesGridViewLoading.dart';
import 'package:sintir/Features/MyCourses/Presentation/Views/Widgets/MyCoursesViewBodyMyCoursesGridView.dart';
import 'package:sintir/locale_keys.dart';

class MyCoursesViewBodyGridView extends StatefulWidget {
  const MyCoursesViewBodyGridView(
      {super.key, required this.myCourses, required this.scrollController});
  final List<CourseEntity> myCourses;
  final ScrollController scrollController;
  @override
  State<MyCoursesViewBodyGridView> createState() =>
      _MyCoursesViewBodyGridViewState();
}

class _MyCoursesViewBodyGridViewState extends State<MyCoursesViewBodyGridView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyCoursesCubit, MyCoursesState>(
      builder: (context, state) {
        if (state is GetMyCoursesFailure) {
          return CustomErrorWidget(errormessage: state.errmessage);
        } else if (state is GetMyCoursesLoading &&
            widget.myCourses.isEmpty &&
            state.isPaginate == false) {
          return const MyCoursesGridViewLoading();
        } else if (state is GetMyCoursesSuccess && widget.myCourses.isEmpty) {
          return CustomEmptyWidget(
            text: LocaleKeys.emptyContent,
          );
        } else {
          return MyCoursesViewBodyMyCoursesGridView(
              scrollController: widget.scrollController,
              myCourses: widget.myCourses);
        }
      },
    );
  }
}
