import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/CourseCheckoutEntity.dart';
import 'package:sintir/locale_keys.dart';

class WebviewbodyPaymentSuccessWidget extends StatelessWidget {
  const WebviewbodyPaymentSuccessWidget({
    super.key,
    required this.onContinue,
    this.courseTitle,
    this.quote,
  });

  final VoidCallback onContinue;
  final String? courseTitle;
  final CourseCheckoutQuote? quote;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final normalizedCourseTitle = courseTitle?.trim();

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 460),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: ExcludeSemantics(
                        child: Container(
                          width: 88,
                          height: 88,
                          decoration: BoxDecoration(
                            color: colors.primaryContainer,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check_rounded,
                            size: 48,
                            color: colors.onPrimaryContainer,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Semantics(
                      liveRegion: true,
                      child: Text(
                        LocaleKeys.paymentConfirmedHeading,
                        textAlign: TextAlign.center,
                        style: AppTextStyles(context).bold24.copyWith(
                              color: colors.onSurface,
                            ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      LocaleKeys.paymentConfirmedMessage,
                      textAlign: TextAlign.center,
                      style: AppTextStyles(context)
                          .regular14
                          .copyWith(color: colors.onSurfaceVariant),
                    ),
                    if (normalizedCourseTitle != null &&
                        normalizedCourseTitle.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: colors.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: colors.outlineVariant),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              normalizedCourseTitle,
                              style: AppTextStyles(context).semiBold16.copyWith(
                                    color: colors.onSurface,
                                  ),
                            ),
                            if (quote != null) ...[
                              const SizedBox(height: 14),
                              _PaymentDetailRow(
                                label: LocaleKeys.paymentConfirmedAmount,
                                value:
                                    _formatMoney(context, quote!.amountCents),
                              ),
                              if (quote!.discountAmountCents > 0) ...[
                                const SizedBox(height: 8),
                                _PaymentDetailRow(
                                  label: LocaleKeys.paymentDiscount,
                                  value: _formatMoney(
                                      context, quote!.discountAmountCents),
                                ),
                              ],
                              if (quote!.couponCode != null) ...[
                                const SizedBox(height: 8),
                                _PaymentDetailRow(
                                  label: LocaleKeys.coupon,
                                  value: quote!.couponCode!,
                                ),
                              ],
                            ],
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 28),
                    FilledButton.icon(
                      key: const Key('success_return_to_course'),
                      onPressed: onContinue,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                      ),
                      icon: const Icon(Icons.school_outlined),
                      label: Text(LocaleKeys.returnToCourse),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatMoney(BuildContext context, int amountCents) => '${NumberFormat(
        '#,##0.00',
        Localizations.localeOf(context).toString(),
      ).format(amountCents / 100)}\u00a0${quote!.currency}';
}

class _PaymentDetailRow extends StatelessWidget {
  const _PaymentDetailRow({required this.label, required this.value});

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
