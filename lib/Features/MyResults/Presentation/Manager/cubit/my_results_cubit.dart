import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Features/MyResults/Domain/Entities/GetMyResultsResponseEntity.dart';
import 'package:sintir/Features/MyResults/Domain/Repo/MyResultsRepo.dart';

part 'my_results_state.dart';

class MyResultsCubit extends Cubit<MyResultsState> {
  MyResultsCubit({required this.myResultsRepo}) : super(MyResultsInitial());
  final MyResultsRepo myResultsRepo;

  Future<void> getMyResults(
      {required String userId, required bool isPaginate}) async {
    emit(GetMyResultsLoading(
      isPaginate: true,
    ));
    final result = await myResultsRepo.getMyResults(
        userId: userId, isPaginate: isPaginate);
    result.fold(
        (failure) => emit(GetMyResultsFailure(errMessage: failure.message)),
        (response) =>
            emit(GetMyResultsSuccess(getMyResultsResponseEntity: response)));
  }
}
