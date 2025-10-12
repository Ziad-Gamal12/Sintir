// ignore_for_file: file_names

class CourseCouponEntity {
  final String code;
  final double discountPercentage;
  final DateTime expiryDate;
  bool isActive;
  final int usageLimit;
  final int usedCount;

  CourseCouponEntity({
    required this.code,
    required this.discountPercentage,
    required this.expiryDate,
    required this.isActive,
    required this.usageLimit,
    required this.usedCount,
  });

  bool get isExpired => DateTime.now().isAfter(expiryDate);

  double applyDiscount(double originalPrice) {
    if (!isActive || isExpired) return originalPrice;
    return originalPrice * (1 - discountPercentage / 100);
  }

  static CourseCouponEntity empty() {
    return CourseCouponEntity(
      code: "loading",
      discountPercentage: 0,
      expiryDate: DateTime.now(),
      isActive: false,
      usageLimit: 0,
      usedCount: 0,
    );
  }
}
