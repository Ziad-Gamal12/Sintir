import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sintir/Core/utils/PaymentStatusPalette.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/CourseCheckoutEntity.dart';
import 'package:sintir/locale_keys.dart';

class WebviewbodyPaymentSuccessWidget extends StatefulWidget {
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
  State<WebviewbodyPaymentSuccessWidget> createState() =>
      _WebviewbodyPaymentSuccessWidgetState();
}

class _WebviewbodyPaymentSuccessWidgetState
    extends State<WebviewbodyPaymentSuccessWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final success = PaymentStatusPalette.forTheme(theme);
    final normalizedCourseTitle = widget.courseTitle?.trim();
    final hasCourseTitle = normalizedCourseTitle?.isNotEmpty == true;
    final quote = widget.quote;
    final hasPaymentDetails = quote != null || hasCourseTitle;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

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
                      child: Semantics(
                        label: LocaleKeys.paymentConfirmedHeading,
                        child: ExcludeSemantics(
                          child: Container(
                            width: 164,
                            height: 164,
                            decoration: BoxDecoration(
                              color: success.successSurface,
                              shape: BoxShape.circle,
                            ),
                            child: reduceMotion
                                ? _SuccessMark(color: success.success)
                                : Lottie.asset(
                                    Assets.assetsLottieFilesSuccessanimation,
                                    key: const ValueKey(
                                      'payment_success_lottie',
                                    ),
                                    repeat: false,
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, _, _) =>
                                        _SuccessMark(color: success.success),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Semantics(
                      liveRegion: true,
                      child: Text(
                        LocaleKeys.paymentConfirmedHeading,
                        textAlign: TextAlign.center,
                        style: AppTextStyles(
                          context,
                        ).bold24.copyWith(color: colors.onSurface),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      LocaleKeys.paymentConfirmedMessage,
                      textAlign: TextAlign.center,
                      style: AppTextStyles(
                        context,
                      ).regular14.copyWith(color: colors.onSurfaceVariant),
                    ),
                    if (hasPaymentDetails) ...[
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: colors.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (hasCourseTitle)
                              Text(
                                normalizedCourseTitle!,
                                style: AppTextStyles(
                                  context,
                                ).semiBold16.copyWith(color: colors.onSurface),
                              ),
                            if (quote != null) ...[
                              if (hasCourseTitle) const SizedBox(height: 14),
                              _PaymentDetailRow(
                                label: LocaleKeys.paymentConfirmedAmount,
                                value: _formatMoney(context, quote.amountCents),
                                emphasis: true,
                              ),
                              if (quote.discountAmountCents > 0) ...[
                                const SizedBox(height: 8),
                                _PaymentDetailRow(
                                  label: LocaleKeys.originalPrice,
                                  value: _formatMoney(
                                    context,
                                    quote.originalAmountCents,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                _PaymentDetailRow(
                                  label: LocaleKeys.paymentDiscount,
                                  value: _formatMoney(
                                    context,
                                    quote.discountAmountCents,
                                  ),
                                ),
                              ],
                              if (quote.couponCode != null) ...[
                                const SizedBox(height: 8),
                                _PaymentDetailRow(
                                  label: LocaleKeys.coupon,
                                  value: quote.couponCode!,
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
                      onPressed: widget.onContinue,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: const Icon(
                        Icons.school_outlined,
                        color: Colors.white,
                      ),
                      label: Text(
                        LocaleKeys.returnToCourse,
                        style: AppTextStyles(
                          context,
                        ).semiBold16.copyWith(color: Colors.white),
                      ),
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

  String _formatMoney(BuildContext context, int amountCents) =>
      '${NumberFormat('#,##0.00', Localizations.localeOf(context).toString()).format(amountCents / 100)}\u00a0${widget.quote!.currency}';
}

class _SuccessMark extends StatelessWidget {
  const _SuccessMark({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) =>
      Icon(Icons.check_circle_rounded, size: 88, color: color);
}

class _PaymentDetailRow extends StatelessWidget {
  const _PaymentDetailRow({
    required this.label,
    required this.value,
    this.emphasis = false,
  });

  final String label;
  final String value;
  final bool emphasis;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTextStyles(
              context,
            ).regular13.copyWith(color: colors.onSurfaceVariant),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style:
                (emphasis
                        ? AppTextStyles(context).semiBold20
                        : AppTextStyles(context).semiBold14)
                    .copyWith(color: colors.onSurface),
          ),
        ),
      ],
    );
  }
}
