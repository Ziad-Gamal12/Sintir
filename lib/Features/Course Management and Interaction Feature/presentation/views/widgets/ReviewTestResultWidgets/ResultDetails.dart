import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/TestResultDetailsRow.dart';
import 'package:sintir/constant.dart';

class ResultDetails extends StatelessWidget {
  const ResultDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TestresulteEntity testresulteEntity = context.read<TestresulteEntity>();
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          CircularPercentIndicator(
            radius: 80,
            lineWidth: 13.0,
            animation: true,
            percent: (getSuccessQuestions(testresulteEntity: testresulteEntity)
                    .length /
                testresulteEntity.totalQuestions),
            center: Text(
              getResultPercent(testresulteEntity: testresulteEntity),
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            progressColor: KMainColor,
            circularStrokeCap: CircularStrokeCap.round,
          ),
          Divider(
            color: Colors.grey.shade300,
          ),
          Testresultdetailsrow(
              headline: "عدد الأسئلة الكلى:",
              value: testresulteEntity.totalQuestions.toString()),
          const SizedBox(
            height: 8,
          ),
          Testresultdetailsrow(
              headline: "عدد الأسئلة التى تم حلها:",
              value: testresulteEntity.questionsSolvedListEntity.length
                  .toString()),
          const SizedBox(
            height: 8,
          ),
          Testresultdetailsrow(
              headline: "عدد الأسئلة الصحيحة:",
              value: getSuccessQuestions(testresulteEntity: testresulteEntity)
                  .length
                  .toString()),
          const SizedBox(
            height: 8,
          ),
          Testresultdetailsrow(
              headline: "عدد الأسئلة الخاطئة:",
              value: (testresulteEntity.questionsSolvedListEntity.length -
                      getSuccessQuestions(testresulteEntity: testresulteEntity)
                          .length)
                  .toString()),
          Divider(
            color: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }

  List<ExamResultSolvedQuestionEntity> getSuccessQuestions(
      {required TestresulteEntity testresulteEntity}) {
    List<ExamResultSolvedQuestionEntity> successQuestions = [];

    for (var element in testresulteEntity.questionsSolvedListEntity) {
      if (element.isCorrect == true) {
        successQuestions.add(element);
      }
    }
    return successQuestions;
  }

  String getResultPercent({required TestresulteEntity testresulteEntity}) {
    {
      return "${((getSuccessQuestions(testresulteEntity: testresulteEntity).length / testresulteEntity.totalQuestions) * 100).toInt()}%";
    }
  }
}
