// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/user_cubit/user_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomFavourtiteListHeader.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomListFavouriteCoursesSection.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomMyCoursesGridHeader.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomprofilemycoursesSlivergridview.dart';
import 'package:sintir/Core/widgets/ScreenErrorwidget.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Entities/teacherEntity.dart';
import 'package:sintir/Features/TeacherProfile/presentation/views/widgets/CustomTeacherProfileContactSection.dart';
import 'package:sintir/Features/TeacherProfile/presentation/views/widgets/CustomWorkEnvironmentText.dart';
import 'package:sintir/Features/TeacherProfile/presentation/views/widgets/TeacherprofileInfo.dart';
import 'package:sintir/constant.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TeacherprofileviewBody extends StatelessWidget {
  TeacherprofileviewBody({super.key});

  List<CourseEntity> myCourses = [];

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is GetMyCourseSuccess) {
          myCourses = state.courses;
        } else if (state is GetMyCourseLoading || state is GetUserDataLoading) {
          isLoading = true;
        }
      },
      builder: (context, state) {
        if (state is GetMyCourseFailure) {
          return ScreenErrorwidget(
            errMessage: state.errMessage,
          );
        }
        teacherEntity? teacher = context.read<UserCubit>().teacherentity;
        return Skeletonizer(
          enabled: isLoading,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: teacher != null
                      ? TeacherprofileInfo(
                          teacherentity: teacher,
                        )
                      : ScreenErrorwidget(
                          errMessage: "لا يوجد معلومات",
                        ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Customteacherprofilecontactsection(
                    socailLinks: teacher != null ? teacher.socialLinks : [],
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 32,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Customfavourtitelistheader(),
                      SizedBox(
                        height: 10,
                      ),
                      Customlistfavouritecoursessection()
                    ],
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Divider(
                    height: 40,
                    color: Color(0xffE5E5EA),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Custommycoursesgridheader(),
                          const Spacer(),
                          CustomWorkEnvironmentText(
                            myCourses: myCourses,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                myCourses.isEmpty
                    ? const SliverToBoxAdapter(
                        child: Center(
                          child: Text("لا يوجد دورات"),
                        ),
                      )
                    : CustomprofilemycoursesSlivergridview(
                        ontap: () {},
                        courses: myCourses,
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}
