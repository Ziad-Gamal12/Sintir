// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomFavourtiteListHeader.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomListFavouriteCoursesSection.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomMyCoursesGridHeader.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomprofilemycoursesSlivergridview.dart';
import 'package:sintir/Features/TeacherProfile/presentation/views/widgets/CustomWorkEnvironmentText.dart';
import 'package:sintir/Features/TeacherProfile/presentation/views/widgets/TeacherprofileInfo.dart';
import 'package:sintir/constant.dart';

class TeacherprofileviewBody extends StatelessWidget {
  TeacherprofileviewBody({super.key});

  List<CourseEntity> myCourses = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: TeacherprofileInfo()),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
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
    );
  }
}
