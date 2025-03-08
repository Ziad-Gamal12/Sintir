import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/courseTestView.dart';

class Coursetestentity {
  int durationTime;
  String title;
  final List<Coursetestquestionentity> questions;
  String? type;
  String preffixImage = Assets.assetsImagesExamIcon;
  ontap({required BuildContext context, required Coursetestentity item}) {
    GoRouter.of(context).push(Coursetestview.routename, extra: item);
  }

  Coursetestentity({
    required this.title,
    required this.durationTime,
    required this.questions,
    this.type,
  });

  void addQuestion(Coursetestquestionentity? question) {
    if (question != null) {
      questions.add(question);
    }
    questions.add(Coursetestquestionentity(
        isOpened: false,
        questionTitle: "",
        solutions: [
          Coursetestquestionsolutionentity(answer: "", isCorrect: false)
        ]));
  }

  void removeQuestion(Coursetestquestionentity question) {
    questions.remove(question);
  }
}
