import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
import 'package:sintir/Core/responsive/drag_scroll_configuration.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';
import 'package:sintir/Core/widgets/CustomCourseBottomSheet/CourseBottomSheet.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/subuscriber_details_cubit/subuscriber_details_cubit.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SubscriberEnrolledCoursesListView extends StatelessWidget {
  const SubscriberEnrolledCoursesListView({super.key, this.onRetry});
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => _buildList(
        context,
        ((constraints.maxWidth - 32) * .44).clamp(150.0, 230.0).toDouble(),
      ),
    );
  }

  Widget _buildList(BuildContext context, double itemWidth) {
    final itemHeight = CourseCardMetrics.heightForWidth(context, itemWidth);

    return BlocBuilder<SubscriberDetailsCubit, SubscriberDetailsState>(
      buildWhen: (_, state) =>
          state is GetSubscibersEnrolledCoursesForTeacherLoading ||
          state is GetSubscibersEnrolledCoursesForTeacherFailure ||
          state is GetSubscibersEnrolledCoursesForTeacherSuccess,
      builder: (context, state) {
        if (state is GetSubscibersEnrolledCoursesForTeacherFailure) {
          return Column(
            children: [
              CustomErrorWidget(errormessage: state.errmessage),
              if (onRetry != null)
                TextButton(
                  onPressed: onRetry,
                  child: Text(LocaleKeys.resultsRetry),
                ),
            ],
          );
        }
        if (state is GetSubscibersEnrolledCoursesForTeacherSuccess &&
            state.courses.isEmpty) {
          return CustomEmptyWidget(text: LocaleKeys.noCourses);
        }
        final loading = state is! GetSubscibersEnrolledCoursesForTeacherSuccess;
        final courses = loading ? CourseEntity.fakeCourses : state.courses;
        return Skeletonizer(
          enabled: loading,
          child: SizedBox(
            height: itemHeight,
            child: DragScrollConfiguration(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                padding: EdgeInsets.symmetric(horizontal: KHorizontalPadding),
                itemCount: courses.length,
                separatorBuilder: (_, _) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final course = courses[index];
                  return SizedBox(
                    width: itemWidth,
                    child: CustomCourseItem(
                      courseItem: course,
                      ontap: () => showCustomBottomSheet(
                        child: CourseBottomSheet(courseEntity: course),
                        context: context,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
