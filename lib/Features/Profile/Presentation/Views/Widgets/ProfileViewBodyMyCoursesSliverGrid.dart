import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/GridHelper.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/CourseIntroductionView.dart';
import 'package:sintir/Features/Profile/Presentation/Manager/ProfileCubit/ProfileCubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileViewBodyMyCoursesSliverGrid extends StatelessWidget {
  const ProfileViewBodyMyCoursesSliverGrid(
      {super.key, required this.myCourses});
  final List<CourseEntity> myCourses;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      if (state is GetMyCoursesFailure) {
        return SliverToBoxAdapter(
          child: Center(
            child: CustomErrorWidget(errormessage: state.errmessage),
          ),
        );
      } else if (state is GetMyCoursesLoading && state.isPaginate == false) {
        return SliverToBoxAdapter(
          child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: getFakeLoadingList().length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: GridHelper.getAspectRatio(
                      maxWidth: MediaQuery.of(context).size.width),
                  crossAxisCount: GridHelper.getCrossAxisCount(
                      MediaQuery.of(context).size.width)),
              itemBuilder: (context, index) {
                return Skeletonizer(
                    enabled: true,
                    child: CustomCourseItem(
                      ontap: () {},
                      courseItem: getFakeLoadingList()[index],
                    ));
              }),
        );
      } else {
        return SliverGrid.builder(
            itemCount: myCourses.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: GridHelper.getCrossAxisCount(
                  MediaQuery.of(context).size.width),
              childAspectRatio: GridHelper.getAspectRatio(
                  maxWidth: MediaQuery.of(context).size.width),
            ),
            itemBuilder: (context, index) {
              return CustomCourseItem(
                courseItem: myCourses[index],
                ontap: () {
                  GoRouter.of(context).push(CourseIntroductionView.routeName,
                      extra:
                          DisplayCourseBottomsheetNavigationRequirmentsEntity(
                              course: myCourses[index], isSubscribed: true));
                },
              );
            });
      }
    });
  }

  List<CourseEntity> getFakeLoadingList() {
    return List.generate(6, (index) => CourseEntity.empty());
  }
}
