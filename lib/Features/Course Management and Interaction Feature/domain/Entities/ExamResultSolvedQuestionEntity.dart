class ExamResultSolvedQuestionEntity {
  final String selectedAnswer, rightAnswer;
  final bool isCorrect;

  ExamResultSolvedQuestionEntity(
      {required this.selectedAnswer,
      required this.rightAnswer,
      required this.isCorrect});

  bool checkisCorrect() {
    if (selectedAnswer == rightAnswer) {
      return true;
    } else {
      return false;
    }
  }
}
