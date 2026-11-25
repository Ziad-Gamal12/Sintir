import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CourseTestQuestionSolutionEntity {
  String answer;
  bool isCorrect;
  TextEditingController solutionController;

  /// Identifies the answer within its question's radio group. A UUID, because
  /// answers created in the same millisecond (e.g. when an exam is loaded)
  /// would otherwise share a timestamp id and be selected together.
  final String id = const Uuid().v4();

  CourseTestQuestionSolutionEntity(
      {required this.answer, required this.isCorrect})
      : solutionController = TextEditingController(text: answer);

  void dispose() {
    solutionController.dispose();
  }
}
