import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomFavourtiteListHeader.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomListFavouriteCoursesSection.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomMyCoursesGridHeader.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomprofilemycoursesSlivergridview.dart';
import 'package:sintir/Features/StudentProfile/presentation/views/widgets/Studentprofile_Info.dart';
import 'package:sintir/constant.dart';

class StudentprofileviewBody extends StatelessWidget {
  const StudentprofileviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: KHorizontalPadding),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 12,
            ),
          ),
          SliverToBoxAdapter(
            child: StudentprofileInfo(),
          ),
          SliverToBoxAdapter(
            child: Divider(
              height: 40,
              color: Color(0xffE5E5EA),
            ),
          ),
          SliverToBoxAdapter(
            child: Customfavourtitelistheader(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          SliverToBoxAdapter(
            child: Customlistfavouritecoursessection(),
          ),
          SliverToBoxAdapter(
            child: Divider(
              height: 40,
              color: Color(0xffE5E5EA),
            ),
          ),
          SliverToBoxAdapter(
            child: Custommycoursesgridheader(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          CustomprofilemycoursesSlivergridview()
        ],
      ),
    );
  }
}
