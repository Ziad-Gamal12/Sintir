import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Features/Profile/Domain/Repos/AccountDeletionRepo.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit({required this.repo})
    : super(const DeleteAccountInitial());

  final AccountDeletionRepo repo;

  AccountSignInMethod get signInMethod => repo.signInMethod();

  Future<void> deleteAccount({
    String? password,
    required bool acknowledgeBalance,
  }) async {
    if (state is DeleteAccountLoading || state is DeleteAccountSuccess) return;
    emit(const DeleteAccountLoading());
    final result = await repo.deleteAccount(
      password: password,
      acknowledgeBalance: acknowledgeBalance,
    );
    result.fold(
      (failure) => emit(DeleteAccountFailure(failure.message)),
      (summary) => emit(DeleteAccountSuccess(summary)),
    );
  }
}
