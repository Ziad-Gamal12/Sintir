import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/Home/presentation/manager/get_courses_cubit/get_courses_cubit.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/HorizentalCoursesListView.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/HorizentalLoadingCoursesListView.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/PopularCoursesSectionHeader.dart';

class PopularCoursesSection extends StatelessWidget {
  const PopularCoursesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const PopularCoursesSectionHeader(),
          const SizedBox(height: 12),
          BlocBuilder<GetCoursesCubit, GetCoursesState>(
            buildWhen: (prev, curr) =>
                curr is GetPopularCoursesLoading ||
                curr is GetPopularCoursesSuccess ||
                curr is GetPopularCoursesFailure,
            builder: (context, state) {
              if (state is GetPopularCoursesFailure) {
                return CustomErrorWidget(errormessage: state.errmessage);
              } else if (state is GetPopularCoursesLoading) {
                return const HorizentalLoadingCoursesListView();
              } else if (state is GetPopularCoursesSuccess) {
                final courses = state.resonseEntity.courses;
                if (courses.isEmpty) {
                  return CustomEmptyWidget(text: "لا يوجد دورات مشهورة");
                } else {
                  return HorizentalCoursesListView(courses: courses);
                }
              }
              return const HorizentalLoadingCoursesListView();
            },
          ),
        ],
      ),
    );
  }
}
