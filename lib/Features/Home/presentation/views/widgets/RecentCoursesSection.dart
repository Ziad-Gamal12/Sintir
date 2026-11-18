import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/Home/presentation/manager/get_courses_cubit/get_courses_cubit.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/RecentCoursesSliverGrid.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/RecentCoursesLoadingSliverGrid.dart';
import 'package:sintir/locale_keys.dart';

class RecentCoursesSection extends StatelessWidget {
  const RecentCoursesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCoursesCubit, GetCoursesState>(
      buildWhen: (prev, curr) =>
          curr is GetRecentCoursesLoading ||
          curr is GetRecentCoursesSuccess ||
          curr is GetRecentCoursesFailure,
      builder: (context, state) {
        if (state is GetRecentCoursesFailure) {
          return SliverToBoxAdapter(
            child: CustomErrorWidget(
              errormessage: state.errmessage,
              onRetry: () => context
                  .read<GetCoursesCubit>()
                  .getRecentCourses(isPaginate: false),
            ),
          );
        } else if (state is GetRecentCoursesSuccess &&
            state.resonseEntity.courses.isNotEmpty) {
          return RecentCoursesSliverGrid(courses: state.resonseEntity.courses);
        } else if (state is GetRecentCoursesSuccess &&
            state.resonseEntity.courses.isEmpty) {
          return SliverToBoxAdapter(
            child: CustomEmptyWidget(text: LocaleKeys.noNewCourses),
          );
        } else {
          return RecentCoursesLoadingSliverGrid();
        }
      },
    );
  }
}
