import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursSectionsListItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/repos/AddCourseSectionRepo.dart';

part 'AddCourseSectionState.dart';

class AddCourseSectionCubit extends Cubit<AddCourseSectionState> {
  AddCourseSectionCubit(this.addcoursesectionrepo)
      : super(AddCourseSectionInitial());
  final Addcoursesectionrepo addcoursesectionrepo;
  CoursSectionsListItemEntity coursSectionsListItemEntity =
      CoursSectionsListItemEntity(
    title: Variables.AddCoursesectionNameController.text,
    subtitle: Variables.AddCoursesesectionDescriptionController.text,
    items: [],
  );
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
    emit(AddCourseSectionTestQuestionAdded());
  }

  void removeQuestion({required Coursetestquestionentity question}) {
    coursetestentity.removeQuestion(question);
    emit(AddCourseSectionTestQuestionRemoved());
  }

  void removeSolutin(
      {required Coursetestquestionsolutionentity solution,
      required Coursetestquestionentity question}) {
    if (question.solutions.length > 1) {
      question.removeSolution(solution);
    } else {
      removeQuestion(question: question);
    }
    emit(AddCourseSectionTestSolutionRemoved());
  }

  void addSolution({required Coursetestquestionentity question}) {
    question.addSolution(null);
    emit(AddCourseSectionTestSolutionAdded());
  }

  void changeSelectedSolution(
      {required Coursetestquestionentity question, required int index}) {
    previousSolutionIndex = currentSolutionIndex;
    currentSolutionIndex = index;
    if (previousSolutionIndex != -1) {
      question.solutions[previousSolutionIndex].isCorrect = false;
      question.solutions[currentSolutionIndex].isCorrect = true;
    }
    question.solutions[currentSolutionIndex].isCorrect = true;

    emit(AddCourseSectionTestSolutionChanged());
  }

  void addNewCourseSection({
    required CourseEntity courseEntity,
  }) async {
    Either<Failure, void> result = await addcoursesectionrepo.addCourseSection(
      courseEntity: courseEntity,
    );
    result.fold((failure) {
      emit(AddCourseSectionAddSectionFailure(errMessage: failure.message));
    }, (success) {
      emit(AddCourseSectionAddSectionSuccess());
    });
  }

  void addSQlTest(
      {required Coursetestentity test,
      required CoursSectionsListItemEntity section,
      required CourseEntity courseEntity}) async {
    emit(AddCourseSectionAddSectionLoading());
    var resulte = await addcoursesectionrepo.uploadTestQuestionsImages(
        questions: test.questions);
    resulte.fold((failure) {
      emit(AddCourseSectionAddSectionFailure(errMessage: failure.message));
    }, (success) {
      section.items.add(test);
      if (courseEntity.coursSectionsListItemEntity != null) {
        courseEntity.coursSectionsListItemEntity!.add(section);
        addNewCourseSection(courseEntity: courseEntity);
      } else {
        emit(AddCourseSectionAddSectionFailure(errMessage: "حدث خطأ ما"));
      }
    });
  }
}
