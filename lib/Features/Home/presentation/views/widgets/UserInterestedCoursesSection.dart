import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomListORGridTextHeader.dart';
import 'package:sintir/Features/Home/presentation/views/MoreInterestedCoursesView.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/HorizentalCoursesListView.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/HorizentalLoadingCoursesListView.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

import '../../manager/get_courses_cubit/get_courses_cubit.dart';

class UserInterestedCoursesSection extends StatelessWidget {
  const UserInterestedCoursesSection({super.key});

  static String? recommendationReason() {
    final user = getUserData();
    if (user.role == BackendEndpoints.studentRole) {
      final level = user.studentExtraDataEntity?.educationLevel.trim() ?? '';
      if (level.isEmpty) return null;
      return LocaleKeys.recommendedForLevel(LocaleKeys.courseLevelName(level));
    }
    if (user.role == BackendEndpoints.teacherRole) {
      final subject = user.teacherExtraDataEntity?.subject.trim() ?? '';
      if (subject.isEmpty) return null;
      return LocaleKeys.recommendedForSubject(
        LocaleKeys.courseSubjectName(subject),
      );
    }
    return null;
  }

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
                CustomListORGridTextHeader(
                  text: LocaleKeys.recommended,
                  subtitle: recommendationReason(),
                ),
                const SizedBox(height: 12),
                const HorizentalLoadingCoursesListView(),
              ],
            ),
          );
        } else if (state is GetUserInerestCoursesSuccess) {
          final courses = state.resonseEntity.courses;
          if (courses.isEmpty) {
            return SliverToBoxAdapter(
              child: CustomEmptyWidget(text: LocaleKeys.noRecommendedCourses),
            );
          }
          return SliverToBoxAdapter(
            child: Column(
              children: [
                CustomListORGridTextHeader(
                  text: LocaleKeys.recommended,
                  subtitle: recommendationReason(),
                  trailing: InkWell(
                    child: Text(
                      LocaleKeys.seeMore,
                      style: AppTextStyles(
                        context,
                      ).semiBold14.copyWith(color: KMainColor),
                    ),
                    onTap: () {
                      GoRouter.of(
                        context,
                      ).push(MoreInterestedCoursesView.routeName);
                    },
                  ),
                ),
                const SizedBox(height: 12),
                HorizentalCoursesListView(courses: courses),
              ],
            ),
          );
        }
        return const SliverToBoxAdapter(child: SizedBox());
      },
    );
  }
}
