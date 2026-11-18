part of 'delete_account_cubit.dart';

abstract class DeleteAccountState {
  const DeleteAccountState();
}

class DeleteAccountInitial extends DeleteAccountState {
  const DeleteAccountInitial();
}

class DeleteAccountLoading extends DeleteAccountState {
  const DeleteAccountLoading();
}

class DeleteAccountSuccess extends DeleteAccountState {
  const DeleteAccountSuccess(this.result);

  final AccountDeletionResult result;
}

class DeleteAccountFailure extends DeleteAccountState {
  const DeleteAccountFailure(this.message);

  final String message;
}
