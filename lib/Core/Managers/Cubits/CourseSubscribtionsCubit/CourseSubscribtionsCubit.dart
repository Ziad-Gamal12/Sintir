// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/GetCourseSubscribersEntity.dart';
import 'package:sintir/Core/entities/PayMobResponse.dart';
import 'package:sintir/Core/repos/CourseSubscibtionsRepo/CourseSubscibtionsRepo.dart';
import 'package:sintir/Core/repos/PaymobRepo.dart/PaymobRepo.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';

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
      {required UserEntity userEntity, required String transactionId}) async {
    emit(SubscibeingToCourseLoading());
    var result = await subscribtionRepo.subscribeToCourse(
        transactionId: transactionId, course: course, userEntity: userEntity);
    result.fold((failure) {
      emit(SubscibeingToCourseFailure(errMessge: failure.message));
    }, (message) {
      emit(SubscibeingToCourseSuccess());
    });
  }

  Future<void> payWithWallet({required UserEntity userEntity}) async {
    emit(PayWithWalletLoading());
    var result =
        await paymobRepo.payWithWallet(user: userEntity, course: course);
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
    emit(GetCourseSubscribersLoading());
    var result = await subscribtionRepo.getSubscribers(
        courseID: course.id, isPaginate: isPaginate);
    result.fold((failure) {
      emit(GetCourseSubscribersFailure(errMessage: failure.message));
    }, (response) {
      emit(GetCourseSubscribersSuccess(response: response));
    });
  }
}
