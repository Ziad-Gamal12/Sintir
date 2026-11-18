import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localingo/localingo.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final placeholders = {
    'price_egp_amount': ['{amount}'],
    'recommended_for_level': ['{level}'],
    'recommended_for_subject': ['{subject}'],
    'coupon_discount_applied': ['{percent}'],
    'course_students_many': ['{count}'],
    'course_lessons_many': ['{count}'],
    'course_tests_many': ['{count}'],
  };

  final keys = [
    ...placeholders.keys,
    'course_includes',
    'lessons_label',
    'tests_label',
    'course_level_label',
    'teaching_language_label',
    'add_discount_coupon',
    'apply_coupon',
    'remove_coupon',
    'payment_summary',
    'course_price',
    'coupon_discount_line',
    'checkout_total',
    'secure_payment_paymob',
    'new_course_label',
    'free',
    'enter_coupon_code',
    'coupon_discount',
    for (var grade = 1; grade <= 6; grade++) 'course_level_primary_$grade',
    for (var grade = 1; grade <= 3; grade++) 'course_level_preparatory_$grade',
    for (var grade = 1; grade <= 3; grade++) 'course_level_secondary_$grade',
    for (final subject in [
      'arabic',
      'english',
      'french',
      'italian',
      'spanish',
      'mathematics',
      'physics',
      'chemistry',
      'biology',
      'biological_science',
      'science',
      'philosophy',
      'history',
      'geography',
      'computer_science',
      'other',
    ])
      'course_subject_$subject',
    for (final language in ['arabic', 'english', 'other'])
      'course_language_$language',
  ];

  for (final languageCode in ['en', 'ar', 'fr']) {
    test('course card and checkout translations are complete in $languageCode',
        () async {
      final localizations = AppLocalizations(Locale(languageCode));

      expect(await localizations.load(), isTrue);
      expect(localizations.keys, containsAll(keys));
      for (final key in keys) {
        final text = localizations.translate(key);
        expect(text.trim(), isNotEmpty, reason: key);
        expect(text, isNot(key), reason: key);
      }
      placeholders.forEach((key, expected) {
        for (final placeholder in expected) {
          expect(
            localizations.translate(key),
            contains(placeholder),
            reason: '$key in $languageCode',
          );
        }
      });
    });
  }
}
