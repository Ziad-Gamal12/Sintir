// ignore_for_file: file_names

import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionSolutionEntity.dart';

class Coursetestquestionentity {
  final String questionTitle;
  final List<Coursetestquestionsolutionentity> solutions;
  final bool isOpened;
  String? imageUrl;

  Coursetestquestionentity({
    required this.questionTitle,
    required this.solutions,
    required this.isOpened,
  });
}
