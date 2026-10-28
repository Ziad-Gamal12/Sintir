import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sintir/Core/utils/PaymentStatusPalette.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/CourseCheckoutEntity.dart';
import 'package:sintir/locale_keys.dart';

enum ExistingCheckoutAction { checkLater, checkStatus, resumePayment }

class ExistingCheckoutDialog extends StatelessWidget {
  const ExistingCheckoutDialog({
    super.key,
    required this.courseTitle,
    required this.attempt,
    required this.requestDiffers,
  });

  final String courseTitle;
  final CoursePaymentAttempt attempt;
  final bool requestDiffers;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final status = _statusPresentation(theme, attempt.status);
    final isResumable = attempt.canResume && attempt.checkoutUrl.isNotEmpty;
    final amount = _formatMoney(context, attempt.quote.amountCents);
    final discount = _formatMoney(context, attempt.quote.discountAmountCents);
    final maxHeight = MediaQuery.sizeOf(context).height * .88;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      backgroundColor: colors.surface,
      surfaceTintColor: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 440, maxHeight: maxHeight),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ExcludeSemantics(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: status.surface,
                              shape: BoxShape.circle,
                            ),
                            child: SizedBox.square(
                              dimension: 44,
                              child:
                                  Icon(status.icon, color: status.foreground),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              LocaleKeys.existingCheckoutTitle,
                              style: AppTextStyles(context).semiBold20.copyWith(
                                    color: colors.onSurface,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: status.surface,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          status.label,
                          style: AppTextStyles(context).semiBold12.copyWith(
                                color: status.foreground,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      status.message,
                      style: AppTextStyles(context)
                          .regular14
                          .copyWith(color: colors.onSurfaceVariant),
                    ),
                    if (requestDiffers) ...[
                      const SizedBox(height: 8),
                      Text(
                        LocaleKeys.existingCheckoutCouponMismatch,
                        style: AppTextStyles(context)
                            .regular13
                            .copyWith(color: colors.onSurfaceVariant),
                      ),
                    ],
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
                      decoration: BoxDecoration(
                        color: colors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            courseTitle,
                            style: AppTextStyles(context).semiBold16.copyWith(
                                  color: colors.onSurface,
                                ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            LocaleKeys.originalCheckoutAmount,
                            style: AppTextStyles(context)
                                .regular12
                                .copyWith(color: colors.onSurfaceVariant),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            amount,
                            style: AppTextStyles(context).semiBold20.copyWith(
                                  color: colors.onSurface,
                                ),
                          ),
                          if (attempt.quote.discountAmountCents > 0) ...[
                            const SizedBox(height: 8),
                            _CheckoutInfoRow(
                              label: LocaleKeys.originalPrice,
                              value: _formatMoney(
                                  context, attempt.quote.originalAmountCents),
                            ),
                          ],
                          if (attempt.quote.couponCode != null) ...[
                            const SizedBox(height: 12),
                            _CheckoutInfoRow(
                              label: LocaleKeys.originalCheckoutCoupon,
                              value: attempt.quote.couponCode!,
                            ),
                          ],
                          if (attempt.quote.discountAmountCents > 0) ...[
                            const SizedBox(height: 8),
                            _CheckoutInfoRow(
                              label: LocaleKeys.paymentDiscount,
                              value: discount,
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      LocaleKeys.existingCheckoutLaterMessage,
                      style: AppTextStyles(context)
                          .regular12
                          .copyWith(color: colors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ),
            Divider(height: 1, color: colors.outlineVariant),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isResumable) ...[
                    FilledButton.icon(
                      key: const Key('checkout_resume_payment'),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      onPressed: () => Navigator.of(context)
                          .pop(ExistingCheckoutAction.resumePayment),
                      icon: const Icon(Icons.open_in_new_rounded),
                      label: Text(LocaleKeys.resumeCheckout),
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      key: const Key('checkout_check_status'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      onPressed: () => Navigator.of(context)
                          .pop(ExistingCheckoutAction.checkStatus),
                      icon: const Icon(Icons.fact_check_outlined),
                      label: Text(LocaleKeys.checkPaymentStatus),
                    ),
                  ] else
                    FilledButton.icon(
                      key: const Key('checkout_check_status'),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      onPressed: () => Navigator.of(context)
                          .pop(ExistingCheckoutAction.checkStatus),
                      icon: const Icon(Icons.fact_check_outlined),
                      label: Text(LocaleKeys.checkPaymentStatus),
                    ),
                  const SizedBox(height: 4),
                  TextButton(
                    key: const Key('checkout_check_later'),
                    style: TextButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () => Navigator.of(context)
                        .pop(ExistingCheckoutAction.checkLater),
                    child: Text(LocaleKeys.checkLater),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _CheckoutStatusPresentation _statusPresentation(
      ThemeData theme, String rawStatus) {
    final palette = PaymentStatusPalette.forTheme(theme);
    return switch (rawStatus.toLowerCase()) {
      'pending' => _CheckoutStatusPresentation(
          label: LocaleKeys.paymentPending,
          message: LocaleKeys.existingCheckoutMessage,
          icon: Icons.schedule_rounded,
          foreground: palette.pending,
          surface: palette.pendingSurface,
        ),
      'verification_required' => _CheckoutStatusPresentation(
          label: LocaleKeys.paymentVerificationInProgress,
          message: LocaleKeys.paymentVerifying,
          icon: Icons.sync_rounded,
          foreground: palette.information,
          surface: palette.informationSurface,
        ),
      'succeeded' => _CheckoutStatusPresentation(
          label: LocaleKeys.paymentConfirmedHeading,
          message: LocaleKeys.paymentConfirmedMessage,
          icon: Icons.check_rounded,
          foreground: palette.success,
          surface: palette.successSurface,
        ),
      'failed' => _CheckoutStatusPresentation(
          label: LocaleKeys.paymentNotCompleted,
          message: LocaleKeys.paymentNotCompleted,
          icon: Icons.error_outline_rounded,
          foreground: palette.failure,
          surface: palette.failureSurface,
        ),
      'expired' => _CheckoutStatusPresentation(
          label: LocaleKeys.checkoutExpired,
          message: LocaleKeys.checkoutExpired,
          icon: Icons.timer_off_outlined,
          foreground: palette.failure,
          surface: palette.failureSurface,
        ),
      'paid_requires_review' => _CheckoutStatusPresentation(
          label: LocaleKeys.paymentRequiresReview,
          message: LocaleKeys.paymentRequiresReview,
          icon: Icons.support_agent_rounded,
          foreground: palette.pending,
          surface: palette.pendingSurface,
        ),
      _ => _CheckoutStatusPresentation(
          label: LocaleKeys.paymentStatusUnavailable,
          message: LocaleKeys.paymentStatusUnavailable,
          icon: Icons.sync_rounded,
          foreground: palette.information,
          surface: palette.informationSurface,
        ),
    };
  }

  String _formatMoney(BuildContext context, int amountCents) {
    final quote = attempt.quote;
    final amount = NumberFormat(
      '#,##0.00',
      Localizations.localeOf(context).toString(),
    ).format(amountCents / 100);
    return '$amount\u00a0${quote.currency}';
  }
}

class _CheckoutStatusPresentation {
  const _CheckoutStatusPresentation({
    required this.label,
    required this.message,
    required this.icon,
    required this.foreground,
    required this.surface,
  });

  final String label;
  final String message;
  final IconData icon;
  final Color foreground;
  final Color surface;
}

class _CheckoutInfoRow extends StatelessWidget {
  const _CheckoutInfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTextStyles(context)
                .regular13
                .copyWith(color: colors.onSurfaceVariant),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: AppTextStyles(context).semiBold14.copyWith(
                  color: colors.onSurface,
                ),
          ),
        ),
      ],
    );
  }
}
