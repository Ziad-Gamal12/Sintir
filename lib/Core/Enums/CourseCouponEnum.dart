import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/CouponStatusBadgeIconEntity.dart';
import 'package:sintir/locale_keys.dart';

enum CourseCouponStatus {
  active,
  inactive,
}

enum CourseCouponAvailability {
  active,
  inactive,
  expired,
  usageLimitReached,
}

extension CourseCouponAvailabilityStyle on CourseCouponAvailability {
  Color get color {
    return switch (this) {
      CourseCouponAvailability.active => const Color(0xFF4CAF50),
      CourseCouponAvailability.inactive => const Color(0xFF9E9E9E),
      CourseCouponAvailability.expired => const Color(0xFF9E9E9E),
      CourseCouponAvailability.usageLimitReached => const Color(0xFFFF9800),
    };
  }

  String get label {
    return switch (this) {
      CourseCouponAvailability.active => LocaleKeys.couponStatusActive,
      CourseCouponAvailability.inactive => LocaleKeys.couponStatusInactive,
      CourseCouponAvailability.expired => LocaleKeys.couponStatusExpired,
      CourseCouponAvailability.usageLimitReached =>
        LocaleKeys.couponLimitReached,
    };
  }

  CouponStatusBadgeIconEntity get badgeIcon {
    return switch (this) {
      CourseCouponAvailability.active => CouponStatusBadgeIconEntity(
          icon: Icons.check_circle, color: const Color(0xFF4CAF50)),
      CourseCouponAvailability.inactive => CouponStatusBadgeIconEntity(
          icon: Icons.remove_circle, color: const Color(0xFF9E9E9E)),
      CourseCouponAvailability.expired => CouponStatusBadgeIconEntity(
          icon: Icons.error, color: const Color(0xFF9E9E9E)),
      CourseCouponAvailability.usageLimitReached => CouponStatusBadgeIconEntity(
          icon: Icons.warning, color: const Color(0xFFFF9800)),
    };
  }
}
