// ignore_for_file: camel_case_types, file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/widgets/CustomListORGridTextHeader.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomSearchTextField.dart';
import 'package:sintir/Features/Home/presentation/manager/get_courses_cubit/get_courses_cubit.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/HomeViewBodyAppBar.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/bestSellerCourse_ListView.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/leatestCoursesGlideView.dart';
import 'package:sintir/constant.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Homeview_Body extends StatefulWidget {
  const Homeview_Body({super.key});

  @override
  State<Homeview_Body> createState() => _Homeview_BodyState();
}

class _Homeview_BodyState extends State<Homeview_Body> {
  TextEditingController homeSearchController = TextEditingController();
  @override
  void initState() {
    context.read<GetCoursesCubit>().getRecentCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCoursesCubit, GetCoursesState>(
      builder: (context, state) {
        return state is GetCoursesFailure
            ? const Center(child: Text("Error"))
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
                child: Skeletonizer(
                  enabled: state is GetCoursesloading,
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
                                  courses: state is GetCoursesSuccess
                                      ? state.courses
                                      : [])),
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
                        courses:
                            state is GetCoursesSuccess ? state.courses : [],
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
