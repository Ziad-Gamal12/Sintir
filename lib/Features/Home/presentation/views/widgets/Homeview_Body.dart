// ignore_for_file: camel_case_types, file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/user_cubit/user_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/CustomListORGridTextHeader.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomSearchTextField.dart';
import 'package:sintir/Core/widgets/ScreenErrorwidget.dart';
import 'package:sintir/Core/widgets/customRefreshWidget.dart';
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
    context.read<GetCoursesCubit>().getPopularCourses();
    super.initState();
  }

  bool isLoading = false;
  List<CourseEntity> recentCourses = [];
  List<CourseEntity> popularCourses = [];

  @override
  Widget build(BuildContext context) {
    return Customrefreshwidget(
      onRefresh: () async {
        context.read<GetCoursesCubit>().handleRefresh();
      },
      child: BlocConsumer<GetCoursesCubit, GetCoursesState>(
          builder: (context, state) {
        if (state is GetCoursesFailure) {
          return ScreenErrorwidget(
            errMessage: state.errmessage,
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
          child: Skeletonizer(
            enabled: state is GetCoursesLoading,
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                SliverToBoxAdapter(
                    child: Column(children: [
                  HomeViewBodyAppBar(
                    teacher: context.read<UserCubit>().teacherentity,
                    student: context.read<UserCubit>().studententity,
                  ),
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
                        child:
                            BestsellercourseListview(courses: popularCourses)),
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
                  courses: recentCourses,
                ),
              ],
            ),
          ),
        );
      }, listener: (context, state) {
        if (state is GetCoursesLoading) {
          isLoading = true;
        } else if (state is GetRecentCoursesSuccess) {
          recentCourses = state.courses;
        } else if (state is GetPopularCoursesSuccess) {
          popularCourses = state.courses;
        }
      }),
    );
  }
}
