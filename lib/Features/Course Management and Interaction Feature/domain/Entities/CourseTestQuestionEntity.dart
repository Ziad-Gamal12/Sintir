// ignore_for_file: file_names

import 'dart:io';

import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionSolutionEntity.dart';

class Coursetestquestionentity {
  String? questionTitle;
  List<Coursetestquestionsolutionentity> solutions;
  bool isOpened;
  String? imageUrl;
  String? selectedSolution;
  File? imageFile;

  Coursetestquestionentity(
      {required this.questionTitle,
      required this.solutions,
      required this.isOpened,
      this.imageUrl,
      this.imageFile,
      this.selectedSolution = ""});

  int index = 0;
  addSolution(Coursetestquestionsolutionentity? solution) {
    if (solution != null) {
      solutions.add(solution);
    }
    index++;
    solutions.add(
        Coursetestquestionsolutionentity(answer: "$index", isCorrect: false));
  }

  removeSolution(Coursetestquestionsolutionentity solution) {
    solutions.remove(solution);
  }
}
