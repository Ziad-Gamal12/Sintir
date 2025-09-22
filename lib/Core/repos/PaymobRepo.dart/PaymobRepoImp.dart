import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/PayMobResponse.dart';
import 'package:sintir/Core/entities/PaymentEntities/BillingDataEntity.dart';
import 'package:sintir/Core/entities/PaymentEntities/OrderDataEntity.dart';
import 'package:sintir/Core/entities/PaymentEntities/PaymentDataEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/PaymobRepo.dart/PaymobRepo.dart';
import 'package:sintir/Core/services/PayMobService.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/constant.dart';

class PaymobRepoImp implements PaymobRepo {
  final PayMobService payMobService;
  PaymobRepoImp({required this.payMobService});
  @override
  Future<Either<Failure, PayMobResponse>> payWithWallet(
      {required UserEntity user, required CourseEntity course}) async {
    try {
      String? token = await payMobService.getAuthToken();
      if (token == null) {
        return left(ServerFailure(message: "حدث خطا أثناء تحميل التوكن"));
      }
      int? paymentOrderId = await payMobService.createPaymentOrder(
        orderEntity:
            getOrderEntity(authToken: token, uid: user.uid, course: course),
      );
      if (paymentOrderId == null) {
        return left(ServerFailure(message: "حدث خطاأثناء انشاء الطلب"));
      }
      String paymentToken = await payMobService.getPaymentToken(
          paymententity: getPaymentEntity(
              orderId: paymentOrderId.toString(),
              authToken: token,
              user: user,
              course: course));
      String paymentUrl = await payMobService.payWithWallet(body: {
        "source": {"identifier": "01010101010", "subtype": "WALLET"},
        "payment_token": paymentToken
      });
      return right(PayMobResponse(url: paymentUrl, paymentid: paymentToken));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  Orderdataentity getOrderEntity(
      {required String authToken,
      required String uid,
      required CourseEntity course}) {
    Orderdataentity orderEntity = Orderdataentity(
      authToken: authToken,
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

  Paymentdataentity getPaymentEntity(
      {required String authToken,
      required UserEntity user,
      required String orderId,
      required CourseEntity course}) {
    Paymentdataentity paymententity = Paymentdataentity(
      authToken: authToken,
      currency: "EGP",
      priceCents: course.price * 100,
      expiration: 3600,
      integrationId: PaymobWalletsIntegrationID,
      orderId: orderId,
      billingdataentity: getBillingEntity(
        user: user,
      ),
    );
    return paymententity;
  }

  Billingdataentity getBillingEntity({required UserEntity user}) {
    Billingdataentity billingdataentity = Billingdataentity(
        apartment: "NA",
        building: "NA",
        city: "NA",
        country: "NA",
        email: user.email,
        floor: "NA",
        firstName: user.firstName,
        lastName: user.lastName,
        phoneNumber: user.phoneNumber,
        street: "NA");
    return billingdataentity;
  }

  String getmerchantOrderId({required String uid}) {
    return "$uid-${DateTime.now().millisecondsSinceEpoch}";
  }
}
