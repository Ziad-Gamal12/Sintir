import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomListORGridTextHeader.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/HorizentalCoursesListView.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/HorizentalLoadingCoursesListView.dart';
import 'package:sintir/locale_keys.dart';

import '../../manager/get_courses_cubit/get_courses_cubit.dart';

class UserInterestedCoursesSection extends StatelessWidget {
  const UserInterestedCoursesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCoursesCubit, GetCoursesState>(
      buildWhen: (prev, curr) =>
          curr is GetUserInerestCoursesFailure ||
          curr is GetUserInerestCoursesSuccess ||
          curr is GetUserInerestCoursesLoading,
      builder: (context, state) {
        if (state is GetUserInerestCoursesFailure ||
            (state is GetUserInerestCoursesSuccess &&
                state.resonseEntity.courses.isEmpty)) {
          return const SliverToBoxAdapter(child: SizedBox());
        } else if (state is GetUserInerestCoursesLoading) {
          return SliverToBoxAdapter(
              child: Column(
            children: [
              CustomListORGridTextHeader(text: LocaleKeys.recommended),
              const SizedBox(height: 12),
              const HorizentalLoadingCoursesListView(),
            ],
          ));
        } else if (state is GetUserInerestCoursesSuccess) {
          final courses = state.resonseEntity.courses;
          if (courses.isEmpty) {
            return SliverToBoxAdapter(
                child:
                    CustomEmptyWidget(text: LocaleKeys.noRecommendedCourses));
          } else {
            return SliverToBoxAdapter(
              child: Column(
                children: [
                  CustomListORGridTextHeader(text: LocaleKeys.recommended),
                  const SizedBox(height: 12),
                  HorizentalCoursesListView(courses: courses),
                ],
              ),
            );
          }
        } else {
          return SliverToBoxAdapter(
              child: Column(
            children: [
              CustomListORGridTextHeader(text: LocaleKeys.recommended),
              const SizedBox(height: 12),
              const HorizentalLoadingCoursesListView(),
            ],
          ));
        }
      },
    );
  }
}
