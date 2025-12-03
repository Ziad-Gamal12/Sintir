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
  @override
  void initState() {
    super.initState();
    final cubit = context.read<SubscriberDetailsCubit>();
    // Call services with a small delay to prevent multiple state emissions clashing
    // or to ensure the context is fully available, although `addPostFrameCallback`
    // already helps with the latter. We maintain the original structure for logic.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.getSubscibersEnrolledCoursesForTeacher(
        subscriberId: widget.requirements.subscriber.id,
        contentCreatorId: widget.requirements.contentCreatorId,
      );
      Future.delayed(const Duration(milliseconds: 500), () {
        cubit.getSubscriberResults(
          subscriberId: widget.requirements.subscriber.id,
          courseId: widget.requirements.courseId,
        );
      });

      Future.delayed(const Duration(milliseconds: 1000), () {
        cubit.getSubscriberHighestScore(
          subscriberId: widget.requirements.subscriber.id,
          courseId: widget.requirements.courseId,
        );
      });
      Future.delayed(const Duration(milliseconds: 1500), () {
        cubit.getSubscriberLowestScore(
          subscriberId: widget.requirements.subscriber.id,
          courseId: widget.requirements.courseId,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final ThemeData theme = Theme.of(context);
    final Color dividerColor = theme.dividerColor;
    final Color headerTextColor = theme.textTheme.bodyLarge!.color!;

    return BlocConsumer<SubscriberDetailsCubit, SubscriberDetailsState>(
      listener: (context, state) {
        if (state is GetSubscriberResultsSuccess) {
          // Update results list when results are successfully fetched
          results = state.results;
          // Calculate average score after getting all results
          context.read<SubscriberDetailsCubit>().getSubscriberAverageScore();
        }
      },
      builder: (context, state) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: KHorizontalPadding,
          vertical: KVerticalPadding,
        ),
        child: CustomScrollView(
          slivers: [
            // Subscriber Details Card
            SliverToBoxAdapter(
              child: CustomSubscriberDetailsCard(
                subscriberentity: widget.requirements.subscriber,
              ),
            ),

            // Enrolled Courses Header
            const SliverToBoxAdapter(
              child: SubscriberEnrolledCoursesHeader(),
            ),

            // Enrolled Courses List
            SliverToBoxAdapter(
              child: SizedBox(
                  height: height * .28,
                  child: const SubscriberEnrolledCoursesListView()),
            ),

            // Divider 1
            SliverToBoxAdapter(
              child: Divider(
                height: 40,
                color: dividerColor,
              ),
            ),

            // Analysis Section (Highest, Lowest, Average Scores)
            SliverToBoxAdapter(
              child: SubscriberAnalysisSection(
                results: results,
              ),
            ),

            // Divider 2
            SliverToBoxAdapter(
              child: Divider(
                height: 40,
                color: dividerColor,
              ),
            ),

            // Test Results Header
            SliverToBoxAdapter(
                child: Text(LocaleKeys.results,
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
