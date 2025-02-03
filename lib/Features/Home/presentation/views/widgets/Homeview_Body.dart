// ignore_for_file: camel_case_types, file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomSearchTextField.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/BestSellerCoursesHeader.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/HomeViewBodyAppBar.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/bestSellerCourse_ListView.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/leatestCoursesGlideView.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/leatestCoursesHeader.dart';
import 'package:sintir/constant.dart';

class Homeview_Body extends StatelessWidget {
  Homeview_Body({super.key});
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: Variables.scrollController,
      slivers: [
        SliverToBoxAdapter(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const HomeViewBodyAppBar(),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomSearchTextField(
                    controller: controller,
                  ),
                ]))),
        SliverToBoxAdapter(
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(right: KHorizontalPadding),
              child: BestSellerCoursesHeader(),
            ),
            const SizedBox(
              height: 10,
            ),
            BestsellercourseListview(courses: Variables.TestCoursesList),
            const SizedBox(
              height: 20,
            ),
          ]),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
            child: Column(
              children: [
                const Leatestcoursesheader(),
                const SizedBox(
                  height: 10,
                ),
                Leatestcoursesglideview(
                  courses: Variables.TestCoursesList,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
