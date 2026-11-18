import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletStatus.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/utils/teacher_wallet_status_style.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentTheme.dart';

/// Status chip driven by the wallet's real status (active / suspended /
/// inactive), colored green / amber / red.
class TeacherWalletStatusPill extends StatelessWidget {
  const TeacherWalletStatusPill({super.key, required this.status});

  final TeacherWalletStatus status;

  @override
  Widget build(BuildContext context) {
    final tokens = WorkEnvironmentThemeExtension.of(context);
    final foreground = status.foreground(tokens);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: status.background(tokens),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: status.border(tokens)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              status.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles(
                context,
              ).semiBold11.copyWith(color: foreground),
            ),
          ),
          const SizedBox(width: 6),
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: foreground,
            ),
            child: const SizedBox.square(dimension: 6),
          ),
        ],
      ),
    );
  }
}
