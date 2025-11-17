import 'package:flutter/material.dart';

class Coursetestquestionsolutionentity {
  String answer;
  bool isCorrect;
  TextEditingController solutionController;

  Coursetestquestionsolutionentity(
      {required this.answer, required this.isCorrect})
      : solutionController = TextEditingController(text: answer);

  void dispose() {
    solutionController.dispose();
  }
}
