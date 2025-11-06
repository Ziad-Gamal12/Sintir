import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/PaymobRepo.dart/PaymobRepo.dart';
import 'package:sintir/Core/services/Paymob/PayMobService.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Subscribtion/Data/Models/PaymentModels/BillingDataModel.dart';
import 'package:sintir/Features/Subscribtion/Data/Models/PaymentModels/OrderItemModel.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/PayMobResponse.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/PaymentEntities/BillingDataEntity.dart';
import 'package:sintir/constant.dart';

class PaymobRepoImp implements PaymobRepo {
  final PayMobService payMobService;
  PaymobRepoImp({required this.payMobService});

  @override
  Future<Either<Failure, PayMobResponse>> payWithWallet({
    required UserEntity user,
    required CourseEntity course,
    required double amount,
  }) async {
    try {
      /// 1. Build Billing Data
      final billingData =
          Billingdatamodel.fromEntity(entity: getBillingEntity(user: user))
              .toJson();
      final items =
          Orderitemmodel.fromCourseEntity(course, amount.toInt()).toJson();

      /// 2. Create Intention
      final response = await payMobService.createPaymentIntention(
        amountCents: (amount.toInt() * 100).toInt(),
        currency: "EGP",
        items: [items],
        integrationId: PaymobWalletsIntegrationID,
        billingData: billingData,
      );

      final clientSecret = response["client_secret"];
      if (clientSecret == null) {
        return left(ServerFailure(message: "لم يتم إنشاء client_secret"));
      }

      final checkoutUrl =
          payMobService.buildCheckoutUrl(clientSecret: clientSecret);
      return right(PayMobResponse(
        url: checkoutUrl,
        paymentid: clientSecret,
        amount: amount,
      ));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما أثناء عملية الدفع"));
    }
  }

  /// Converts UserEntity to BillingDataEntity
  Billingdataentity getBillingEntity({required UserEntity user}) {
    return Billingdataentity(
      apartment: "NA",
      building: "NA",
      city: user.address,
      country: "EG",
      email: user.email,
      floor: "NA",
      firstName: user.firstName,
      lastName: user.lastName,
      phoneNumber: user.phoneNumber,
      street: "NA",
    );
  }
}
