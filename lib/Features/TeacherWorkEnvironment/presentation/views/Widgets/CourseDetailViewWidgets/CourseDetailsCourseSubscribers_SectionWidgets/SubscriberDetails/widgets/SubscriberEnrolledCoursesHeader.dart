import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberCoursesCountBadge.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/subscriber_section_header.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/subuscriber_details_cubit/subuscriber_details_cubit.dart';
import 'package:sintir/locale_keys.dart';

class SubscriberEnrolledCoursesHeader extends StatelessWidget {
  const SubscriberEnrolledCoursesHeader({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SubscriberDetailsCubit, SubscriberDetailsState>(
        buildWhen: (_, state) =>
            state is GetSubscibersEnrolledCoursesForTeacherLoading ||
            state is GetSubscibersEnrolledCoursesForTeacherFailure ||
            state is GetSubscibersEnrolledCoursesForTeacherSuccess,
        builder: (context, state) {
          final count = state is GetSubscibersEnrolledCoursesForTeacherSuccess
              ? state.courses.length
              : 0;
          return Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
            child: Skeletonizer(
              enabled: state is GetSubscibersEnrolledCoursesForTeacherLoading,
              child: SubscriberSectionHeader(
                title: LocaleKeys.subscriberSubscriptionsTitle,
                trailing: state is GetSubscibersEnrolledCoursesForTeacherFailure
                    ? null
                    : SubscriberCoursesCountBadge(count: count),
              ),
            ),
          );
        },
      );
}
