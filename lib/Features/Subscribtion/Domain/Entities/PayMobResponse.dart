class PayMobResponse {
  const PayMobResponse({required this.url, required this.paymentAttemptId, this.status = 'pending'});

  final String url;
  final String paymentAttemptId;
  final String status;
}
