import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sintir/Core/Enums/CourseCouponEnum.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';

class CourseCouponModel {
  final String code;
  final double discountPercentage;
  final DateTime expiryDate;
  final CourseCouponStatus status;
  final int usageLimit;
  final int usedCount;

  const CourseCouponModel({
    required this.code,
    required this.discountPercentage,
    required this.expiryDate,
    required this.status,
    required this.usageLimit,
    required this.usedCount,
  });

  static String _normalizeStatus(String value) {
    return value.trim().toLowerCase().replaceAll(RegExp(r'[\s_-]+'), '');
  }

  static CourseCouponStatus _parseStatus(Object? rawStatus) {
    if (rawStatus is! String || rawStatus.trim().isEmpty) {
      return CourseCouponStatus.inactive;
    }

    final token = rawStatus.trim().split('.').last;
    final normalized = _normalizeStatus(token);

    for (final candidate in CourseCouponStatus.values) {
      if (_normalizeStatus(candidate.name) == normalized) {
        return candidate;
      }
    }
    return CourseCouponStatus.inactive;
  }

  static DateTime _parseExpiryDate(Object? value) {
    if (value is Timestamp) {
      return value.toDate();
    }

    if (value is DateTime) {
      return value;
    }

    if (value is String) {
      final parsed = DateTime.tryParse(value);

      if (parsed != null) {
        return parsed;
      }
    }

    throw FormatException(
      'Invalid or missing course coupon expiryDate: $value',
    );
  }

  static String _requiredString(
    Map<String, dynamic> json,
    String key,
  ) {
    final value = json[key];

    if (value is String) {
      return value;
    }

    throw FormatException(
      'Invalid or missing course coupon field: $key',
    );
  }

  static num _requiredNumber(
    Map<String, dynamic> json,
    String key,
  ) {
    final value = json[key];

    if (value is num && value.isFinite) {
      return value;
    }

    throw FormatException(
      'Invalid or missing course coupon field: $key',
    );
  }

  static int _requiredInt(
    Map<String, dynamic> json,
    String key,
  ) {
    final value = _requiredNumber(json, key);

    if (value != value.toInt()) {
      throw FormatException(
        'Course coupon field "$key" must be an integer.',
      );
    }

    return value.toInt();
  }

  factory CourseCouponModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final discount = _requiredNumber(json, 'discountPercentage').toDouble();

    final usageLimit = _requiredInt(json, 'usageLimit');
    final usedCount = _requiredInt(json, 'usedCount');

    if (discount < 0 || discount > 100) {
      throw FormatException(
        'discountPercentage must be between 0 and 100.',
      );
    }

    if (usageLimit < 0 || usedCount < 0) {
      throw FormatException(
        'usageLimit and usedCount cannot be negative.',
      );
    }

    return CourseCouponModel(
      code: _requiredString(json, 'code'),
      discountPercentage: discount,
      expiryDate: _parseExpiryDate(json['expiryDate']),
      status: _parseStatus(json['status']),
      usageLimit: usageLimit,
      usedCount: usedCount,
    );
  }

  factory CourseCouponModel.fromEntity(
    CourseCouponEntity entity,
  ) {
    return CourseCouponModel(
      code: entity.code,
      discountPercentage: entity.discountPercentage,
      expiryDate: entity.expiryDate,
      status: entity.status,
      usageLimit: entity.usageLimit,
      usedCount: entity.usedCount,
    );
  }

  CourseCouponEntity toEntity() {
    return CourseCouponEntity(
      code: code,
      discountPercentage: discountPercentage,
      expiryDate: expiryDate,
      status: status,
      usageLimit: usageLimit,
      usedCount: usedCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'discountPercentage': discountPercentage,
      'expiryDate': Timestamp.fromDate(expiryDate),
      'status': status.name,
      'usageLimit': usageLimit,
      'usedCount': usedCount,
    };
  }
}
