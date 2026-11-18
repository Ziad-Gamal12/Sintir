import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localingo/localingo.dart';
import 'package:sintir/Core/utils/locale_formatter.dart';
import 'package:sintir/Core/utils/relative_date_formatter.dart';

/// Translations resolve through the app's navigator, so each language gets a
/// tiny app first.
Future<void> _useLocale(WidgetTester tester, String languageCode) async {
  final navigatorKey = GlobalKey<NavigatorState>();
  Localingo.setNavigatorKey(navigatorKey);
  await tester.pumpWidget(
    MaterialApp(
      navigatorKey: navigatorKey,
      locale: Locale(languageCode),
      supportedLocales: const [Locale('ar'), Locale('en'), Locale('fr')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const SizedBox.shrink(),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  final now = DateTime(2026, 11, 17, 15, 0);

  String ago(Duration elapsed, String locale) => RelativeDateFormatter.format(
    now.subtract(elapsed),
    now: now,
    locale: locale,
  );

  testWidgets('English: minutes, hours, yesterday, days, then the date', (
    tester,
  ) async {
    await _useLocale(tester, 'en');
    expect(ago(const Duration(seconds: 30), 'en'), 'Just now');
    // A device clock a little behind the server.
    expect(ago(const Duration(minutes: -2), 'en'), 'Just now');
    expect(ago(const Duration(minutes: 1), 'en'), '1 minute ago');
    expect(ago(const Duration(minutes: 2), 'en'), '2 minutes ago');
    expect(ago(const Duration(minutes: 45), 'en'), '45 minutes ago');
    expect(ago(const Duration(hours: 1), 'en'), '1 hour ago');
    expect(ago(const Duration(hours: 5, minutes: 59), 'en'), '5 hours ago');
    expect(ago(const Duration(hours: 23, minutes: 59), 'en'), '23 hours ago');

    final yesterdayMorning = DateTime(2026, 11, 16, 9, 0);
    expect(
      RelativeDateFormatter.format(yesterdayMorning, now: now, locale: 'en'),
      'Yesterday',
    );
    // 47 hours, but only two calendar days back.
    final twoDaysBack = DateTime(2026, 11, 15, 16, 0);
    expect(
      RelativeDateFormatter.format(twoDaysBack, now: now, locale: 'en'),
      '2 days ago',
    );
    expect(ago(const Duration(days: 6), 'en'), '6 days ago');
    expect(ago(const Duration(days: 7), 'en'), '10 November 2026');
  });

  testWidgets('Arabic uses its plural forms and Latin digits', (tester) async {
    await _useLocale(tester, 'ar');
    expect(ago(const Duration(seconds: 10), 'ar'), 'الآن');
    expect(ago(const Duration(minutes: 1), 'ar'), 'منذ دقيقة');
    expect(ago(const Duration(minutes: 2), 'ar'), 'منذ دقيقتين');
    expect(ago(const Duration(minutes: 5), 'ar'), 'منذ 5 دقائق');
    expect(ago(const Duration(minutes: 30), 'ar'), 'منذ 30 دقيقة');
    expect(ago(const Duration(hours: 2), 'ar'), 'منذ ساعتين');
    expect(ago(const Duration(hours: 11), 'ar'), 'منذ 11 ساعة');
    expect(ago(const Duration(days: 1, hours: 2), 'ar'), 'أمس');
    expect(ago(const Duration(days: 3), 'ar'), 'منذ 3 أيام');
    final oldDate = now.subtract(const Duration(days: 30));
    expect(
      RelativeDateFormatter.format(oldDate, now: now, locale: 'ar'),
      LocaleFormatter.longDate(oldDate, 'ar'),
    );
    expect(LocaleFormatter.longDate(oldDate, 'ar'), contains('2026'));
  });

  testWidgets('French', (tester) async {
    await _useLocale(tester, 'fr');
    expect(ago(const Duration(minutes: 5), 'fr'), 'Il y a 5 minutes');
    expect(ago(const Duration(hours: 1), 'fr'), 'Il y a 1 heure');
    expect(ago(const Duration(hours: 30), 'fr'), 'Hier');
    expect(ago(const Duration(days: 4), 'fr'), 'Il y a 4 jours');
  });
}
