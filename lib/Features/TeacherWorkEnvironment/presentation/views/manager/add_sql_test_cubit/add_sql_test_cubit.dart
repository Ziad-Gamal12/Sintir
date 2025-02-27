import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionSolutionEntity.dart';

part 'add_sql_test_state.dart';

class AddSQlTestCubit extends Cubit<AddSQlTestState> {
  AddSQlTestCubit() : super(AddSQlTestInitial());
  Coursetestentity coursetestentity = Coursetestentity(
    questions: [
      Coursetestquestionentity(isOpened: false, questionTitle: "", solutions: [
        Coursetestquestionsolutionentity(answer: "0", isCorrect: false)
      ])
    ],
    title: Variables.AddsqlTestName.text,
    durationTime: int.tryParse(Variables.AddsqlTestDuration.text) ?? 0,
  );
  int currentSolutionIndex = -1;
  int previousSolutionIndex = -1;

  void addNewQuestion() {
    coursetestentity.addQuestion(null);
    emit(AddSQlTestQuestionAdded());
  }

  void removeQuestion({required Coursetestquestionentity question}) {
    coursetestentity.removeQuestion(question);
    emit(AddSQlTestQuestionAdded());
  }

  void removeSolutin(
      {required Coursetestquestionsolutionentity solution,
      required Coursetestquestionentity question}) {
    question.removeSolution(solution);
    emit(AddSQlTestSolutionRemoved());
  }

  void addSolution({required Coursetestquestionentity question}) {
    question.addSolution(null);
    emit(AddSQlTestSolutionAdded());
  }

  changeSelectedSolution(
      {required Coursetestquestionentity question, required int index}) {
    previousSolutionIndex = currentSolutionIndex;
    currentSolutionIndex = index;
    if (previousSolutionIndex != -1) {
      question.solutions[previousSolutionIndex].isCorrect = false;
      question.solutions[currentSolutionIndex].isCorrect = true;
    }
    question.solutions[currentSolutionIndex].isCorrect = true;

    emit(AddSQlTestSolutionChanged());
  }
}
