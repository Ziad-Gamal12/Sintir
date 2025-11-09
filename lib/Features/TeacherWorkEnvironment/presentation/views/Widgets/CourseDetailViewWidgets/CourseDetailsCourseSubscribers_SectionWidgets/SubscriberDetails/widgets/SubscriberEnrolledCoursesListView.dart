import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberEnrolledCoursesListViewLoading.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberEnrolledDisplayedCoursesListView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/subuscriber_details_cubit/subuscriber_details_cubit.dart';
import 'package:sintir/constant.dart';

class SubscriberEnrolledCoursesListView extends StatefulWidget {
  const SubscriberEnrolledCoursesListView({super.key});

  @override
  State<SubscriberEnrolledCoursesListView> createState() =>
      _SubscriberEnrolledCoursesListViewState();
}

class _SubscriberEnrolledCoursesListViewState
    extends State<SubscriberEnrolledCoursesListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriberDetailsCubit, SubscriberDetailsState>(
        buildWhen: (previous, current) {
      if (current is GetSubscibersEnrolledCoursesForTeacherLoading ||
          current is GetSubscibersEnrolledCoursesForTeacherFailure ||
          current is GetSubscibersEnrolledCoursesForTeacherSuccess) {
        return true;
      } else {
        return false;
      }
    }, builder: (context, state) {
      if (state is GetSubscibersEnrolledCoursesForTeacherLoading) {
        return const SubscriberEnrolledCoursesListViewLoading();
      } else if (state is GetSubscibersEnrolledCoursesForTeacherFailure) {
        return CustomErrorWidget(errormessage: state.errmessage);
      } else if (state is GetSubscibersEnrolledCoursesForTeacherSuccess &&
          state.courses.isEmpty) {
        return CustomEmptyWidget(text: "لا يوجد دورات لديه حتى الان");
      } else if (state is GetSubscibersEnrolledCoursesForTeacherSuccess &&
          state.courses.isNotEmpty) {
        return SubscriberEnrolledDisplayedCoursesListView(
            courses: state.courses);
      } else {
        return const CircularProgressIndicator(
          color: KMainColor,
        );
      }
    });
  }
}
