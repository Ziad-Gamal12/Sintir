part of 'teacher_wallet_cubit.dart';

sealed class TeacherWalletState {
  const TeacherWalletState();

  /// Latest wallet received, kept through live-connection failures.
  TeacherWalletEntity? get wallet => null;
}

/// No wallet received yet.
final class TeacherWalletLoading extends TeacherWalletState {
  const TeacherWalletLoading();

  @override
  bool operator ==(Object other) => other is TeacherWalletLoading;

  @override
  int get hashCode => (TeacherWalletLoading).hashCode;
}

final class TeacherWalletLoaded extends TeacherWalletState {
  const TeacherWalletLoaded(this.wallet);

  @override
  final TeacherWalletEntity wallet;

  @override
  bool operator ==(Object other) =>
      other is TeacherWalletLoaded && other.wallet == wallet;

  @override
  int get hashCode => Object.hash(TeacherWalletLoaded, wallet);
}

/// The live connection failed. [wallet] is the last known value, if any, so
/// the UI can keep showing it while offering a retry.
final class TeacherWalletFailure extends TeacherWalletState {
  const TeacherWalletFailure({required this.message, this.wallet});

  final String message;

  @override
  final TeacherWalletEntity? wallet;

  @override
  bool operator ==(Object other) =>
      other is TeacherWalletFailure &&
      other.message == message &&
      other.wallet == wallet;

  @override
  int get hashCode => Object.hash(TeacherWalletFailure, message, wallet);
}
