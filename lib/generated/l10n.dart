// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Payment is being verified. You can safely leave this page and check again later.`
  String get payment_verifying {
    return Intl.message(
      'Payment is being verified. You can safely leave this page and check again later.',
      name: 'payment_verifying',
      desc: '',
      args: [],
    );
  }

  /// `Payment was not completed.`
  String get payment_not_completed {
    return Intl.message(
      'Payment was not completed.',
      name: 'payment_not_completed',
      desc: '',
      args: [],
    );
  }

  /// `This checkout has expired.`
  String get checkout_expired {
    return Intl.message(
      'This checkout has expired.',
      name: 'checkout_expired',
      desc: '',
      args: [],
    );
  }

  /// `Payment status could not be retrieved. Try again.`
  String get payment_status_unavailable {
    return Intl.message(
      'Payment status could not be retrieved. Try again.',
      name: 'payment_status_unavailable',
      desc: '',
      args: [],
    );
  }

  /// `Paymob confirmed a payment, but we could not finalize enrollment automatically. Contact support before paying again.`
  String get payment_requires_review {
    return Intl.message(
      'Paymob confirmed a payment, but we could not finalize enrollment automatically. Contact support before paying again.',
      name: 'payment_requires_review',
      desc: '',
      args: [],
    );
  }

  /// `Check payment status`
  String get check_payment_status {
    return Intl.message(
      'Check payment status',
      name: 'check_payment_status',
      desc: '',
      args: [],
    );
  }

  /// `Leave checkout`
  String get leave_checkout {
    return Intl.message(
      'Leave checkout',
      name: 'leave_checkout',
      desc: '',
      args: [],
    );
  }

  /// `Subscriber Details`
  String get subscriber_details_title {
    return Intl.message(
      'Subscriber Details',
      name: 'subscriber_details_title',
      desc: '',
      args: [],
    );
  }

  /// `Education level not specified`
  String get subscriber_education_fallback {
    return Intl.message(
      'Education level not specified',
      name: 'subscriber_education_fallback',
      desc: '',
      args: [],
    );
  }

  /// `Address not specified`
  String get subscriber_address_fallback {
    return Intl.message(
      'Address not specified',
      name: 'subscriber_address_fallback',
      desc: '',
      args: [],
    );
  }

  /// `Phone number not available`
  String get subscriber_phone_fallback {
    return Intl.message(
      'Phone number not available',
      name: 'subscriber_phone_fallback',
      desc: '',
      args: [],
    );
  }

  /// `Joined`
  String get subscriber_joined_date {
    return Intl.message(
      'Joined',
      name: 'subscriber_joined_date',
      desc: '',
      args: [],
    );
  }

  /// `Student ID:`
  String get student_code {
    return Intl.message(
      'Student ID:',
      name: 'student_code',
      desc: '',
      args: [],
    );
  }

  /// `Student ID copied`
  String get subscriber_id_copied {
    return Intl.message(
      'Student ID copied',
      name: 'subscriber_id_copied',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get copy {
    return Intl.message('Copy', name: 'copy', desc: '', args: []);
  }

  /// `Could not copy the student ID`
  String get copy_failed {
    return Intl.message(
      'Could not copy the student ID',
      name: 'copy_failed',
      desc: '',
      args: [],
    );
  }

  /// `Subscribed courses`
  String get subscribed_courses {
    return Intl.message(
      'Subscribed courses',
      name: 'subscribed_courses',
      desc: '',
      args: [],
    );
  }

  /// `{count} courses`
  String courses_count(int count) {
    return Intl.message(
      '$count courses',
      name: 'courses_count',
      desc: '',
      args: [count],
    );
  }

  /// `Average score`
  String get performance_trend {
    return Intl.message(
      'Average score',
      name: 'performance_trend',
      desc: '',
      args: [],
    );
  }

  /// `Exam score progression`
  String get exam_score_progression {
    return Intl.message(
      'Exam score progression',
      name: 'exam_score_progression',
      desc: '',
      args: [],
    );
  }

  /// `Highest score`
  String get highest_score {
    return Intl.message(
      'Highest score',
      name: 'highest_score',
      desc: '',
      args: [],
    );
  }

  /// `Lowest score`
  String get lowest_score {
    return Intl.message(
      'Lowest score',
      name: 'lowest_score',
      desc: '',
      args: [],
    );
  }

  /// `Exam results history`
  String get exam_results_history {
    return Intl.message(
      'Exam results history',
      name: 'exam_results_history',
      desc: '',
      args: [],
    );
  }

  /// `Education level`
  String get education_level {
    return Intl.message(
      'Education level',
      name: 'education_level',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
