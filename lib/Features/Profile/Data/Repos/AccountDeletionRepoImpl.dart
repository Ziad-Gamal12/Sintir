// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/services/EdgeFunctionsService.dart';
import 'package:sintir/Core/services/FireBase/FirebaseAuth_Service.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Profile/Domain/Repos/AccountDeletionRepo.dart';
import 'package:sintir/locale_keys.dart';

typedef Reauthenticate = Future<void> Function({String? password});

class AccountDeletionRepoImpl implements AccountDeletionRepo {
  AccountDeletionRepoImpl({
    required this.edgeFunctions,
    required this.reauthenticate,
    required this.signInProvider,
    required this.clearLocalSession,
  });

  final EdgeFunctionsService edgeFunctions;
  final Reauthenticate reauthenticate;
  final String? Function() signInProvider;
  final Future<void> Function() clearLocalSession;

  @override
  AccountSignInMethod signInMethod() => methodFor(signInProvider());

  static AccountSignInMethod methodFor(String? providerId) {
    switch (providerId) {
      case firebaseAuthService.passwordProvider:
        return AccountSignInMethod.password;
      case firebaseAuthService.googleProvider:
        return AccountSignInMethod.google;
      case firebaseAuthService.facebookProvider:
        return AccountSignInMethod.facebook;
      default:
        return AccountSignInMethod.other;
    }
  }

  @override
  Future<Either<Failure, AccountDeletionResult>> deleteAccount({
    String? password,
    required bool acknowledgeBalance,
  }) async {
    try {
      await reauthenticate(password: password);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
    try {
      final data = await edgeFunctions.invoke(
        BackendEndpoints.deleteAccountFunction,
        {'acknowledgeBalance': acknowledgeBalance},
      );
      await clearLocalSession();
      return right(AccountDeletionResult.fromJson(data));
    } on EdgeFunctionException catch (e) {
      return left(ServerFailure(message: failureMessage(e.code)));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  static String failureMessage(String code) {
    switch (code) {
      case 'requires_recent_login':
      case 'unauthorized':
      case 'authentication_required':
        return LocaleKeys.accountDeleteSignInAgain;
      case 'staff_account':
        return LocaleKeys.accountDeleteStaffBlocked;
      case 'payout_pending':
        return LocaleKeys.accountDeletePayoutPending;
      case 'balance_remaining':
        return LocaleKeys.accountDeleteBalanceRemaining;
      case 'payment_in_progress':
        return LocaleKeys.accountDeletePaymentInProgress;
      case 'deletion_incomplete':
        return LocaleKeys.accountDeleteIncomplete;
      case 'network_error':
      case 'network_timeout':
        return LocaleKeys.noInternet;
      default:
        return LocaleKeys.errorOccurredMessage;
    }
  }
}
