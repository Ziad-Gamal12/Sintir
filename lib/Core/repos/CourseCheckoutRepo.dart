import 'package:sintir/Features/Subscribtion/Domain/Entities/CourseCheckoutEntity.dart';

abstract interface class CourseCheckoutGateway {
  Future<CourseCheckoutQuote> quote(
      {required String courseId, String? couponCode});
  Future<CoursePaymentAttempt> createPayment(
      {required String courseId,
      required String idempotencyKey,
      String? couponCode});
  Future<CoursePaymentStatusResult> paymentStatus(String paymentAttemptId);
  Future<bool> isSubscribed(String courseId);
}
