import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/repos/PaymobPayoutRepo/PayoutRepo.dart';

part 'payout_state.dart';

class PayoutCubit extends Cubit<PayoutState> {
  PayoutCubit({
    required this.payoutRepo,
  }) : super(PayoutInitial());
  final PayoutRepo payoutRepo;

  Future<void> sendDisbursement({
    required String receiverMobile,
    required double amount,
    required String issuer,
    String currency = "EGP",
  }) async {
    emit(PayoutLoading());
    final result = await payoutRepo.sendDisbursement(
      receiverMobile: receiverMobile,
      amount: amount,
      issuer: issuer,
      currency: currency,
    );
    result.fold((l) => emit(PayoutFailure(message: l.message)),
        (r) => emit(PayoutSuccess(transactionId: r)));
  }
}
