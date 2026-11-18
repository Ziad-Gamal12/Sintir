import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/Themes/app_theme.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletStatus.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/teacher_wallet_card.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/withdraw/teacher_withdraw_unavailable_body.dart';

import 'wallet_test_fakes.dart';

/// Every wallet state must lay out cleanly on phones through desktops, at
/// large text scales, in both directions.
void main() {
  const widths = [320.0, 360.0, 412.0, 600.0, 1024.0];
  const scales = [1.0, 1.3, 2.0, 3.0];

  Future<void> pump(
    WidgetTester tester, {
    required Widget child,
    required double width,
    required double height,
    required double scale,
    required TextDirection direction,
    required ThemeData theme,
  }) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = Size(width, height);
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        theme: theme,
        builder: (context, app) => MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(scale)),
          child: Directionality(textDirection: direction, child: app!),
        ),
        home: Scaffold(body: child),
      ),
    );
    await tester.pump(const Duration(milliseconds: 300));
  }

  for (final status in ['active', 'suspended', 'closed']) {
    testWidgets('wallet card ($status) never overflows', (tester) async {
      for (final theme in [AppTheme.dark, AppTheme.light]) {
        for (final direction in TextDirection.values) {
          for (final width in widths) {
            for (final scale in scales) {
              await pump(
                tester,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: TeacherWalletCard(wallet: wallet(status: status)),
                ),
                width: width,
                height: 1400,
                scale: scale,
                direction: direction,
                theme: theme,
              );
              expect(
                tester.takeException(),
                isNull,
                reason:
                    '$status ${theme.brightness} $direction w=$width x$scale',
              );
            }
          }
        }
      }
    });
  }

  testWidgets('withdraw lock screen fits small screens at large text', (
    tester,
  ) async {
    for (final status in [
      TeacherWalletStatus.inactive,
      TeacherWalletStatus.suspended,
    ]) {
      for (final direction in TextDirection.values) {
        for (final scale in scales) {
          await pump(
            tester,
            child: TeacherWithdrawUnavailableBody(status: status),
            width: 320,
            height: 568,
            scale: scale,
            direction: direction,
            theme: AppTheme.dark,
          );
          expect(
            tester.takeException(),
            isNull,
            reason: '$status $direction x$scale',
          );
        }
      }
    }
  });
}
