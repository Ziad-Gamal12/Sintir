import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// The l10n JSON files are over 50 KB, so `rootBundle.loadString` decodes them
/// on a background isolate, which never finishes inside the fake-async zone of
/// `testWidgets` and leaves `Localizations` (and the whole app) blank.
///
/// Call this from `setUpAll`, which runs in real async, to fill the bundle's
/// string cache, then pump with [pumpLocalized].
Future<void> preloadL10nAssets() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  for (final languageCode in const ['ar', 'en', 'fr']) {
    await rootBundle.loadString('assets/l10n/$languageCode.json');
  }
}

/// Settles the first frames of an app whose strings were preloaded with
/// [preloadL10nAssets].
///
/// The cached load was completed in the real zone, so its callbacks run on
/// the real event loop; give that loop one turn before settling the fake one.
///
/// Pass `settle: false` for screens that never settle in tests (see
/// [pumpFrames]).
Future<void> pumpLocalized(WidgetTester tester, {bool settle = true}) async {
  await tester.runAsync(() => Future<void>.delayed(Duration.zero));
  if (settle) {
    await tester.pumpAndSettle();
  } else {
    await pumpFrames(tester);
  }
}

/// Pumps one second of frames, which covers route transitions, for screens
/// where `pumpAndSettle` times out, such as a network image whose loading
/// shimmer never stops because nothing loads in tests.
Future<void> pumpFrames(WidgetTester tester) async {
  for (var i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

/// The test font draws every glyph 1em wide, so dense rows overflow in tests
/// even when they fit with the app's font. Call this in tests that check what
/// a list shows, not its layout; every other error still fails the test.
void ignoreOverflowErrors() {
  final original = FlutterError.onError;
  FlutterError.onError = (details) {
    if (details.exceptionAsString().contains('A RenderFlex overflowed')) {
      return;
    }
    original?.call(details);
  };
  addTearDown(() => FlutterError.onError = original);
}
