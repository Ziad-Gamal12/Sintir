import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Features/MyTransactions/Domain/Entities/GetMyTransactionsResponseEntity.dart';
import 'package:sintir/Features/MyTransactions/Domain/Repos/MyTransactionsRep.dart';

part 'my_transactions_state.dart';

class MyTransactionsCubit extends Cubit<MyTransactionsState> {
  MyTransactionsCubit({
    required this.myTransactionsRep,
  }) : super(MyTransactionsInitial());
  final MyTransactionsRepo myTransactionsRep;
  Future<void> getMyTransactions(
      {required String userId, required bool isPaginate}) async {
    emit(GetMyTransactionsLoading(
      isPaginate: isPaginate,
    ));
    final result = await myTransactionsRep.getMyTransactions(
        userId: userId, isPaginate: isPaginate);
    result.fold(
        (failure) =>
            emit(GetMyTransactionsFailure(errmessage: failure.message)),
        (response) => emit(GetMyTransactionsSuccess(
            getMyTransactionsResponseEntity: response)));
  }
}
