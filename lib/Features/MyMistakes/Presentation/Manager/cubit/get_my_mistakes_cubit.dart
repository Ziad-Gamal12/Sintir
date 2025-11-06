import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Features/MyMistakes/Domain/Entities/GetMyMistakesResponseEntity.dart';
import 'package:sintir/Features/MyMistakes/Domain/Repo/MyMistakesRepo.dart';

part 'get_my_mistakes_state.dart';

class GetMyMistakesCubit extends Cubit<GetMyMistakesState> {
  GetMyMistakesCubit({required this.myMistakesRepo})
      : super(GetMyMistakesInitial());
  final MyMistakesRepo myMistakesRepo;

  Future<void> getMyMistakes(
      {required String userUID, required bool isPaginate}) async {
    emit(GetMyMistakesLoading(
      isPaginate: isPaginate,
    ));
    final result = await myMistakesRepo.getMyMistakes(
        userUID: userUID, isPaginate: isPaginate);
    result.fold(
        (failure) => emit(GetMyMistakesFailure(
              errmessage: failure.message,
            )),
        (data) =>
            emit(GetMyMistakesSuccess(getMyMistakesResponseEntity: data)));
  }
}
