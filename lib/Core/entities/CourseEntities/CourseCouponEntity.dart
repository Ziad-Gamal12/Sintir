// ignore_for_file: file_names

import 'package:sintir/Core/Enums/CourseCouponEnum.dart';

class CourseCouponEntity {
  String code;
  double discountPercentage;
  DateTime expiryDate;
  CourseCouponStatus status;
  int usageLimit;
  int usedCount;

  CourseCouponEntity({
    required this.code,
    required this.discountPercentage,
    required this.expiryDate,
    required this.status,
    required this.usageLimit,
    required this.usedCount,
  });

  bool get isExpired {
    final now = DateTime.now();

    final startOfNextDay = DateTime(
      expiryDate.year,
      expiryDate.month,
      expiryDate.day + 1,
    );

    return !now.isBefore(startOfNextDay);
  }

  bool get hasReachedUsageLimit {
    return usageLimit > 0 && usedCount >= usageLimit;
  }

  bool get isManuallyEnabled {
    return status == CourseCouponStatus.active;
  }

  bool get canBeUsed {
    return isManuallyEnabled && !isExpired && !hasReachedUsageLimit;
  }

  CourseCouponAvailability get availability {
    if (isExpired) {
      return CourseCouponAvailability.expired;
    }

    if (hasReachedUsageLimit) {
      return CourseCouponAvailability.usageLimitReached;
    }

    if (status == CourseCouponStatus.inactive) {
      return CourseCouponAvailability.inactive;
    }

    return CourseCouponAvailability.active;
  }

  double applyDiscount(int originalPrice) {
    if (originalPrice < 0) {
      throw ArgumentError.value(
        originalPrice,
        'originalPrice',
        'Price cannot be negative.',
      );
    }

    if (!discountPercentage.isFinite ||
        discountPercentage < 0 ||
        discountPercentage > 100) {
      throw StateError('Invalid coupon discount percentage.');
    }

    if (!canBeUsed) {
      return originalPrice.toDouble();
    }

    return originalPrice * (1 - discountPercentage / 100);
  }

  CourseCouponEntity copyWith({
    String? code,
    double? discountPercentage,
    DateTime? expiryDate,
    CourseCouponStatus? status,
    int? usageLimit,
    int? usedCount,
  }) {
    return CourseCouponEntity(
      code: code ?? this.code,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      expiryDate: expiryDate ?? this.expiryDate,
      status: status ?? this.status,
      usageLimit: usageLimit ?? this.usageLimit,
      usedCount: usedCount ?? this.usedCount,
    );
  }

  static List<CourseCouponEntity> loadingItems() {
    return List.generate(
      3,
      (index) => CourseCouponEntity(
        code: 'Loading...',
        discountPercentage: 0.0,
        expiryDate: DateTime.now(),
        status: CourseCouponStatus.inactive,
        usageLimit: 0,
        usedCount: 0,
      ),
    );
  }
}
