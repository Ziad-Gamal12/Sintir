import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:sintir/Core/repos/CourseCheckoutRepo.dart';
import 'package:sintir/Core/repos/CourseCheckoutRequestException.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/CourseCheckoutEntity.dart';
import 'package:sintir/locale_keys.dart';

sealed class CourseCheckoutState {}

class CourseCheckoutInitial extends CourseCheckoutState {}

class CourseCheckoutLoading extends CourseCheckoutState {}

class CourseCheckoutQuoteReady extends CourseCheckoutState {
  CourseCheckoutQuoteReady(this.quote);
  final CourseCheckoutQuote quote;
}

class CourseCheckoutCreated extends CourseCheckoutState {
  CourseCheckoutCreated(this.attempt);
  final CoursePaymentAttempt attempt;
}

class CourseCheckoutStatus extends CourseCheckoutState {
  CourseCheckoutStatus(this.status);
  final String status;
}

class CourseCheckoutFailure extends CourseCheckoutState {
  CourseCheckoutFailure(this.message);
  final String message;
}

class CourseCheckoutRecoveryRequired extends CourseCheckoutState {
  CourseCheckoutRecoveryRequired(this.message);
  final String message;
}

class CourseCheckoutReviewRequired extends CourseCheckoutState {
  CourseCheckoutReviewRequired(this.message);
  final String message;
}

class CourseCheckoutCubit extends Cubit<CourseCheckoutState> {
  CourseCheckoutCubit(this._repo) : super(CourseCheckoutInitial());
  final CourseCheckoutGateway _repo;
  bool _creating = false;
  String? _idempotencyKey;

  Future<CourseCheckoutQuote?> quote(String courseId,
      {String? couponCode}) async {
    emit(CourseCheckoutLoading());
    try {
      final result =
          await _repo.quote(courseId: courseId, couponCode: couponCode);
      emit(CourseCheckoutQuoteReady(result));
      return result;
    } catch (e) {
      emit(CourseCheckoutFailure(_safeMessage(e)));
      return null;
    }
  }

  Future<void> createPayment(String courseId, {String? couponCode}) async {
    if (_creating) return;
    _creating = true;
    _idempotencyKey ??= const Uuid().v4();
    emit(CourseCheckoutLoading());
    try {
      emit(CourseCheckoutCreated(
        await _repo.createPayment(
            courseId: courseId,
            couponCode: couponCode,
            idempotencyKey: _idempotencyKey!),
      ));
      _idempotencyKey = null;
    } catch (e) {
      if (e is CourseCheckoutRequestException &&
          const {
            'paymob_intention_failed',
            'checkout_creation_failed',
            'billing_phone_missing'
          }.contains(e.code)) {
        // Known server responses either created no attempt or definitively
        // resolved this idempotency key. Network/ambiguous outcomes keep it.
        _idempotencyKey = null;
      }
      _emitCheckoutError(e);
    } finally {
      _creating = false;
    }
  }

  Future<String> refreshStatus(String attemptId) async {
    try {
      final status = await _repo.paymentStatus(attemptId);
      emit(CourseCheckoutStatus(status));
      return status;
    } catch (e) {
      _emitCheckoutError(e);
      return 'unavailable';
    }
  }

  Future<bool> isSubscribed(String courseId) => _repo.isSubscribed(courseId);

  String _safeMessage(Object error) {
    if (error is CourseCheckoutRequestException) {
      switch (error.code) {
        case 'checkout_status_unknown':
        case 'checkout_processing':
        case 'paymob_intention_unknown':
        case 'checkout_in_progress':
        case 'checkout_retry_required':
          return LocaleKeys.paymentVerifying;
        case 'paid_requires_review':
        case 'stale_checkout_lock':
          return LocaleKeys.paymentRequiresReview;
      }
    }
    final text = error.toString().replaceFirst('Exception: ', '');
    return text.length > 180 ? 'Checkout could not be completed.' : text;
  }

  void _emitCheckoutError(Object error) {
    final code = error is CourseCheckoutRequestException ? error.code : '';
    final message = _safeMessage(error);
    if (const {
      'checkout_status_unknown',
      'checkout_processing',
      'paymob_intention_unknown',
      'checkout_in_progress',
      'checkout_retry_required',
    }.contains(code)) {
      emit(CourseCheckoutRecoveryRequired(message));
    } else if (const {'paid_requires_review', 'stale_checkout_lock'}
        .contains(code)) {
      emit(CourseCheckoutReviewRequired(message));
    } else {
      emit(CourseCheckoutFailure(message));
    }
  }
}
