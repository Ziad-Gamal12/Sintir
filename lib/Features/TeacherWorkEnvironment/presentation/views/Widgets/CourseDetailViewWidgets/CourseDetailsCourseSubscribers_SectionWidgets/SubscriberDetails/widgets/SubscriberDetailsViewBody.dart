import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/SubscriberDetailsNavigationRequirements.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/CustomSubscriberDetailsCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberAnalysisSection.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberEnrolledCoursesHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberEnrolledCoursesListView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberResultsSliverListView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberPerformanceSummary.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/subuscriber_details_cubit/subuscriber_details_cubit.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class SubscriberDetailsViewBody extends StatefulWidget {
  const SubscriberDetailsViewBody({super.key, required this.requirements});
  final SubscriberDetailsNavigationRequirements requirements;

  @override
  State<SubscriberDetailsViewBody> createState() =>
      _SubscriberDetailsViewBodyState();
}

class _SubscriberDetailsViewBodyState extends State<SubscriberDetailsViewBody> {
  List<TestResultEntity> results = [];
  SubscriberPerformanceSummary _summary =
      SubscriberPerformanceSummary.fromResults(const []);
  @override
  void initState() {
    super.initState();
    final cubit = context.read<SubscriberDetailsCubit>();
    cubit.getSubscibersEnrolledCoursesForTeacher(
      subscriberId: widget.requirements.subscriber.id,
      contentCreatorId: widget.requirements.contentCreatorId,
    );
    cubit.getSubscriberResults(
      subscriberId: widget.requirements.subscriber.id,
      courseId: widget.requirements.courseId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color headerTextColor = theme.textTheme.bodyLarge!.color!;

    return BlocConsumer<SubscriberDetailsCubit, SubscriberDetailsState>(
      buildWhen: (previous, current) =>
          current is GetSubscriberResultsSuccess ||
          current is GetSubscriberResultsFailure,
      listener: (context, state) {
        if (state is GetSubscriberResultsSuccess) {
          results = state.results;
          _summary = SubscriberPerformanceSummary.fromResults(state.results);
        }
      },
      builder: (context, state) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: KHorizontalPadding,
          vertical: KVerticalPadding,
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CustomSubscriberDetailsCard(
                subscriberentity: widget.requirements.subscriber,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 24,
              ),
            ),
            const SliverToBoxAdapter(
              child: SubscriberEnrolledCoursesHeader(),
            ),

            SliverToBoxAdapter(
              child: const SizedBox(
                height: 220,
                child: SubscriberEnrolledCoursesListView(),
              ),
            ),

            // Divider 1
            SliverToBoxAdapter(
              child: SizedBox(
                height: 24,
              ),
            ),

            SliverToBoxAdapter(
              child: SubscriberAnalysisSection(
                results: results,
                summary: _summary,
              ),
            ),

            // Divider 2
            SliverToBoxAdapter(
              child: SizedBox(
                height: 24,
              ),
            ),

            // Test Results Header
            SliverToBoxAdapter(
                child: Text(LocaleKeys.examResultsHistory,
                    style: AppTextStyles(context)
                        .semiBold20
                        .copyWith(color: headerTextColor))),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),

            // Test Results List
            SubscriberResultsSliverListView(testResults: results),
          ],
        ),
      ),
    );
  }
}
