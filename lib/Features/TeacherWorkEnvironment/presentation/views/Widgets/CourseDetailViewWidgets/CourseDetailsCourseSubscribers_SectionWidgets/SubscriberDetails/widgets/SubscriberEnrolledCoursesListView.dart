import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomCourseItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/CourseDetailView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/subuscriber_details_cubit/subuscriber_details_cubit.dart';
import 'package:sintir/locale_keys.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SubscriberEnrolledCoursesListView extends StatelessWidget {
  const SubscriberEnrolledCoursesListView({super.key, this.onRetry});
  final VoidCallback? onRetry;

  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<SubscriberDetailsCubit, SubscriberDetailsState>(
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
        child: LayoutBuilder(
          builder: (context, box) {
            final textScale = MediaQuery.textScalerOf(
              context,
            ).scale(1).clamp(1.0, 1.3).toDouble();
            final cardWidth = (box.maxWidth * .615)
                .clamp(230.0, 280.0)
                .toDouble()
                .toDouble();
            final cardHeight = cardWidth / 1.03 * textScale;
            return SizedBox(
              height: cardHeight,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                itemCount: courses.length,
                separatorBuilder: (_, _) => const SizedBox(width: 12),
                itemBuilder: (context, index) => SizedBox(
                  width: cardWidth,
                  child: CustomCourseItem(
                    courseItem: courses[index],
                    ontap: loading
                        ? () {}
                        : () => GoRouter.of(context).push(
                            CourseDetailView.routeName,
                            extra: courses[index],
                          ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
