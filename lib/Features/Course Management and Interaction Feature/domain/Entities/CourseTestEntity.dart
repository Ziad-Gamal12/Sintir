import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestViewNavigationsRequirmentsEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/JoinedByEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/TestResulteEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/courseTestView.dart';

class Coursetestentity {
  int durationTime;
  String title;
  final List<Coursetestquestionentity> questions;
  String? type;
  String id;
  String preffixImage = Assets.assetsImagesExamIcon;

  Coursetestentity(
      {required this.durationTime,
      required this.title,
      required this.questions,
      required this.id,
      this.type = "Test"});
  static Coursetestentity empty() => Coursetestentity(
        durationTime: 0,
        title: '',
        questions: [],
        id: '',
      );
  Coursetestentity copyWith({
    int? durationTime,
    String? title,
    List<JoinedByEntity>? joinedBy,
    List<Coursetestquestionentity>? questions,
    List<Testresulteentity>? results,
  }) {
    return Coursetestentity(
      id: id,
      durationTime: durationTime ?? this.durationTime,
      title: title ?? this.title,
      questions: questions ?? this.questions,
    );
  }

  ontap(
      {required BuildContext context,
      required Coursetestviewnavigationsrequirmentsentity item,
      required CourseEntity course}) {
    GoRouter.of(context).push(Coursetestview.routename, extra: item);
  }

  void addQuestion(Coursetestquestionentity? question) {
    question ??= Coursetestquestionentity(
      isOpened: false,
      questionTitle: "",
      solutions: [
        Coursetestquestionsolutionentity(answer: "0", isCorrect: false)
      ],
    );
    questions.add(question);
  }

  void removeQuestion(Coursetestquestionentity question) {
    question.questionController.dispose();
    questions.remove(question);
  }
}
