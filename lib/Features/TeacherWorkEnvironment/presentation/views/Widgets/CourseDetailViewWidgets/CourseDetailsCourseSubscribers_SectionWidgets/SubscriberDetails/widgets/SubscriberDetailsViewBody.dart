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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.getSubscibersEnrolledCoursesForTeacher(
        subscriberId: widget.requirements.subscriber.id,
        contentCreatorId: widget.requirements.contentCreatorId,
      );
      Future.delayed(const Duration(seconds: 1), () {
        cubit.getSubscriberResults(
          subscriberId: widget.requirements.subscriber.id,
          courseId: widget.requirements.courseId,
        );
      });

      Future.delayed(const Duration(seconds: 1), () {
        cubit.getSubscriberHighestScore(
          subscriberId: widget.requirements.subscriber.id,
          courseId: widget.requirements.courseId,
        );
      });
      Future.delayed(const Duration(seconds: 1), () {
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
    return BlocConsumer<SubscriberDetailsCubit, SubscriberDetailsState>(
      listener: (context, state) {
        if (state is GetSubscriberResultsSuccess) {
          results = state.results;
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
            SliverToBoxAdapter(
              child: CustomSubscriberDetailsCard(
                subscriberentity: widget.requirements.subscriber,
              ),
            ),
            const SliverToBoxAdapter(
              child: SubscriberEnrolledCoursesHeader(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                  height: height * .28,
                  child: const SubscriberEnrolledCoursesListView()),
            ),
            const SliverToBoxAdapter(
              child: Divider(
                height: 40,
                color: Color(0xffE5E5EA),
              ),
            ),
            SliverToBoxAdapter(
              child: SubscriberAnalysisSection(
                results: results,
              ),
            ),
            const SliverToBoxAdapter(
              child: Divider(
                height: 40,
                color: Color(0xffE5E5EA),
              ),
            ),
            SliverToBoxAdapter(
                child:
                    Text("النتائج", style: AppTextStyles(context).semiBold20)),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            SubscriberResultsSliverListView(testResults: results),
          ],
        ),
      ),
    );
  }
}
