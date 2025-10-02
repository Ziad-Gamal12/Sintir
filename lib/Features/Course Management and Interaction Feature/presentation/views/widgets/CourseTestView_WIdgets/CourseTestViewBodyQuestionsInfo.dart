// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestViewNavigationsRequirmentsEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/courseTestViewBodyDetailsItem.dart';

class CourseTestViewBodyQuestionsInfo extends StatelessWidget {
  CourseTestViewBodyQuestionsInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    CourseTestEntity test = context
        .read<CourseExamViewNavigationsRequirmentsEntity>()
        .test; //widget.coursetestentity>

    return Column(
      children: [
        Coursetestviewbodydetailsitem(
            title: "عدد الأسئلة الكلى",
            count: test.questions.length.toString(),
            countColor: Colors.grey.shade400,
            countTextColor: Colors.black),
        const SizedBox(
          height: 10,
        ),
        StreamBuilder<Object>(
            stream: getSolvedQuestions(test: test),
            builder: (context, snapshot) {
              return Coursetestviewbodydetailsitem(
                  title: "عدد الأسئلة التى تم حلها ",
                  count: snapshot.data.toString(),
                  countColor: Colors.green,
                  countTextColor: Colors.white);
            }),
        const SizedBox(
          height: 10,
        ),
        StreamBuilder<Object>(
            stream: getUnSolvedQuestions(coursetestentity: test),
            builder: (context, snapshot) {
              return Coursetestviewbodydetailsitem(
                  title: "عدد الأسئلة التى  لم يتم حلها ",
                  count: snapshot.data.toString(),
                  countColor: Colors.red,
                  countTextColor: Colors.white);
            }),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  int solvedcount = 0;

  Stream<Object>? getSolvedQuestions({required CourseTestEntity test}) {
    for (var question in test.questions) {
      if (question.selectedSolution != "") {
        solvedcount++;
      }
    }
    return Stream.value(solvedcount);
  }

  Stream<Object>? getUnSolvedQuestions(
      {required CourseTestEntity coursetestentity}) {
    int unsolvedcount = coursetestentity.questions.length - solvedcount;
    return Stream.value(unsolvedcount);
  }
}
