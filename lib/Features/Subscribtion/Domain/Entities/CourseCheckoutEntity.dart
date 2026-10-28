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
    this.canResume = false,
  });

  final String id;
  final String checkoutUrl;
  final String status;
  final CourseCheckoutQuote quote;
  final bool resumedExisting;
  final bool requiresConfirmation;
  final bool requestDiffers;
  final bool canResume;

  factory CoursePaymentAttempt.fromJson(Map<String, dynamic> json) {
    final id = json['paymentAttemptId'];
    final checkoutUrl = json['checkoutUrl'];
    final status = json['status'];
    final quote = json['quote'];
    final resumedExisting = json['resumedExisting'];
    final requiresConfirmation = json['requiresConfirmation'];
    final requestDiffers = json['requestDiffers'];
    final canResume = json['canResume'];
    if (id is! String ||
        id.isEmpty ||
        checkoutUrl is! String ||
        status is! String ||
        status.isEmpty ||
        (resumedExisting != null && resumedExisting is! bool) ||
        (requiresConfirmation != null && requiresConfirmation is! bool) ||
        (requestDiffers != null && requestDiffers is! bool) ||
        (canResume != null && canResume is! bool) ||
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
      canResume: canResume == true,
    );
  }
}

class CoursePaymentStatusResult {
  const CoursePaymentStatusResult({
    required this.status,
    this.verificationState = 'unknown',
    this.retryAfterSeconds = 0,
    this.canRetry = true,
    this.checkoutUrl = '',
    this.canResume = false,
    this.paymentConfirmed = false,
  });

  final String status;
  final String verificationState;
  final int retryAfterSeconds;
  final bool canRetry;
  final String checkoutUrl;
  final bool canResume;
  final bool paymentConfirmed;

  factory CoursePaymentStatusResult.fromJson(Map<String, dynamic> json) {
    final status = json['status'];
    final verificationState = json['verificationState'];
    final retryAfterSeconds = json['retryAfterSeconds'];
    final canRetry = json['canRetry'];
    final checkoutUrl = json['checkoutUrl'];
    final canResume = json['canResume'];
    final paymentConfirmed = json['paymentConfirmed'];
    if (status is! String ||
        status.isEmpty ||
        (verificationState != null && verificationState is! String) ||
        (retryAfterSeconds != null && retryAfterSeconds is! num) ||
        (retryAfterSeconds is num &&
            (!retryAfterSeconds.isFinite ||
                retryAfterSeconds < 0 ||
                retryAfterSeconds % 1 != 0)) ||
        (canRetry != null && canRetry is! bool) ||
        (checkoutUrl != null && checkoutUrl is! String) ||
        (canResume != null && canResume is! bool) ||
        (paymentConfirmed != null && paymentConfirmed is! bool)) {
      throw const FormatException('Invalid payment status response.');
    }
    return CoursePaymentStatusResult(
      status: status,
      verificationState: verificationState as String? ?? 'unknown',
      retryAfterSeconds: (retryAfterSeconds as num?)?.toInt() ?? 0,
      canRetry: canRetry as bool? ?? true,
      checkoutUrl: checkoutUrl as String? ?? '',
      canResume: canResume as bool? ?? false,
      paymentConfirmed: paymentConfirmed as bool? ?? false,
    );
  }
}
