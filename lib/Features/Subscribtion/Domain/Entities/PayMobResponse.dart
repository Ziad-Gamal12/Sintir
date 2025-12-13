class PayMobResponse {
  String url, paymentid;
  double amount;
  String issuer, mobileNumber, currency;
  PayMobResponse(
      {required this.url,
      required this.paymentid,
      required this.currency,
      required this.amount,
      required this.issuer,
      required this.mobileNumber});
}
