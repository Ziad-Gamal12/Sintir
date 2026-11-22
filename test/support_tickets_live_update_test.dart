import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:localingo/localingo.dart';
import 'package:sintir/Core/Themes/app_theme.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/Support/Domain/Entities/GetSupportTicketsResponseEntity.dart';
import 'package:sintir/Features/Support/Domain/Entities/SupportSenderEntity.dart';
import 'package:sintir/Features/Support/Domain/Entities/SupportTicketEntity.dart';
import 'package:sintir/Features/Support/Domain/Repos/SupportTicketsRepo.dart';
import 'package:sintir/Features/Support/Presentation/Managers/support_tickets_cubit/support_tickets_cubit.dart';
import 'package:sintir/Features/Support/Presentation/Views/AddSupportTicketView.dart';
import 'package:sintir/Features/Support/Presentation/Views/Widgets/MySupportTicketsViewWidgets/MySupportTicketsViewBody.dart';
import 'package:sintir/Features/Support/Presentation/Views/Widgets/MySupportTicketsViewWidgets/MySupportTicketsViewFloatingButton.dart';

import 'helpers/widget_test_helpers.dart';

SupportTicketEntity _ticket(String id, String title, DateTime createdAt) =>
    SupportTicketEntity(
      sender: SupportSenderEntity(
        name: 'Ziad',
        email: 'student@example.com',
        phone: '01000000000',
        role: 'Teacher',
        uid: 'u1',
        photoUrl: '',
      ),
      id: id,
      title: title,
      category: 'TECHNICAL_ISSUE',
      description: '$title details',
      createdAt: createdAt,
      updatedAt: createdAt,
      status: 'pending',
    );

class _FakeTicketsRepo implements SupportTicketsRepo {
  _FakeTicketsRepo(this.tickets);

  final List<SupportTicketEntity> tickets;
  int fetches = 0;

  @override
  Future<Either<Failure, GetSupportTicketsResponseEntity>>
  getUserSupportTickets({
    required String userId,
    required bool isPaginate,
  }) async {
    fetches++;
    return Right(
      GetSupportTicketsResponseEntity(
        supportTickets: List.of(tickets),
        hasMore: false,
        isPaginate: isPaginate,
      ),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Future<void> _pump(
  WidgetTester tester,
  _FakeTicketsRepo repo, {
  SupportTicketEntity? addResult,
}) async {
  ignoreOverflowErrors();
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(700, 1400);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final key = GlobalKey<NavigatorState>();
  Localingo.setNavigatorKey(key);
  final router = GoRouter(
    navigatorKey: key,
    routes: [
      GoRoute(
        path: '/',
        builder: (_, _) => BlocProvider(
          create: (_) => SupportTicketsCubit(supportTicketsRepo: repo),
          child: const Scaffold(
            floatingActionButton: MySupportTicketsViewFloatingButton(),
            body: MySupportTicketsViewBody(userId: 'u1'),
          ),
        ),
      ),
      GoRoute(
        path: AddSupportTicketView.routeName,
        builder: (context, _) => Scaffold(
          body: TextButton(
            onPressed: () => context.pop(addResult),
            child: const Text('finish-add'),
          ),
        ),
      ),
    ],
  );
  await tester.pumpWidget(
    MaterialApp.router(
      routerConfig: router,
      locale: const Locale('en'),
      supportedLocales: const [Locale('ar'), Locale('en'), Locale('fr')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: AppTheme.dark,
    ),
  );
  // The sender photo's loading shimmer never stops in tests.
  await pumpLocalized(tester, settle: false);
}

Future<void> _addTicketFromAddScreen(WidgetTester tester) async {
  await tester.tap(find.byKey(const ValueKey('support-add-ticket-button')));
  await pumpFrames(tester);
  await tester.tap(find.text('finish-add'));
  await pumpFrames(tester);
}

void main() {
  setUpAll(preloadL10nAssets);

  test('the cubit hands a sent ticket to the list', () async {
    final cubit = SupportTicketsCubit(supportTicketsRepo: _FakeTicketsRepo([]));
    final next = cubit.stream.first;
    final ticket = _ticket('t1', 'Cannot open course', DateTime(2026, 11, 22));

    cubit.showAddedTicket(ticket);

    final state = await next;
    expect(state, isA<SupportTicketAddedLocally>());
    expect((state as SupportTicketAddedLocally).ticket, same(ticket));
    await cubit.close();
  });

  group('support tickets screen', () {
    testWidgets('a sent ticket shows up on top without reopening', (
      tester,
    ) async {
      final repo = _FakeTicketsRepo([
        _ticket('t1', 'Old ticket', DateTime(2026, 11, 1)),
      ]);
      await _pump(
        tester,
        repo,
        addResult: _ticket('t2', 'New ticket', DateTime(2026, 11, 22)),
      );
      expect(find.text('Old ticket'), findsOneWidget);
      expect(find.text('New ticket'), findsNothing);

      await _addTicketFromAddScreen(tester);

      expect(find.text('New ticket'), findsOneWidget);
      expect(find.text('Old ticket'), findsOneWidget);
      expect(
        tester.getTopLeft(find.byKey(const ValueKey('support-ticket-t2'))).dy,
        lessThan(
          tester.getTopLeft(find.byKey(const ValueKey('support-ticket-t1'))).dy,
        ),
      );
      expect(repo.fetches, 1);
    });

    testWidgets('the first ticket replaces the empty state', (tester) async {
      final repo = _FakeTicketsRepo([]);
      await _pump(
        tester,
        repo,
        addResult: _ticket('t1', 'First ticket', DateTime(2026, 11, 22)),
      );
      expect(find.text('First ticket'), findsNothing);

      await _addTicketFromAddScreen(tester);

      expect(find.text('First ticket'), findsOneWidget);
      expect(repo.fetches, 1);
    });

    testWidgets('leaving the add screen without sending changes nothing', (
      tester,
    ) async {
      final repo = _FakeTicketsRepo([
        _ticket('t1', 'Old ticket', DateTime(2026, 11, 1)),
      ]);
      await _pump(tester, repo);

      await _addTicketFromAddScreen(tester);

      expect(find.text('Old ticket'), findsOneWidget);
      expect(find.byKey(const ValueKey('support-ticket-t1')), findsOneWidget);
      expect(repo.fetches, 1);
    });
  });
}
