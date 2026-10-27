import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    final isResumable = attempt.checkoutUrl.isNotEmpty;
    final isPending = attempt.status.toLowerCase() == 'pending';
    final message = requestDiffers
        ? LocaleKeys.existingCheckoutCouponMismatch
        : isResumable
            ? LocaleKeys.existingCheckoutMessage
            : LocaleKeys.paymentVerifying;
    final amount = _formatMoney(context, attempt.quote.amountCents);
    final discount = _formatMoney(context, attempt.quote.discountAmountCents);
    final maxHeight = MediaQuery.sizeOf(context).height * .88;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      backgroundColor: colors.surface,
      surfaceTintColor: colors.surfaceTint,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 440, maxHeight: maxHeight),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExcludeSemantics(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: colors.primaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: SizedBox.square(
                        dimension: 48,
                        child: Icon(
                          isPending
                              ? Icons.schedule_rounded
                              : Icons.sync_rounded,
                          color: colors.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: colors.primaryContainer,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    isPending
                        ? LocaleKeys.paymentPending
                        : LocaleKeys.paymentVerificationInProgress,
                    style: AppTextStyles(context).semiBold12.copyWith(
                          color: colors.onPrimaryContainer,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                message,
                style: AppTextStyles(context)
                    .regular14
                    .copyWith(color: colors.onSurfaceVariant),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors.outlineVariant),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      courseTitle,
                      style: AppTextStyles(context).semiBold16.copyWith(
                            color: colors.onSurface,
                          ),
                    ),
                    const SizedBox(height: 12),
                    _CheckoutInfoRow(
                      label: LocaleKeys.originalCheckoutAmount,
                      value: amount,
                    ),
                    if (requestDiffers || attempt.quote.couponCode != null) ...[
                      const SizedBox(height: 8),
                      _CheckoutInfoRow(
                        label: LocaleKeys.originalCheckoutCoupon,
                        value: attempt.quote.couponCode ??
                            LocaleKeys.noCouponApplied,
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
              const SizedBox(height: 20),
              if (isResumable) ...[
                FilledButton.icon(
                  key: const Key('checkout_resume_payment'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
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
                    minimumSize: const Size.fromHeight(52),
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
                ),
                onPressed: () => Navigator.of(context)
                    .pop(ExistingCheckoutAction.checkLater),
                child: Text(LocaleKeys.checkLater),
              ),
            ],
          ),
        ),
      ),
    );
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
