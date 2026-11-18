import 'package:flutter/material.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletStatus.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/card/teacher_wallet_icon_box.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/card/teacher_wallet_status_pill.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/card/teacher_wallet_title_block.dart';

/// Icon, title and status pill. With large text the pill moves under the
/// title; otherwise it sits at the end, capped so long labels ellipsize
/// instead of squeezing the title or overflowing.
class TeacherWalletCardHeader extends StatelessWidget {
  const TeacherWalletCardHeader({
    super.key,
    required this.status,
    required this.isLargeText,
  });

  final TeacherWalletStatus status;
  final bool isLargeText;

  static const double _maxPillShare = 0.45;

  @override
  Widget build(BuildContext context) {
    final pill = TeacherWalletStatusPill(status: status);

    if (isLargeText) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              TeacherWalletIconBox(),
              SizedBox(width: 12),
              Expanded(child: TeacherWalletTitleBlock()),
            ],
          ),
          const SizedBox(height: 8),
          pill,
        ],
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) => Row(
        children: [
          const TeacherWalletIconBox(),
          const SizedBox(width: 12),
          const Expanded(child: TeacherWalletTitleBlock()),
          const SizedBox(width: 8),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: constraints.maxWidth * _maxPillShare,
            ),
            child: pill,
          ),
        ],
      ),
    );
  }
}
