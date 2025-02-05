// ignore_for_file: camel_case_types, file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomListORGridTextHeader.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomSearchTextField.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/HomeViewBodyAppBar.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/bestSellerCourse_ListView.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/leatestCoursesGlideView.dart';
import 'package:sintir/constant.dart';

class Homeview_Body extends StatelessWidget {
  Homeview_Body({super.key});
  TextEditingController homeSearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverToBoxAdapter(
              child: Column(children: [
            const HomeViewBodyAppBar(),
            const SizedBox(
              height: 10,
            ),
            CustomSearchTextField(
              controller: homeSearchController,
            ),
          ])),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverToBoxAdapter(
            child: Column(children: [
              CustomListORGridTextHeader(
                text: "ألاكثر مشاهده",
              ),
              const SizedBox(
                height: 10,
              ),
              Transform.translate(
                  offset: const Offset(16, 0),
                  child: BestsellercourseListview(
                      courses: Variables.TestCoursesList)),
            ]),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverToBoxAdapter(
            child: CustomListORGridTextHeader(
              text: "أحدث الكورسات",
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          Leatestcoursesglideview(
            courses: Variables.TestCoursesList,
          ),
        ],
      ),
    );
  }
}
