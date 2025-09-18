// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/GetCourseSubscribersEntity.dart';
import 'package:sintir/Core/entities/PaymentEntities/BillingDataEntity.dart';
import 'package:sintir/Core/entities/PaymentEntities/OrderDataEntity.dart';
import 'package:sintir/Core/entities/PaymentEntities/PaymentDataEntity.dart';
import 'package:sintir/Core/repos/CourseSubscibtionsRepo/CourseSubscibtionsRepo.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';

part 'CourseSubscribtionsState.dart';

class CourseSubscribtionsCubit extends Cubit<CourseSubscribtionsState> {
  CourseSubscribtionsCubit({
    required this.subscribtionRepo,
    required this.course,
  }) : super(SubscribeToCoursesInitial());
  final CourseSubscibtionsRepo subscribtionRepo;
  final CourseEntity course;

  Orderdataentity getOrderEntity({required String uid}) {
    Orderdataentity orderEntity = Orderdataentity(
      currency: "EGP",
      deliveryNeeded: false,
      priceCents: course.price * 100,
      items: [course],
      merchantOrderId: getmerchantOrderId(
        uid: uid,
      ),
    );
    return orderEntity;
  }

  Paymentdataentity getPaymentEntity({required UserEntity user}) {
    Paymentdataentity paymententity = Paymentdataentity(
      currency: "EGP",
      priceCents: course.price * 100,
      expiration: 3600,
      integrationId: 5034306,
      billingdataentity: getBillingEntity(
        user: user,
      ),
    );
    return paymententity;
  }

  Billingdataentity getBillingEntity({required UserEntity user}) {
    Billingdataentity billingdataentity = Billingdataentity(
        apartment: "-",
        building: "-",
        city: "-",
        country: "-",
        email: user.email,
        floor: "-",
        firstName: user.firstName,
        lastName: user.lastName,
        phoneNumber: user.phoneNumber,
        street: "-");
    return billingdataentity;
  }

  String getmerchantOrderId({required String uid}) {
    return "$uid-${DateTime.now().millisecondsSinceEpoch}";
  }

  void paywithFawry({required UserEntity user}) async {
    emit(PaymentLoading());
    var result = await subscribtionRepo.payWithFawry(
        orderEntity: getOrderEntity(
          uid: user.uid,
        ),
        paymententity: getPaymentEntity(
          user: user,
        ));
    result.fold((failure) {
      emit(PaymentError(message: failure.message));
    }, (token) {
      emit(PaymentSuccess(token: token));
    });
  }

  void subscribeToCourse({required UserEntity userEntity}) async {
    emit(SubscibeingToCourseLoading());
    var result = await subscribtionRepo.subscribeToCourse(
        course: course, userEntity: userEntity);
    result.fold((failure) {
      emit(SubscibeingToCourseFailure(errMessge: failure.message));
    }, (message) {
      emit(SubscibeingToCourseSuccess());
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
