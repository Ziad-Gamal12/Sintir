// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentTheme.dart';
import 'package:sintir/locale_keys.dart';

enum TeacherCourseStatus {
  all,
  published,
  inReview,
  archived,
  unknown;

  static TeacherCourseStatus fromRaw(String? raw) {
    if (raw == null) return TeacherCourseStatus.unknown;
    if (raw == BackendEndpoints.coursePublishedState) {
      return TeacherCourseStatus.published;
    }
    if (raw == BackendEndpoints.coursePendingState) {
      return TeacherCourseStatus.inReview;
    }
    if (raw == BackendEndpoints.courseDeletedState) {
      return TeacherCourseStatus.archived;
    }
    return TeacherCourseStatus.unknown;
  }

  String label(BuildContext context) {
    switch (this) {
      case TeacherCourseStatus.all:
        return LocaleKeys.filterAll(0).split(' ').first;
      case TeacherCourseStatus.published:
        return LocaleKeys.statusPublished;
      case TeacherCourseStatus.inReview:
        return LocaleKeys.statusInReview;
      case TeacherCourseStatus.archived:
        return LocaleKeys.statusArchived;
      case TeacherCourseStatus.unknown:
        return '';
    }
  }

  String chipLabel(int count) {
    switch (this) {
      case TeacherCourseStatus.all:
        return LocaleKeys.filterAll(count);
      case TeacherCourseStatus.published:
        return LocaleKeys.filterPublished(count);
      case TeacherCourseStatus.inReview:
        return LocaleKeys.filterInReview(count);
      case TeacherCourseStatus.archived:
        return LocaleKeys.filterArchived(count);
      case TeacherCourseStatus.unknown:
        return '';
    }
  }

  Color foregroundColor(WorkEnvironmentThemeExtension tokens) {
    switch (this) {
      case TeacherCourseStatus.published:
        return tokens.successForeground;
      case TeacherCourseStatus.inReview:
        return tokens.warningForeground;
      case TeacherCourseStatus.archived:
      case TeacherCourseStatus.all:
      case TeacherCourseStatus.unknown:
        return tokens.neutralForeground;
    }
  }

  Color backgroundColor(WorkEnvironmentThemeExtension tokens) {
    switch (this) {
      case TeacherCourseStatus.published:
        return tokens.successBackground;
      case TeacherCourseStatus.inReview:
        return tokens.warningBackground;
      case TeacherCourseStatus.archived:
      case TeacherCourseStatus.all:
      case TeacherCourseStatus.unknown:
        return tokens.neutralBackground;
    }
  }

  Color borderColor(WorkEnvironmentThemeExtension tokens) {
    switch (this) {
      case TeacherCourseStatus.published:
        return tokens.successBorder;
      case TeacherCourseStatus.inReview:
        return tokens.warningBorder;
      case TeacherCourseStatus.archived:
      case TeacherCourseStatus.all:
      case TeacherCourseStatus.unknown:
        return tokens.neutralBorder;
    }
  }
}

class TeacherWorkEnvironmentFormatters {
  const TeacherWorkEnvironmentFormatters._();

  static final NumberFormat _currencyFormatter = NumberFormat(
    '#,##0.00',
    'en_US',
  );
  static final NumberFormat _integerFormatter = NumberFormat('#,##0', 'en_US');

  static String formatAmount(num amount) => _currencyFormatter.format(amount);

  static String formatPrice(num price) => _integerFormatter.format(price);

  static String normalizeSearch(String input) {
    final withoutTashkeel = input.replaceAll(
      RegExp(r'[\u064B-\u065F\u0670]'),
      '',
    );
    return withoutTashkeel
        .replaceAll(RegExp(r'[أإآٱ]'), 'ا')
        .replaceAll('ى', 'ي')
        .replaceAll('ة', 'ه')
        .toLowerCase()
        .trim();
  }

  static String formatStudentsCount(int count, String localeCode) {
    final formattedNumber = _integerFormatter.format(count);
    if (localeCode == 'ar') {
      if (count == 0) return '0 طلاب';
      if (count >= 3 && count <= 10) return '$formattedNumber طلاب';
      return '$formattedNumber طالب';
    } else if (localeCode == 'fr') {
      return count <= 1 ? '$formattedNumber élève' : '$formattedNumber élèves';
    } else {
      return count == 1
          ? '$formattedNumber student'
          : '$formattedNumber students';
    }
  }

  static String formatLessonsCount(int count, String localeCode) {
    final formattedNumber = _integerFormatter.format(count);
    if (localeCode == 'ar') {
      if (count == 0) return '0 دروس';
      if (count >= 3 && count <= 10) return '$formattedNumber دروس';
      return '$formattedNumber درس';
    } else if (localeCode == 'fr') {
      return count <= 1 ? '$formattedNumber leçon' : '$formattedNumber leçons';
    } else {
      return count == 1
          ? '$formattedNumber lesson'
          : '$formattedNumber lessons';
    }
  }

  static String formatTestsCount(int count, String localeCode) {
    final formattedNumber = _integerFormatter.format(count);
    if (localeCode == 'ar') {
      if (count == 0) return '0 اختبار';
      if (count >= 3 && count <= 10) return '$formattedNumber اختبارات';
      return '$formattedNumber اختبار';
    } else if (localeCode == 'fr') {
      return count <= 1 ? '$formattedNumber test' : '$formattedNumber tests';
    } else {
      return count == 1 ? '$formattedNumber test' : '$formattedNumber tests';
    }
  }
}
