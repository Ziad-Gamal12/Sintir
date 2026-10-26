import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localingo/localingo.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const checkoutKeys = [
    'payment_verifying',
    'payment_not_completed',
    'checkout_expired',
    'payment_status_unavailable',
    'payment_check_cooldown_prefix',
    'payment_check_cooldown_suffix',
    'payment_finalizing_enrollment',
    'payment_requires_review',
    'retry_checkout',
    'check_payment_status',
    'leave_checkout',
    'existing_checkout_title',
    'existing_checkout_message',
    'existing_checkout_coupon_mismatch',
    'original_checkout_amount',
    'original_checkout_coupon',
    'no_coupon_applied',
    'resume_checkout',
    'check_later',
    'enter_course',
  ];

  for (final languageCode in ['en', 'ar', 'fr']) {
    test('checkout translations are available in $languageCode', () async {
      final localizations = AppLocalizations(Locale(languageCode));

      expect(await localizations.load(), isTrue);
      expect(localizations.keys, containsAll(checkoutKeys));
      final cooldown =
          '${localizations.translate('payment_check_cooldown_prefix')} 24 ${localizations.translate('payment_check_cooldown_suffix')}';
      expect(cooldown, contains('24'));
      expect(
        localizations.translate('payment_finalizing_enrollment'),
        isNot('payment_finalizing_enrollment'),
      );
    });
  }
}
