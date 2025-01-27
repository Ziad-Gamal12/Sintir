import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomMyCoursesGridHeader.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomprofilemycoursesSlivergridview.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/AddCourseView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkEnvironmentCourses_info.dart';
import 'package:sintir/constant.dart';

class TeacherWorkenvironmentviewBody extends StatelessWidget {
  const TeacherWorkenvironmentviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          const SliverToBoxAdapter(
            child: TeacherworkenvironmentcoursesInfo(),
          ),
          const SliverToBoxAdapter(
            child: Divider(
              height: 40,
              color: Color(0xffE5E5EA),
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                const Custommycoursesgridheader(),
                const Spacer(),
                SizedBox(
                  width: 140,
                  child: Custombutton(
                      text: "اضافة كورس",
                      color: const Color(0xffF3F2F7),
                      textColor: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                      onPressed: () {
                        GoRouter.of(context).push(Addcourseview.routeName);
                      }),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          const CustomprofilemycoursesSlivergridview()
        ],
      ),
    );
  }
}
