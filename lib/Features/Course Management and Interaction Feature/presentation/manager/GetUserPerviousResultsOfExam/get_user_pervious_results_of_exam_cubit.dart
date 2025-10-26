import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/repos/Test-Item-Repo/TestItemRepo.dart';

part 'get_user_pervious_results_of_exam_state.dart';

class GetUserPerviousResultsOfExamCubit
    extends Cubit<GetUserPerviousResultsOfExamState> {
  GetUserPerviousResultsOfExamCubit({required this.testitemrepo})
      : super(GetUserPerviousResultsOfExamInitial());
  final Testitemrepo testitemrepo;

  Future<void> getUserPerviousResultsOfExam(
      {required String courseId,
      required String sectionId,
      required String examId,
      required String userId}) async {
    emit(GetUserPerviousResultsOfExamLoading());
    final result = await testitemrepo.getUserResultsOfExam(
        courseId: courseId,
        sectionId: sectionId,
        examId: examId,
        userId: userId);
    result.fold(
        (failure) => emit(
            GetUserPerviousResultsOfExamFailure(errMessage: failure.message)),
        (results) => emit(
            GetUserPerviousResultsOfExamSuccess(resultsOfExamsList: results)));
  }
}
