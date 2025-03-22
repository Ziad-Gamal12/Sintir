import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursSectionsListItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVedioItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/repos/AddCourseSectionRepo.dart';

part 'AddCourseSectionState.dart';

class AddCourseSectionCubit extends Cubit<AddCourseSectionState> {
  AddCourseSectionCubit(
    this.addcoursesectionrepo,
    this.assetspickerrepo,
  ) : super(AddCourseSectionInitial());
  final Addcoursesectionrepo addcoursesectionrepo;

  final Assetspickerrepo assetspickerrepo;
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
  Coursevedioitementity coursevedioitementity =
      Coursevedioitementity(title: "", vedioUrl: "", durationTime: 0);

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

  void updateCourseSections({
    required CourseEntity courseEntity,
  }) async {
    Either<Failure, void> result =
        await addcoursesectionrepo.updateCourseSections(
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
      bool isUpdate = false,
      required CourseEntity courseEntity}) async {
    emit(AddCourseSectionAddSectionLoading());
    var resulte = await addcoursesectionrepo.uploadTestQuestionsImages(
        questions: test.questions);
    resulte.fold((failure) {
      emit(AddCourseSectionAddSectionFailure(errMessage: failure.message));
    }, (success) {
      section.items.add(test);
      if (courseEntity.coursSectionsListItemEntity != null) {
        if (isUpdate == false) {
          courseEntity.coursSectionsListItemEntity!.add(section);
        }
        updateCourseSections(courseEntity: courseEntity);
      } else {
        emit(AddCourseSectionAddSectionFailure(errMessage: "حدث خطأ ما"));
      }
    });
  }

  void addVideo(
      {required Coursevedioitementity coursevedioitementity,
      required CoursSectionsListItemEntity section,
      bool isUpdate = false,
      required CourseEntity courseEntity}) async {
    emit(AddCourseSectionAddSectionLoading());
    var resulte = await addcoursesectionrepo.uploadVideo(
        coursevedioitementity: coursevedioitementity);
    resulte.fold((failure) {
      emit(AddCourseSectionAddSectionFailure(errMessage: failure.message));
    }, (success) {
      section.items.add(coursevedioitementity);
      if (courseEntity.coursSectionsListItemEntity != null) {
        if (isUpdate == false) {
          courseEntity.coursSectionsListItemEntity!.add(section);
        }
        updateCourseSections(courseEntity: courseEntity);
      } else {
        emit(AddCourseSectionAddSectionFailure(errMessage: "حدث خطأ ما"));
      }
    });
  }

  void pickSectionVedio() async {
    final result = await assetspickerrepo.pickVideoFromGallery();
    result.fold((failure) {
      emit(AddCourseSectionVedioUnPicked());
    }, (vedio) {
      coursevedioitementity.file = vedio;
      emit(AddCourseSectionVedioPicked(vedioFile: vedio));
    });
  }

  void pickSectionFile() async {
    final result = await assetspickerrepo.pickFile();
    result.fold((failure) {
      emit(AddCourseSectionFileUnPicked());
    }, (file) {
      emit(AddCourseSectionFilePicked(file: file));
    });
  }

  void addFile(
      {required Coursefileentity file,
      required CoursSectionsListItemEntity section,
      bool isUpdate = false,
      required CourseEntity courseEntity}) async {
    emit(AddCourseSectionAddSectionLoading());
    var resulte = await addcoursesectionrepo.uploadFile(coursefileEntity: file);
    resulte.fold((failure) {
      emit(AddCourseSectionAddSectionFailure(errMessage: failure.message));
    }, (success) {
      section.items.add(file);
      if (courseEntity.coursSectionsListItemEntity != null) {
        if (isUpdate == false) {
          courseEntity.coursSectionsListItemEntity!.add(section);
        }
        updateCourseSections(courseEntity: courseEntity);
      } else {
        emit(AddCourseSectionAddSectionFailure(errMessage: "حدث خطأ ما"));
      }
    });
  }
}
