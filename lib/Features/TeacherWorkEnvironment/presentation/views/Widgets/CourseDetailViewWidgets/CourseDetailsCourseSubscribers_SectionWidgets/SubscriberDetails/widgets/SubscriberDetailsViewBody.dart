import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/SubscriberDetailsNavigationRequirements.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/CustomSubscriberDetailsCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberAnalysisSection.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberEnrolledCoursesHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberEnrolledCoursesListView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberResultsSliverListView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/subscriber_details_adaptive_layout.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/subuscriber_details_cubit/subuscriber_details_cubit.dart';

class SubscriberDetailsViewBody extends StatefulWidget {
  const SubscriberDetailsViewBody({super.key, required this.requirements});
  final SubscriberDetailsNavigationRequirements requirements;

  @override
  State<SubscriberDetailsViewBody> createState() =>
      _SubscriberDetailsViewBodyState();
}

class _SubscriberDetailsViewBodyState extends State<SubscriberDetailsViewBody> {
  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    final cubit = context.read<SubscriberDetailsCubit>();
    await Future.wait([
      cubit.getSubscibersEnrolledCoursesForTeacher(
        subscriberId: widget.requirements.subscriber.id,
        contentCreatorId: widget.requirements.contentCreatorId,
      ),
      cubit.getSubscriberResults(
        subscriberId: widget.requirements.subscriber.id,
        courseId: widget.requirements.courseId,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) => RefreshIndicator.adaptive(
    onRefresh: _refresh,
    child: SubscriberDetailsAdaptiveLayout(
      profile: CustomSubscriberDetailsCard(
        subscriberentity: widget.requirements.subscriber,
      ),
      courses: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SubscriberEnrolledCoursesHeader(),
          const SizedBox(height: 12),
          SubscriberEnrolledCoursesListView(onRetry: _refresh),
        ],
      ),
      analysis: SubscriberAnalysisSection(onRetry: _refresh),
      timeline: SubscriberResultsSliverListView(
        courseTitle: null,
        onRetry: _refresh,
      ),
    ),
  );
}
