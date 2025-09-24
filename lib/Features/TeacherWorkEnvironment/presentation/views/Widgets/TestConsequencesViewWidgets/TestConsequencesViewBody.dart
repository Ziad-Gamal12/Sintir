import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/ResultsAnalysisCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/TestResultsSliverGridView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/TestSummaryCard.dart';
import 'package:sintir/constant.dart';

class TestConsequencesViewBody extends StatelessWidget {
  const TestConsequencesViewBody({super.key, required this.test});
  final CourseTestEntity test;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: KHorizontalPadding, vertical: KVerticalPadding),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: TestSummaryCard(test: test)),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 30,
            ),
          ),
          const SliverToBoxAdapter(child: ResultsAnalysisCard()),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 30,
            ),
          ),
          SliverToBoxAdapter(
            child: Text(
              "نتايج الاختبار",
              textAlign: TextAlign.center,
              style: AppTextStyles.bold24.copyWith(color: Colors.black),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          const TestResultsSliverGridView()
        ],
      ),
    );
  }
}
