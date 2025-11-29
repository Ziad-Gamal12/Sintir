import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/helper/GridHelper.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/ResultDetailsHelper.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/TestResultDetailsRow.dart';
import 'package:sintir/locale_keys.dart';

class ResultDetailsStatsGrid extends StatelessWidget {
  const ResultDetailsStatsGrid({super.key, required this.testresulteEntity});
  final TestResultEntity testresulteEntity;

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            GridHelper.getCrossAxisCount(MediaQuery.of(context).size.width),
        childAspectRatio: 2 / 1.3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        Testresultdetailsrow(
          cardColor: Colors.grey.shade200,
          color: Colors.black,
          headline: LocaleKeys.totalQuestions,
          value: testresulteEntity.totalQuestions.toString(),
        ),
        Testresultdetailsrow(
          cardColor: Colors.blue.shade100,
          color: Colors.blue.shade700,
          headline: LocaleKeys.questionsSolved,
          value: testresulteEntity.questionsSolvedListEntity.length.toString(),
        ),
        Testresultdetailsrow(
          cardColor: Colors.green.shade100,
          color: Colors.green.shade700,
          headline: LocaleKeys.correctQuestions,
          value: ResultDetailsHelper.getSuccessQuestions(testresulteEntity)
              .length
              .toString(),
        ),
        Testresultdetailsrow(
          cardColor: Colors.red.shade100,
          color: Colors.red.shade700,
          headline: LocaleKeys.wrongQuestions,
          value: (testresulteEntity.questionsSolvedListEntity.length -
                  ResultDetailsHelper.getSuccessQuestions(testresulteEntity)
                      .length)
              .toString(),
        ),
      ],
    );
  }
}
