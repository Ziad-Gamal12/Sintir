import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TestConsequencesViewRequirements.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/ResultsAnalysisCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/TestResultsSliverListView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/TestSummaryCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/get_exam_results_cubit/get_exam_results_cubit.dart';
import 'package:sintir/constant.dart';

class TestConsequencesViewBody extends StatefulWidget {
  const TestConsequencesViewBody({super.key, required this.requirements});
  final TestConsequencesViewRequirements requirements;

  @override
  State<TestConsequencesViewBody> createState() =>
      _TestConsequencesViewBodyState();
}

class _TestConsequencesViewBodyState extends State<TestConsequencesViewBody> {
  late ScrollController scrollController;
  List<TestResultEntity> results = [];
  bool hasMore = true;
  VoidCallback? _scrollListener;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    final getExamResultsCubit = context.read<GetExamResultsCubit>();
    getExamResultsCubit.getTestResults(
        isPaginate: false,
        courseId: widget.requirements.courseID,
        sectionId: widget.requirements.sectionID,
        examId: widget.requirements.test.id);
    _scrollListener = () {
      if (!mounted) return;
      if (_shouldFetchMoreSections(getExamResultsCubit)) {
        getExamResultsCubit.getTestResults(
            isPaginate: true,
            courseId: widget.requirements.courseID,
            sectionId: widget.requirements.sectionID,
            examId: widget.requirements.test.id);
      }
    };

    scrollController.addListener(_scrollListener!);
  }

  bool _shouldFetchMoreSections(GetExamResultsCubit cubit) {
    return scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        hasMore &&
        cubit.state is! GetExamResultsLoading;
  }

  @override
  void dispose() {
    if (_scrollListener != null) {
      scrollController.removeListener(_scrollListener!);
    }
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetExamResultsCubit, GetExamResultsState>(
      listener: (context, state) {
        if (state is GetExamResultsSuccess) {
          if (state.getExamResultsReponseEntity.isPaginate) {
            setState(() {
              results.addAll(state.getExamResultsReponseEntity.results);
            });
          } else {
            setState(() {
              results = state.getExamResultsReponseEntity.results;
            });
          }
          hasMore = state.getExamResultsReponseEntity.hasMore;
        }
      },
      builder: (context, state) => Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: KHorizontalPadding, vertical: KVerticalPadding),
        child: CustomScrollView(
          key: const PageStorageKey("TestConsequencesViewBody"),
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
                child: TestSummaryCard(requirements: widget.requirements)),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 30,
              ),
            ),
            SliverToBoxAdapter(
                child: ResultsAnalysisCard(
              requirements: widget.requirements,
            )),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 30,
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                "نتايج الاختبار",
                textAlign: TextAlign.center,
                style:
                    AppTextStyles(context).bold24.copyWith(color: Colors.black),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            TestResultsSliverListView(
              testResults: results,
            ),
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: (state is GetExamResultsLoading && state.isPaginate)
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: KMainColor,
                    ))
                  : null,
            )),
          ],
        ),
      ),
    );
  }
}
