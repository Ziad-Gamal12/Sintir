// ignore_for_file: camel_case_types, file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomSearchTextField.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/BestSellerCoursesHeader.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/HomeViewBodyAppBar.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/ads_ListView.dart';
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
        const SliverToBoxAdapter(
          child: AdsListview(),
        ),
        const SliverToBoxAdapter(
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(right: KHorizontalPadding),
              child: BestSellerCoursesHeader(),
            ),
            SizedBox(
              height: 10,
            ),
            BestsellercourseListview(),
            SizedBox(
              height: 20,
            ),
          ]),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: KHorizontalPadding),
            child: Column(
              children: [
                Leatestcoursesheader(),
                SizedBox(
                  height: 10,
                ),
                Leatestcoursesglideview(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
