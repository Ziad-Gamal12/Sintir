// ignore_for_file: file_names

import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';

enum ProfileField { firstName, lastName, phone, educationLevel }

class PersonName {
  const PersonName(this.first, this.last);
  final String first;
  final String last;
}

class ProfileCompleteness {
  const ProfileCompleteness._();

  static const List<String> educationLevels = [
    "1st Grade Primary",
    "2nd Grade Primary",
    "3rd Grade Primary",
    "4th Grade Primary",
    "5th Grade Primary",
    "6th Grade Primary",
    "1st Grade Preparatory",
    "2nd Grade Preparatory",
    "3rd Grade Preparatory",
    "1st Grade Secondary",
    "2nd Grade Secondary",
    "3rd Grade Secondary",
  ];

  static final RegExp _egyptMobile = RegExp(r'^01[0125]\d{8}$');

  static String normalizePhone(String raw) {
    final digits = raw.replaceAll(RegExp(r'[^0-9+]'), '');
    if (digits.startsWith('+20')) return '0${digits.substring(3)}';
    if (digits.startsWith('0020')) return '0${digits.substring(4)}';
    if (digits.startsWith('20') && digits.length == 12) {
      return '0${digits.substring(2)}';
    }
    return digits.replaceAll('+', '');
  }

  static bool isValidPhone(String raw) =>
      _egyptMobile.hasMatch(normalizePhone(raw));

  static bool _isBlank(String value) {
    final text = value.trim();
    return text.isEmpty || text.toLowerCase() == 'empty';
  }

  static bool _isStudent(UserEntity user) =>
      user.role == BackendEndpoints.studentRole;

  static List<ProfileField> missingForAccount(UserEntity user) {
    if (!_isStudent(user)) return const [];
    final level = user.studentExtraDataEntity?.educationLevel ?? '';
    return [
      if (_isBlank(user.firstName)) ProfileField.firstName,
      if (_isBlank(user.lastName)) ProfileField.lastName,
      if (!isValidPhone(user.phoneNumber)) ProfileField.phone,
      if (!educationLevels.contains(level)) ProfileField.educationLevel,
    ];
  }

  static List<ProfileField> missingForPayment(UserEntity user) {
    if (!_isStudent(user)) return const [];
    return [
      if (_isBlank(user.firstName)) ProfileField.firstName,
      if (!isValidPhone(user.phoneNumber)) ProfileField.phone,
    ];
  }

  static bool needsCompletion(UserEntity user) =>
      missingForAccount(user).isNotEmpty;

  static PersonName splitName(UserEntity user) {
    final first = _isBlank(user.firstName) ? '' : user.firstName.trim();
    final last = _isBlank(user.lastName) ? '' : user.lastName.trim();
    if (last.isNotEmpty || first.isEmpty) return PersonName(first, last);
    final parts = first.split(RegExp(r'\s+'));
    if (parts.length < 2) return PersonName(first, '');
    return PersonName(parts.first, parts.skip(1).join(' '));
  }
}
