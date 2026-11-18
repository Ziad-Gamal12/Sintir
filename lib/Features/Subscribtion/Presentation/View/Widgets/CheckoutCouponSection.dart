import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class CheckoutCouponSection extends StatefulWidget {
  const CheckoutCouponSection({
    super.key,
    required this.appliedCode,
    required this.discountPercent,
    required this.isApplying,
    required this.errorText,
    required this.onApply,
    required this.onRemove,
  });

  final String? appliedCode;
  final double discountPercent;
  final bool isApplying;
  final String? errorText;
  final ValueChanged<String> onApply;
  final VoidCallback onRemove;

  static String percentText(double percent) =>
      percent == percent.roundToDouble()
          ? percent.toStringAsFixed(0)
          : percent.toStringAsFixed(1);

  @override
  State<CheckoutCouponSection> createState() => _CheckoutCouponSectionState();
}

class _CheckoutCouponSectionState extends State<CheckoutCouponSection> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _expanded = false;
  String? _localError;

  @override
  void didUpdateWidget(covariant CheckoutCouponSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    final code = widget.appliedCode;
    if (code != null &&
        code != oldWidget.appliedCode &&
        code != _controller.text) {
      _controller.text = code;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _expand() {
    setState(() => _expanded = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNode.requestFocus();
    });
  }

  void _submit() {
    final code = _controller.text.trim();
    if (code.isEmpty) {
      setState(() => _localError = LocaleKeys.fieldCannotBeEmpty);
      return;
    }
    setState(() => _localError = null);
    _focusNode.unfocus();
    widget.onApply(code);
  }

  void _remove() {
    _controller.clear();
    setState(() => _localError = null);
    widget.onRemove();
  }

  @override
  Widget build(BuildContext context) {
    final applied = widget.appliedCode != null;
    if (!_expanded && !applied) {
      return SizedBox(
        width: double.infinity,
        child: TextButton.icon(
          key: const ValueKey('checkout-add-coupon'),
          onPressed: _expand,
          icon: const Icon(Icons.confirmation_number_outlined, size: 20),
          label: Text(
            LocaleKeys.addDiscountCoupon,
            style: AppTextStyles(context).semiBold14,
          ),
          style: TextButton.styleFrom(
            foregroundColor: CourseCardMetrics.accentColor(context),
            alignment: AlignmentDirectional.centerStart,
            minimumSize: const Size.fromHeight(44),
            padding: const EdgeInsets.symmetric(horizontal: 4),
          ),
        ),
      );
    }

    final success = CourseCardMetrics.freeColor(context);
    final textColor = CourseCardMetrics.textColor(context);
    final radius = BorderRadius.circular(12);
    final idleBorder = OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(
        color: applied ? success : CourseCardMetrics.borderColor(context),
      ),
    );
    final message = applied
        ? LocaleKeys.couponDiscountApplied(
            CheckoutCouponSection.percentText(widget.discountPercent),
          )
        : _localError ?? widget.errorText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.couponDiscount,
          style: AppTextStyles(context).semiBold14.copyWith(color: textColor),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                key: const ValueKey('checkout-coupon-field'),
                controller: _controller,
                focusNode: _focusNode,
                readOnly: applied || widget.isApplying,
                textCapitalization: TextCapitalization.characters,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _submit(),
                style: AppTextStyles(context).bold14.copyWith(color: textColor),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: LocaleKeys.enterCouponCode,
                  prefixIcon: Icon(
                    applied
                        ? Icons.check_circle_rounded
                        : Icons.confirmation_number_outlined,
                    size: 20,
                    color: applied
                        ? success
                        : CourseCardMetrics.mutedColor(context),
                  ),
                  filled: true,
                  fillColor: CourseCardMetrics.placeholderColor(context),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                  border: idleBorder,
                  enabledBorder: idleBorder,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: radius,
                    borderSide: BorderSide(
                      color: applied ? success : KMainColor,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 48,
              child: applied
                  ? OutlinedButton(
                      key: const ValueKey('checkout-remove-coupon'),
                      onPressed: _remove,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: textColor,
                        shape: RoundedRectangleBorder(borderRadius: radius),
                      ),
                      child: Text(LocaleKeys.removeCoupon),
                    )
                  : FilledButton(
                      key: const ValueKey('checkout-apply-coupon'),
                      onPressed: widget.isApplying ? null : _submit,
                      style: FilledButton.styleFrom(
                        backgroundColor: KMainColor,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: KMainColor.withValues(
                          alpha: .6,
                        ),
                        shape: RoundedRectangleBorder(borderRadius: radius),
                      ),
                      child: widget.isApplying
                          ? const SizedBox.square(
                              dimension: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(LocaleKeys.applyCoupon),
                    ),
            ),
          ],
        ),
        if (message != null) ...[
          const SizedBox(height: 6),
          Text(
            message,
            key: ValueKey(
              applied ? 'checkout-coupon-success' : 'checkout-coupon-error',
            ),
            style: AppTextStyles(context).semiBold13.copyWith(
              color: applied ? success : Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ],
    );
  }
}
