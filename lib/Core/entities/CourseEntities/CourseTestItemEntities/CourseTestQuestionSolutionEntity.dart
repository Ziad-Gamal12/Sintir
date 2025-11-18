import 'package:flutter/material.dart';

class Coursetestquestionsolutionentity {
  String answer;
  bool isCorrect;
  TextEditingController solutionController;
  String id = DateTime.now().millisecondsSinceEpoch.toString();

  Coursetestquestionsolutionentity(
      {required this.answer, required this.isCorrect})
      : solutionController = TextEditingController(text: answer);

  void dispose() {
    solutionController.dispose();
  }
}
