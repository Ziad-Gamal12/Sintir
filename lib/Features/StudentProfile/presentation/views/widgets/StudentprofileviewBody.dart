// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomFavourtiteListHeader.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomListFavouriteCoursesSection.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomMyCoursesGridHeader.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomprofilemycoursesSlivergridview.dart';
import 'package:sintir/Features/StudentProfile/presentation/views/widgets/Studentprofile_Info.dart';
import 'package:sintir/constant.dart';

class StudentprofileviewBody extends StatelessWidget {
  StudentprofileviewBody({super.key});
  List<CourseEntity> myCourses = [];
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 12,
            ),
          ),
          const SliverToBoxAdapter(
            child: StudentprofileInfo(),
          ),
          const SliverToBoxAdapter(
            child: Divider(
              height: 40,
              color: Color(0xffE5E5EA),
            ),
          ),
          const SliverToBoxAdapter(
            child: Customfavourtitelistheader(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          const SliverToBoxAdapter(
            child: Customlistfavouritecoursessection(),
          ),
          const SliverToBoxAdapter(
            child: Divider(
              height: 40,
              color: Color(0xffE5E5EA),
            ),
          ),
          const SliverToBoxAdapter(
            child: Custommycoursesgridheader(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          CustomprofilemycoursesSlivergridview(
            ontap: () {},
            courses: const [],
          )
        ],
      ),
    );
  }
}
