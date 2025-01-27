import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomFavourtiteListHeader.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomListFavouriteCoursesSection.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomMyCoursesGridHeader.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomprofilemycoursesSlivergridview.dart';
import 'package:sintir/Features/TeacherProfile/presentation/views/widgets/CustomTeacherProfileContactSection.dart';
import 'package:sintir/Features/TeacherProfile/presentation/views/widgets/CustomWorkEnvironmentText.dart';
import 'package:sintir/Features/TeacherProfile/presentation/views/widgets/TeacherprofileInfo.dart';
import 'package:sintir/constant.dart';

class TeacherprofileviewBody extends StatelessWidget {
  const TeacherprofileviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: KHorizontalPadding),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: TeacherprofileInfo(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverToBoxAdapter(
            child: Customteacherprofilecontactsection(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 32,
            ),
          ),
          SliverToBoxAdapter(
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
          SliverToBoxAdapter(
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
                    Custommycoursesgridheader(),
                    Spacer(),
                    CustomWorkEnvironmentText(),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          CustomprofilemycoursesSlivergridview()
        ],
      ),
    );
  }
}
