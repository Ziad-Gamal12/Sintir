import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestViewNavigationsRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/JoinedByEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/CourseTestOverviewView.dart';

class CourseTestEntity {
  int durationTime;
  String title;
  final List<CourseTestQuestionEntity> questions;
  String? type;
  String id;
  bool? isOpened;
  String preffixImage = Assets.assetsIconsSVGIconsExamIcon;

  CourseTestEntity(
      {required this.durationTime,
      required this.title,
      required this.questions,
      required this.id,
      this.type = "Test"});
  static CourseTestEntity empty() => CourseTestEntity(
        durationTime: 0,
        title: '',
        questions: [],
        id: '',
      );
  CourseTestEntity copyWith({
    int? durationTime,
    String? title,
    List<JoinedByEntity>? joinedBy,
    List<CourseTestQuestionEntity>? questions,
    List<TestResultEntity>? results,
  }) {
    return CourseTestEntity(
      id: id,
      durationTime: durationTime ?? this.durationTime,
      title: title ?? this.title,
      questions: questions ?? this.questions,
    );
  }

  void ontap(
      {required BuildContext context,
      required CourseExamViewNavigationsRequirmentsEntity item,
      required CourseEntity course}) {
    GoRouter.of(context).push(CourseTestOverViewView.routeName, extra: item);
  }

  void addQuestion(CourseTestQuestionEntity? question) {
    question ??= CourseTestQuestionEntity(
      isOpened: false,
      questionTitle: "",
      solutions: [
        Coursetestquestionsolutionentity(answer: "0", isCorrect: false)
      ],
    );
    questions.add(question);
  }

  void removeQuestion(CourseTestQuestionEntity question) {
    question.questionController.dispose();
    questions.remove(question);
  }

  void dispose() {
    for (CourseTestQuestionEntity question in questions) {
      question.dispose();
      question.disposeSolutions();
    }
  }
}
