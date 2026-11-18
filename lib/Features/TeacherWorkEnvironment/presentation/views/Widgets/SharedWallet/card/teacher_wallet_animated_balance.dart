import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeacherCourseStatus.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeachespaceEnvironmentTheme.dart';

/// Balance + currency. The first frame shows the real value; later live
/// updates count from the old balance to the new one so the change is
/// noticeable. Animation is skipped when the OS asks for reduced motion.
class TeacherWalletAnimatedBalance extends StatelessWidget {
  const TeacherWalletAnimatedBalance({
    super.key,
    required this.balance,
    required this.currencySymbol,
  });

  final double balance;
  final String currencySymbol;

  static const Duration _duration = Duration(milliseconds: 650);

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final tokens = WorkEnvironmentThemeExtension.of(context);
    final textStyles = AppTextStyles(context);
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    final amountStyle = textStyles.bold24.copyWith(
      color: onSurface,
      letterSpacing: 0.2,
      // Equal-width digits keep the number from jittering while counting.
      fontFeatures: const [FontFeature.tabularFigures()],
    );
    final currencyStyle = textStyles.semiBold12.copyWith(
      color: tokens.mutedText,
    );

    return TweenAnimationBuilder<double>(
      // `begin` is left null: the first build starts at [balance], and each
      // later change animates from the value currently on screen.
      tween: Tween<double>(end: balance),
      duration: reduceMotion ? Duration.zero : _duration,
      curve: Curves.easeOutCubic,
      builder: (context, value, _) => Text.rich(
        TextSpan(
          text: TeacherWorkEnvironmentFormatters.formatAmount(value),
          style: amountStyle,
          children: [TextSpan(text: ' $currencySymbol', style: currencyStyle)],
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
