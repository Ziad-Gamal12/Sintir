import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/course_checkout_cubit/course_checkout_cubit.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class CheckoutBottomBar extends StatelessWidget {
  const CheckoutBottomBar({
    super.key,
    required this.totalText,
    required this.isQuoting,
    required this.onPressed,
    this.originalText,
  });

  final String totalText;
  final String? originalText;
  final bool isQuoting;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyles(context);
    final muted = CourseCardMetrics.mutedColor(context);
    final label = context.select<CourseCheckoutCubit, String>((cubit) {
      final state = cubit.state;
      if (state is CourseCheckoutRecoveryRequired) {
        return LocaleKeys.retryCheckout;
      }
      if (state is CourseCheckoutReviewRequired) {
        return LocaleKeys.checkPaymentStatus;
      }
      return LocaleKeys.subscribeNow;
    });
    final isBusy = context.select<CourseCheckoutCubit, bool>(
      (cubit) => cubit.state is CourseCheckoutLoading,
    );
    final showSpinner = isBusy && !isQuoting;
    final original = originalText;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: CourseCardMetrics.surfaceColor(context),
        border: Border(
          top: BorderSide(color: CourseCardMetrics.borderColor(context)),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        LocaleKeys.checkoutTotal,
                        style: styles.regular12.copyWith(color: muted),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            totalText,
                            key: const ValueKey('checkout-total'),
                            style: styles.bold20.copyWith(
                              color: CourseCardMetrics.textColor(context),
                            ),
                          ),
                          if (original != null) ...[
                            const SizedBox(width: 6),
                            Text(
                              original,
                              key: const ValueKey('checkout-original-total'),
                              style: styles.regular13.copyWith(
                                color: muted,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: muted,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: FilledButton(
                        key: const ValueKey('checkout-subscribe-button'),
                        onPressed: isBusy ? null : onPressed,
                        style: FilledButton.styleFrom(
                          backgroundColor: KMainColor,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: KMainColor.withValues(
                            alpha: .6,
                          ),
                          disabledForegroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: showSpinner
                            ? const SizedBox.square(
                                dimension: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                label,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: styles.bold16,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock_outline_rounded, size: 14, color: muted),
                  const SizedBox(width: 6),
                  Text(
                    LocaleKeys.securePaymentPaymob,
                    style: styles.regular12.copyWith(color: muted),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
