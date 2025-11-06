import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Features/MyCourses/Presentation/Manager/cubit/my_courses_cubit.dart';
import 'package:sintir/Features/MyCourses/Presentation/Views/Widgets/MyCoursesViewBodyGridView.dart';
import 'package:sintir/constant.dart';

class MyCoursesViewBody extends StatefulWidget {
  const MyCoursesViewBody({super.key});

  @override
  State<MyCoursesViewBody> createState() => _MyCoursesViewBodyState();
}

class _MyCoursesViewBodyState extends State<MyCoursesViewBody> {
  late ScrollController scrollController;
  List<CourseEntity> myCourses = [];
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<MyCoursesCubit>().getMyCourses(isPaginate: false);
      scrollController.addListener(() {
        if (_canFetchMore()) {
          context.read<MyCoursesCubit>().getMyCourses(
                isPaginate: true,
              );
        }
      });
    });
  }

  bool _canFetchMore() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        hasMore &&
        context.read<MyCoursesCubit>().state is! GetMyCoursesLoading) {
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyCoursesCubit, MyCoursesState>(
        listener: (context, state) {
          if (state is GetMyCoursesSuccess) {
            if (state.isPaginate == true) {
              myCourses.addAll(state.response.courses);
            } else {
              myCourses = state.response.courses;
            }
            hasMore = state.response.hasMore;
            setState(() {});
          }
        },
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(
              horizontal: KHorizontalPadding, vertical: KVerticalPadding),
          child: MyCoursesViewBodyGridView(
            myCourses: myCourses,
            scrollController: scrollController,
          ),
        ));
  }
}
