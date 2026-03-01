// ignore_for_file: file_names

import 'dart:io';

import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionSolutionEntity.dart';

class CourseTestQuestionEntity {
  String? questionTitle;
  String questionId;
  List<CourseTestQuestionSolutionEntity> solutions;
  bool isOpened;
  String? imageUrl;
  String? solutionImageUrl;
  String? selectedSolution;
  File? imageFile;
  File? solutionFile;

  CourseTestQuestionEntity(
      {required this.questionTitle,
      required this.solutions,
      required this.isOpened,
      this.imageUrl,
      this.imageFile,
      this.solutionImageUrl,
      required this.questionId,
      this.solutionFile,
      this.selectedSolution = ""});

  void addSolution(CourseTestQuestionSolutionEntity? solution) {
    if (solution != null) {
      solutions.add(solution);
    }

    solutions
        .add(CourseTestQuestionSolutionEntity(answer: "", isCorrect: false));
  }

  void removeSolution(CourseTestQuestionSolutionEntity solution) {
    solutions.remove(solution);
  }

  void disposeSolutions() {
    for (CourseTestQuestionSolutionEntity solution in solutions) {
      solution.solutionController.dispose();
    }
  }
}
