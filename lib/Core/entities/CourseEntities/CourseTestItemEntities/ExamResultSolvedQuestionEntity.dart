class ExamResultSolvedQuestionEntity {
  final String selectedAnswer, rightAnswer, questionTitle, imageUrl;
  final bool isCorrect;

  ExamResultSolvedQuestionEntity(
      {required this.selectedAnswer,
      required this.questionTitle,
      required this.rightAnswer,
      required this.imageUrl,
      required this.isCorrect});
}
