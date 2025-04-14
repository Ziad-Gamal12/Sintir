import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/user_cubit/user_cubit.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/JoinedByEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/TestResulteEntity.dart';
import 'package:sintir/Features/StudenetAuth/domain/entities/studentEntity.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Entities/teacherEntity.dart';

part 'update_course_sections_state.dart';

class UpdateCourseSectionsCubit extends Cubit<UpdateCourseSectionsState> {
  UpdateCourseSectionsCubit({
    required this.coursesrepo,
  }) : super(UpdateCourseSectionsInitial());

  final Coursesrepo coursesrepo;
  updateCourseSections({
    required CourseEntity course,
  }) async {
    emit(UpdateCourseSectionsLoading());
    Either<Failure, void> result =
        await coursesrepo.updateCourseSections(course: course);
    result.fold((failure) {
      emit(UpdateCourseSectionsFailure(errMessage: failure.message));
    }, (success) {
      emit(UpdateCourseSectionsSuccess());
    });
  }

  JoinedByEntity getJoinedByEntity(BuildContext context) {
    Studententity? student = context.read<UserCubit>().studententity;
    teacherEntity? teacher = context.read<UserCubit>().teacherentity;
    if (teacher != null) {
      return JoinedByEntity(
          uid: teacher.uid!,
          name: "${teacher.firstName} ${teacher.lastName}",
          imageUrl: teacher.profilePicurl!,
          joinedDate: DateTime.now());
    } else if (student != null) {
      return JoinedByEntity(
          uid: student.uid!,
          name: "${student.firstName} ${student.lastName}",
          imageUrl: student.imageUrl,
          joinedDate: DateTime.now());
    } else {
      return JoinedByEntity(
          uid: "",
          name: "غير معروف",
          imageUrl: "https://cdn-icons-png.flaticon.com/128/847/847969.png",
          joinedDate: DateTime.now());
    }
  }

  int getSolvedQuestionslength({required Coursetestentity coursetestentity}) {
    int solvedcount = 0;
    for (var question in coursetestentity.questions) {
      if (question.selectedSolution != "") {
        solvedcount++;
      }
    }
    return solvedcount;
  }

  List<ExamResultSolvedQuestionEntity> getSolvedQuestions(
      {required Coursetestentity coursetestentity}) {
    List<ExamResultSolvedQuestionEntity> questionsSolvedList = [];
    for (var question in coursetestentity.questions) {
      if (question.selectedSolution != "") {
        ExamResultSolvedQuestionEntity solvedQuestionEntity =
            ExamResultSolvedQuestionEntity(
          isCorrect: question.selectedSolution ==
              question.solutions.where((e) => e.isCorrect).first.answer,
          rightAnswer:
              question.solutions.where((e) => e.isCorrect).first.answer,
          selectedAnswer: question.selectedSolution ?? "",
        );

        questionsSolvedList.add(solvedQuestionEntity);
      }
    }
    return questionsSolvedList;
  }

  Testresulteentity getTestResultEntity(
      {required Coursetestentity coursetestentity,
      required bool isDelivered,
      required BuildContext context}) {
    return Testresulteentity(
        serialNumber:
            "${DateTime.now().toIso8601String()}-${coursetestentity.title}",
        joinedDate: DateTime.now(),
        coursetestentity: coursetestentity,
        totalQuestions: coursetestentity.questions.length,
        solvedQuestions:
            getSolvedQuestionslength(coursetestentity: coursetestentity),
        isdelivered: isDelivered,
        joinedbyentity: getJoinedByEntity(context),
        result: 0,
        questionsSolvedListEntity:
            getSolvedQuestions(coursetestentity: coursetestentity));
  }
}
