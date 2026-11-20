import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sintir/Core/helper/ProfileCompleteness.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTitledTextField.dart';
import 'package:sintir/locale_keys.dart';

class CompleteProfilePhoneNumberField extends StatefulWidget {
  const CompleteProfilePhoneNumberField({
    super.key,
    required this.phoneController,
  });

  final TextEditingController phoneController;

  @override
  State<CompleteProfilePhoneNumberField> createState() =>
      _CompleteProfilePhoneNumberFieldState();
}

class _CompleteProfilePhoneNumberFieldState
    extends State<CompleteProfilePhoneNumberField> {
  static const _animDuration = Duration(milliseconds: 250);
  static const _validColor = Color(0xff10B981);
  static const _validTextColor = Color(0xff059669);

  late bool _isValid;

  @override
  void initState() {
    super.initState();
    _isValid = ProfileCompleteness.isValidPhone(
      widget.phoneController.text.trim(),
    );
    widget.phoneController.addListener(_onPhoneChanged);
  }

  void _onPhoneChanged() {
    final nextValid = ProfileCompleteness.isValidPhone(
      widget.phoneController.text.trim(),
    );
    if (nextValid == _isValid) return;

    if (nextValid) {
      HapticFeedback.lightImpact();
    }
    setState(() => _isValid = nextValid);
  }

  @override
  void dispose() {
    widget.phoneController.removeListener(_onPhoneChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyles(context);

    return Column(
      children: [
        CustomTitledTextField(
          title: LocaleKeys.phoneNumber,
          hintText: LocaleKeys.phoneNumber,
          obscureText: false,
          textInputType: TextInputType.phone,
          validator: (val) {
            final text = (val ?? '').trim();
            if (text.isEmpty) return LocaleKeys.phoneRequired;
            if (!ProfileCompleteness.isValidPhone(text)) {
              return LocaleKeys.phoneInvalid;
            }
            return null;
          },
          prefixIcon: Icons.phone_outlined,
          suffixIcon: AnimatedSwitcher(
            duration: _animDuration,
            switchInCurve: Curves.easeOutBack,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: animation,
              child: FadeTransition(opacity: animation, child: child),
            ),
            child: _isValid
                ? const Icon(
                    Icons.check_circle_rounded,
                    key: ValueKey('phone-valid-icon'),
                    color: _validColor,
                    size: 20,
                  )
                : const SizedBox.shrink(key: ValueKey('phone-empty-icon')),
          ),
          controller: widget.phoneController,
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  LocaleKeys.completeProfilePhoneHint,
                  style: styles.regular11,
                ),
              ),
            ),
            AnimatedSwitcher(
              duration: _animDuration,
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.3),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              ),
              child: _isValid
                  ? Row(
                      key: const ValueKey('phone-valid-badge'),
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check, color: _validColor, size: 16),
                        const SizedBox(width: 2),
                        Text(
                          "11/11",
                          style: styles.semiBold11.copyWith(
                            color: _validTextColor,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(key: ValueKey('phone-invalid-badge')),
            ),
          ],
        ),
      ],
    );
  }
}
