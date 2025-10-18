import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/GetExamResultsReponseEntity.dart';
import 'package:sintir/Core/repos/Test-Item-Repo/TestItemRepo.dart';

part 'get_exam_results_state.dart';

class GetExamResultsCubit extends Cubit<GetExamResultsState> {
  GetExamResultsCubit({
    required this.testItemRepo,
  }) : super(GetExamResultsInitial());
  final Testitemrepo testItemRepo;

  Future<void> getTestResults(
      {required String courseId,
      required String sectionId,
      required String examId,
      required bool isPaginate}) async {
    emit(GetExamResultsLoading(
      isPaginate: isPaginate,
    ));
    final result = await testItemRepo.getTestResults(
        courseId: courseId,
        sectionId: sectionId,
        examId: examId,
        isPaginate: isPaginate);
    result.fold(
        (failure) => emit(GetExamResultsFailure(errmessage: failure.message)),
        (response) =>
            emit(GetExamResultsSuccess(getExamResultsReponseEntity: response)));
  }
}
