class ExamResultSolvedQuestionEntity {
  final String selectedAnswer, rightAnswer, questionTitle, imageUrl;
  final bool isCorrect;

  ExamResultSolvedQuestionEntity(
      {required this.selectedAnswer,
      required this.questionTitle,
      required this.rightAnswer,
      required this.imageUrl,
      required this.isCorrect});

  static List<ExamResultSolvedQuestionEntity> empty() => List.generate(
      6,
      (index) => ExamResultSolvedQuestionEntity(
          selectedAnswer: 'loading',
          questionTitle: 'loading',
          rightAnswer: 'loading',
          imageUrl:
              "https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png",
          isCorrect: false));
}
