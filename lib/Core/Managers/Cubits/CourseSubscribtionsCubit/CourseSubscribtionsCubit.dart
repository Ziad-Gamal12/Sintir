// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetCourseSubscribersEntity.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/repos/CourseSubscibtionsRepo/CourseSubscibtionsRepo.dart';
import 'package:sintir/Core/repos/PaymobRepo.dart/PaymobRepo.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/PayMobResponse.dart';

part 'CourseSubscribtionsState.dart';

class CourseSubscribtionsCubit extends Cubit<CourseSubscribtionsState> {
  CourseSubscribtionsCubit({
    required this.subscribtionRepo,
    required this.course,
    required this.paymobRepo,
  }) : super(SubscribeToCoursesInitial());
  final CourseSubscibtionsRepo subscribtionRepo;
  final PaymobRepo paymobRepo;
  final CourseEntity course;

  void subscribeToCourse(
      {required UserEntity userEntity,
      required TransactionEntity transactionEntity,
      required double amount}) async {
    emit(SubscibeingToCourseLoading());
    var result = await subscribtionRepo.subscribeToCourse(
        amount: amount,
        transactionId: transactionEntity.transactionId ?? "",
        transactionEntity: transactionEntity,
        course: course,
        userEntity: userEntity);
    result.fold((failure) {
      emit(SubscibeingToCourseFailure(errMessge: failure.message));
    }, (message) {
      emit(SubscibeingToCourseSuccess());
    });
  }

  Future<void> payWithWallet({
    required UserEntity userEntity,
    required double amount,
  }) async {
    emit(PayWithWalletLoading());
    var result = await paymobRepo.payWithWallet(
        user: userEntity, course: course, amount: amount);
    result.fold((failure) {
      emit(PayWithWalletFailure(errMessage: failure.message));
    }, (response) {
      emit(PayWithWalletSuccess(response: response));
    });
  }

  void checkIfSubscribed({required String uid}) async {
    emit(CheckIfSubscribedLoading());
    var result = await subscribtionRepo.checkIfSubscribed(
        userID: uid, courseID: course.id);
    result.fold((failure) {
      emit(CheckIfSubscribedFailure(errMessage: failure.message));
    }, (isSubscribed) {
      emit(CheckIfSubscribedSuccess(isSubscribed: isSubscribed));
    });
  }

  Future<void> getCoursSubscribers({required bool isPaginate}) async {
    emit(GetCourseSubscribersLoading(
      isPaginate: isPaginate,
    ));
    var result = await subscribtionRepo.getSubscribers(
        courseID: course.id, isPaginate: isPaginate);
    result.fold((failure) {
      emit(GetCourseSubscribersFailure(errMessage: failure.message));
    }, (response) {
      emit(GetCourseSubscribersSuccess(response: response));
    });
  }

  Future<void> searchSubscribers(
      {required String keyword, required bool isPaginate}) async {
    emit(SearchSubscribersLoading(
      isPaginate: isPaginate,
    ));
    var result = await subscribtionRepo.searchSubscribers(
        searchKey: keyword, isPaginate: isPaginate, courseID: course.id);
    result.fold((failure) {
      emit(SearchSubscribersFailure(errMessage: failure.message));
    }, (response) {
      emit(SearchSubscribersSuccess(response: response));
    });
  }
}
