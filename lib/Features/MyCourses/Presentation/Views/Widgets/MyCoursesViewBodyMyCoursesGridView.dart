import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/GridHelper.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/CourseIntroductionView.dart';
import 'package:sintir/Features/MyCourses/Presentation/Manager/cubit/my_courses_cubit.dart';
import 'package:sintir/Features/MyCourses/Presentation/Views/Widgets/MyCoursesGridViewLoading.dart';

class MyCoursesViewBodyMyCoursesGridView extends StatelessWidget {
  const MyCoursesViewBodyMyCoursesGridView({
    super.key,
    required this.myCourses,
    required this.scrollController,
  });
  final ScrollController scrollController;
  final List<CourseEntity> myCourses;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MyCoursesCubit, MyCoursesState, bool>(
      selector: (state) {
        return state is GetMyCoursesLoading && state.isPaginate == true;
      },
      builder: (context, isLoading) {
        return GridView.builder(
          controller: scrollController,
          itemCount: isLoading ? myCourses.length + 1 : myCourses.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                GridHelper.getCrossAxisCount(MediaQuery.of(context).size.width),
            childAspectRatio: GridHelper.getAspectRatio(
                maxWidth: MediaQuery.of(context).size.width),
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          itemBuilder: (context, index) =>
              isLoading && index == myCourses.length
                  ? const MyCoursesGridViewLoading()
                  : CustomCourseItem(
                      courseItem: myCourses[index],
                      ontap: () {
                        GoRouter.of(context).push(
                            CourseIntroductionView.routeName,
                            extra:
                                DisplayCourseBottomsheetNavigationRequirmentsEntity(
                                    course: myCourses[index],
                                    isSubscribed: true));
                      },
                    ),
        );
      },
    );
  }
}
