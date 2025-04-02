import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/entities/PaymentEntities/BillingDataEntity.dart';
import 'package:sintir/Core/entities/PaymentEntities/OrderDataEntity.dart';
import 'package:sintir/Core/entities/PaymentEntities/PaymentDataEntity.dart';
import 'package:sintir/Core/repos/PaymentRepo/paymentRepo.dart';
import 'package:sintir/Features/StudenetAuth/domain/entities/studentEntity.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Entities/teacherEntity.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(
      {required this.paymentrepo,
      required this.course,
      required this.student,
      required this.teacher})
      : super(PaymentInitial());
  final Paymentrepo paymentrepo;
  final CourseEntity course;
  teacherEntity? teacher;
  Studententity? student;
  Orderdataentity getOrderEntity() {
    Orderdataentity orderEntity = Orderdataentity(
      currency: "EGP",
      deliveryNeeded: false,
      priceCents: course.price * 100,
      items: [course],
      merchantOrderId: getmerchantOrderId(),
    );
    return orderEntity;
  }

  Paymentdataentity getPaymentEntity() {
    Paymentdataentity paymententity = Paymentdataentity(
      currency: "EGP",
      priceCents: course.price * 100,
      expiration: 3600,
      integrationId: 5034306,
      billingdataentity: getBillingEntity(),
    );
    return paymententity;
  }

  Billingdataentity getBillingEntity() {
    if (student != null) {
      Billingdataentity billingdataentity = Billingdataentity(
          apartment: "-",
          building: "-",
          city: "-",
          country: "-",
          email: student!.email,
          floor: "-",
          firstName: student!.firstName,
          lastName: student!.lastName,
          phoneNumber: student!.phoneNumber,
          street: "-");
      return billingdataentity;
    } else {
      Billingdataentity billingdataentity = Billingdataentity(
        apartment: "-",
        building: "-",
        city: "-",
        country: "-",
        email: teacher!.email,
        floor: "-",
        firstName: teacher!.firstName,
        lastName: teacher!.lastName,
        phoneNumber: teacher!.phoneNumber,
        street: "-",
      );
      return billingdataentity;
    }
  }

  String getmerchantOrderId() {
    if (teacher != null) {
      return "${teacher!.uid}-${DateTime.now().millisecondsSinceEpoch}";
    } else {
      return "${student!.uid}-${DateTime.now().millisecondsSinceEpoch}";
    }
  }

  void paywithFawry() async {
    emit(PaymentLoading());
    var result = await paymentrepo.payWithFawry(
        orderEntity: getOrderEntity(), paymententity: getPaymentEntity());
    result.fold((failure) {
      emit(PaymentError(message: failure.message));
    }, (token) {
      emit(PaymentSuccess(token: token));
    });
  }
}
