// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionSolutionEntity.dart';

class CourseTestQuestionEntity {
  String? questionTitle;
  List<Coursetestquestionsolutionentity> solutions;
  TextEditingController questionController;
  bool isOpened;
  String? imageUrl;
  String? selectedSolution;
  File? imageFile;

  CourseTestQuestionEntity(
      {required this.questionTitle,
      required this.solutions,
      required this.isOpened,
      this.imageUrl,
      this.imageFile,
      this.selectedSolution = ""})
      : questionController = TextEditingController(text: questionTitle);

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
    solution.solutionController.dispose();
    solutions.remove(solution);
  }
}
