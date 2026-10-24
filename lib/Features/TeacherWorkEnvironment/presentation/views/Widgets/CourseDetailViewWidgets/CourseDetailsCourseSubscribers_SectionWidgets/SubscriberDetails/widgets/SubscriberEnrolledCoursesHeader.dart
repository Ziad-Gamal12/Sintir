import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberCoursesCountBadge.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/subuscriber_details_cubit/subuscriber_details_cubit.dart';
import 'package:sintir/locale_keys.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SubscriberEnrolledCoursesHeader extends StatelessWidget {
  const SubscriberEnrolledCoursesHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Color primaryTextColor =
        Theme.of(context).textTheme.bodyLarge!.color!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              LocaleKeys.subscribedCourses,
              style: AppTextStyles(context)
                  .semiBold20
                  .copyWith(color: primaryTextColor),
            ),
            SizedBox(
              width: 8,
            ),
            BlocBuilder<SubscriberDetailsCubit, SubscriberDetailsState>(
                buildWhen: (previous, current) {
              if (current is GetSubscibersEnrolledCoursesForTeacherLoading ||
                  current is GetSubscibersEnrolledCoursesForTeacherFailure ||
                  current is GetSubscibersEnrolledCoursesForTeacherSuccess) {
                return true;
              } else {
                return false;
              }
            }, builder: (context, state) {
              if (state is GetSubscibersEnrolledCoursesForTeacherSuccess ||
                  state is GetSubscibersEnrolledCoursesForTeacherLoading) {
                return Skeletonizer(
                    enabled:
                        state is GetSubscibersEnrolledCoursesForTeacherLoading,
                    child: SubscriberCoursesCountBadge(
                        count: state
                                is GetSubscibersEnrolledCoursesForTeacherSuccess
                            ? state.courses.length
                            : 0));
              } else {
                return SizedBox();
              }
            }),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
