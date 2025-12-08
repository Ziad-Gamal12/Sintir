import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/repos/Test-Item-Repo/TestItemRepo.dart';

part 'check_if_result_hidden_state.dart';

class CheckIfResultHiddenCubit extends Cubit<CheckIfResultHiddenState> {
  CheckIfResultHiddenCubit({required this.testitemrepo})
      : super(CheckIfResultHiddenInitial());
  final Testitemrepo testitemrepo;

  Future<void> checkIfResultHidden(
      {required String testId,
      required String sectionId,
      required String courseId}) async {
    emit(CheckIfResultHiddenLoadingState());
    final res = await testitemrepo.checkIfTheResultHidden(
        courseId: courseId, sectionId: sectionId, testId: testId);
    res.fold((l) => emit(CheckIfResultHiddenFailureState(message: l.message)),
        (r) => emit(CheckIfResultHiddenSuccessState(isHidden: r)));
  }
}
