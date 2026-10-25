import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/services/TeacherWithdrawalService.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherWithdrawalResultEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/WithDrawalTeacherBalanceRepo.dart';

class WithDrawalTeacherBalanceRepoImpl implements WithDrawalTeacherBalanceRepo {
  WithDrawalTeacherBalanceRepoImpl({required TeacherWithdrawalService service})
      : _service = service;
  final TeacherWithdrawalService _service;
  @override
  Future<Either<Failure, TeacherWithdrawalResultEntity>> requestWithdrawal(
          {required double amount,
          required String issuer,
          required String mobileNumber,
          required String idempotencyKey}) =>
      _call(() => _service.request(
          amount: amount,
          issuer: issuer,
          mobileNumber: mobileNumber,
          idempotencyKey: idempotencyKey));
  @override
  Future<Either<Failure, TeacherWithdrawalResultEntity>> reconcileWithdrawal(
          {required String withdrawalId}) =>
      _call(() => _service.reconcile(withdrawalId));
  Future<Either<Failure, TeacherWithdrawalResultEntity>> _call(
      Future<Map<String, dynamic>> Function() call) async {
    try {
      final d = await call();
      return right(TeacherWithdrawalResultEntity(
          withdrawalId: d['withdrawalId'] as String,
          status: d['status'] as String,
          paymobTransactionId: d['paymobTransactionId'] as String?,
          message: d['message'] as String?));
    } on DioException catch (e) {
      return left(ServerFailure(
          message: (e.response?.data is Map
                      ? ((e.response!.data['error'] as Map?)?['message'])
                      : null)
                  ?.toString() ??
              'Withdrawal request failed.'));
    } catch (e) {
      return left(
          ServerFailure(message: e.toString().replaceFirst('Bad state: ', '')));
    }
  }
}
