import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localingo/localingo.dart';
import 'package:sintir/Core/Themes/app_theme.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Manager/my_transactions_cubit/my_transactions_cubit.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/card/transaction_card.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/details_sheet/transaction_details_panel.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/states/transaction_skeleton_card.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/summary/transactions_reconciliation_summary.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'transaction cards and details fit narrow screens with enlarged text',
    (tester) async {
      final navigatorKey = GlobalKey<NavigatorState>();
      Localingo.setNavigatorKey(navigatorKey);
      final transaction = TransactionEntity(
        transactionId: '8F32A1-994021',
        createdAt: DateTime(2024, 5, 19, 10, 45),
        amount: 850,
        currency: 'EGP',
        issuer: 'البنك الأهلي المصري (NBE)',
        method: 'PayMent',
        isReconciled: true,
        mobileNumber: '01280316031',
        status: TransactionsStatus.success,
      );

      for (final locale in [
        const Locale('ar'),
        const Locale('en'),
        const Locale('fr'),
      ]) {
        for (final theme in [AppTheme.light, AppTheme.dark]) {
          for (final size in [const Size(320, 900), const Size(390, 900)]) {
            tester.view.devicePixelRatio = 1;
            tester.view.physicalSize = size;
            await tester.pumpWidget(
              MaterialApp(
                navigatorKey: navigatorKey,
                locale: locale,
                supportedLocales: const [
                  Locale('ar'),
                  Locale('en'),
                  Locale('fr'),
                ],
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                theme: theme,
                home: MediaQuery(
                  data: MediaQueryData(
                    size: size,
                    textScaler: const TextScaler.linear(1.3),
                  ),
                  child: Scaffold(
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 12),
                          TransactionsReconciliationSummary(
                            state: MyTransactionsState(
                              transactions: [transaction],
                              isSystemConnected: true,
                            ),
                          ),
                          TransactionCard(
                            transaction: transaction,
                            onSelected: () {},
                          ),
                          const TransactionSkeletonCard(),
                          SizedBox(
                            height: 780,
                            child: TransactionDetailsPanel(
                              transaction: transaction,
                              showHandle: true,
                              onClose: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
            await tester.pump(const Duration(milliseconds: 100));
            await tester.pump();
            expect(
              tester.takeException(),
              isNull,
              reason: '${locale.languageCode}, ${theme.brightness}, $size',
            );
          }
        }
      }

      await tester.pumpWidget(const SizedBox.shrink());
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    },
  );
}
