import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localingo/localingo.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final ratingKeys = [
    'rate_course',
    'edit_your_rating',
    'your_review',
    'rating_required',
    'review_text_hint',
    'save_rating',
    'delete_my_review',
    'delete_review_confirm',
    'rating_saved',
    'review_deleted',
    'no_reviews_yet',
    'no_reviews_yet_description',
    'reviews_retry',
    'rating_summary_unavailable',
    'rating_out_of_five',
    'rate_with_stars',
    'ratings_count_zero',
    'ratings_count_one',
    'ratings_count_two',
    'ratings_count_few',
    'ratings_count_many',
    'ratings_count_other',
    'rating_error_not_subscribed',
    'rating_error_not_allowed',
    'rating_error_inactive_account',
    'rating_error_course_unavailable',
    'rating_error_too_fast',
    'rating_error_busy',
    'rating_error_text_too_long',
    'rating_error_already_deleted',
    'rating_error_sign_in',
    'tap_star_to_rate',
    'what_students_say',
    'no_other_reviews_yet',
    'review_edited',
    'loading_reviews',
    'rate_course_subtitle',
    'be_first_to_rate',
    'edit_review',
    for (var stars = 1; stars <= 5; stars++) 'rating_label_$stars',
    // Shared strings the reviews screen reuses.
    'show_more',
    'show_less',
    'transactions_yesterday',
    'report_time_just_now',
    for (final unit in ['minute', 'hour', 'day'])
      for (final form in ['one', 'two', 'few', 'many'])
        'report_time_${unit}_$form',
  ];

  /// Placeholders each translation must keep, e.g. {count}.
  final placeholders = {
    'rating_out_of_five': ['{rating}'],
    'rate_with_stars': ['{count}'],
    'ratings_count_one': ['{count}'],
    'ratings_count_two': ['{count}'],
    'ratings_count_few': ['{count}'],
    'ratings_count_many': ['{count}'],
    'ratings_count_other': ['{count}'],
    for (final unit in ['minute', 'hour', 'day'])
      for (final form in ['few', 'many'])
        'report_time_${unit}_$form': ['{count}'],
  };

  for (final languageCode in ['en', 'ar', 'fr']) {
    test('rating translations are complete in $languageCode', () async {
      final localizations = AppLocalizations(Locale(languageCode));

      expect(await localizations.load(), isTrue);
      expect(localizations.keys, containsAll(ratingKeys));
      for (final key in ratingKeys) {
        final text = localizations.translate(key);
        expect(text.trim(), isNotEmpty, reason: key);
        expect(text, isNot(key), reason: key);
      }
      placeholders.forEach((key, expected) {
        // Arabic singular/dual forms spell the number out, so they may omit it.
        if (languageCode == 'ar' &&
            (key == 'ratings_count_one' || key == 'ratings_count_two')) {
          return;
        }
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
