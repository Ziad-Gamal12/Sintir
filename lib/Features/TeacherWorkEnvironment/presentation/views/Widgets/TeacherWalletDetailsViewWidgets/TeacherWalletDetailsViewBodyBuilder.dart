import 'package:flutter/material.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWalletDetailsSection.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeachersTransactionsListView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeachersTransactionsListViewHeader.dart';
import 'package:sintir/constant.dart';

class TeacherWalletDetailsViewBodyBuilder extends StatelessWidget {
  const TeacherWalletDetailsViewBodyBuilder({
    super.key,
    required this.wallet,
    required this.user,
    required this.colorScheme,
    required this.teacherId,
  });

  final TeacherWalletEntity wallet;
  final UserEntity user;
  final ColorScheme colorScheme;
  final String teacherId;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: KHorizontalPadding, vertical: KVerticalPadding),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: TeacherWalletDetailsSection(
                  wallet: wallet, user: user, colorScheme: colorScheme),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(child: TeachersTransactionsListViewHeader()),
            TeachersTransactionsListView(
              teacherId: teacherId,
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            )
          ],
        ));
  }
}
