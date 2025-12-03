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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color adjustCardColor(Color lightColor, Color darkColor) =>
        isDark ? darkColor : lightColor;

    Color adjustTextColor(Color lightColor, Color darkColor) =>
        isDark ? darkColor : lightColor;

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
          cardColor:
              adjustCardColor(Colors.grey.shade200, Colors.grey.shade800),
          color: adjustTextColor(Colors.black, Colors.white),
          headline: LocaleKeys.totalQuestions,
          value: testresulteEntity.totalQuestions.toString(),
        ),
        Testresultdetailsrow(
          cardColor:
              adjustCardColor(Colors.blue.shade100, Colors.blue.shade900),
          color: adjustTextColor(Colors.blue.shade700, Colors.blue.shade300),
          headline: LocaleKeys.questionsSolved,
          value: testresulteEntity.questionsSolvedListEntity.length.toString(),
        ),
        Testresultdetailsrow(
          cardColor:
              adjustCardColor(Colors.green.shade100, Colors.green.shade900),
          color: adjustTextColor(Colors.green.shade700, Colors.green.shade300),
          headline: LocaleKeys.correctQuestions,
          value: ResultDetailsHelper.getSuccessQuestions(testresulteEntity)
              .length
              .toString(),
        ),
        Testresultdetailsrow(
          cardColor: adjustCardColor(Colors.red.shade100, Colors.red.shade900),
          color: adjustTextColor(Colors.red.shade700, Colors.red.shade300),
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
