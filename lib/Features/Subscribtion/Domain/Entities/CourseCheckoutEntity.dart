class CourseCheckoutQuote {
  const CourseCheckoutQuote({
    required this.originalAmountCents,
    required this.discountAmountCents,
    required this.amountCents,
    required this.currency,
    this.couponCode,
    this.discountPercentage = 0,
  });

  final int originalAmountCents;
  final int discountAmountCents;
  final int amountCents;
  final String currency;
  final String? couponCode;
  final double discountPercentage;

  factory CourseCheckoutQuote.fromJson(Map<String, dynamic> json) {
    final original = json['originalAmountCents'];
    final discount = json['discountAmountCents'];
    final amount = json['amountCents'];
    final currency = json['currency'];
    final couponCode = json['couponCode'];
    final discountPercentage = json['discountPercentage'];
    if (original is! num ||
        discount is! num ||
        amount is! num ||
        currency is! String ||
        (couponCode != null && couponCode is! String) ||
        discountPercentage is! num) {
      throw const FormatException('Invalid course quote.');
    }
    return CourseCheckoutQuote(
      originalAmountCents: original.toInt(),
      discountAmountCents: discount.toInt(),
      amountCents: amount.toInt(),
      currency: currency,
      couponCode: couponCode as String?,
      discountPercentage: discountPercentage.toDouble(),
    );
  }
}

class CoursePaymentAttempt {
  const CoursePaymentAttempt({
    required this.id,
    required this.checkoutUrl,
    required this.status,
    required this.quote,
    this.resumedExisting = false,
    this.requiresConfirmation = false,
    this.requestDiffers = false,
  });

  final String id;
  final String checkoutUrl;
  final String status;
  final CourseCheckoutQuote quote;
  final bool resumedExisting;
  final bool requiresConfirmation;
  final bool requestDiffers;

  factory CoursePaymentAttempt.fromJson(Map<String, dynamic> json) {
    final id = json['paymentAttemptId'];
    final checkoutUrl = json['checkoutUrl'];
    final status = json['status'];
    final quote = json['quote'];
    final resumedExisting = json['resumedExisting'];
    final requiresConfirmation = json['requiresConfirmation'];
    final requestDiffers = json['requestDiffers'];
    if (id is! String ||
        id.isEmpty ||
        checkoutUrl is! String ||
        status is! String ||
        status.isEmpty ||
        (resumedExisting != null && resumedExisting is! bool) ||
        (requiresConfirmation != null && requiresConfirmation is! bool) ||
        (requestDiffers != null && requestDiffers is! bool) ||
        quote is! Map) {
      throw const FormatException('Invalid course payment response.');
    }
    return CoursePaymentAttempt(
      id: id,
      checkoutUrl: checkoutUrl,
      status: status,
      quote: CourseCheckoutQuote.fromJson(Map<String, dynamic>.from(quote)),
      resumedExisting: resumedExisting == true,
      requiresConfirmation: requiresConfirmation == true,
      requestDiffers: requestDiffers == true,
    );
  }
}

class CoursePaymentStatusResult {
  const CoursePaymentStatusResult({
    required this.status,
    this.verificationState = 'unknown',
    this.retryAfterSeconds = 0,
    this.canRetry = true,
  });

  final String status;
  final String verificationState;
  final int retryAfterSeconds;
  final bool canRetry;

  factory CoursePaymentStatusResult.fromJson(Map<String, dynamic> json) {
    final status = json['status'];
    final verificationState = json['verificationState'];
    final retryAfterSeconds = json['retryAfterSeconds'];
    final canRetry = json['canRetry'];
    if (status is! String ||
        status.isEmpty ||
        (verificationState != null && verificationState is! String) ||
        (retryAfterSeconds != null && retryAfterSeconds is! num) ||
        (canRetry != null && canRetry is! bool)) {
      throw const FormatException('Invalid payment status response.');
    }
    return CoursePaymentStatusResult(
      status: status,
      verificationState: verificationState as String? ?? 'unknown',
      retryAfterSeconds: (retryAfterSeconds as num?)?.toInt() ?? 0,
      canRetry: canRetry as bool? ?? true,
    );
  }
}
