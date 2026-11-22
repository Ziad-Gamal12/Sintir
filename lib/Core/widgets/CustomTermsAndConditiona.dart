// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/Themes/brand_palette.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCheckBox.dart';
import 'package:sintir/locale_keys.dart';

class CustomTermsAndConditions extends StatelessWidget {
  const CustomTermsAndConditions({
    super.key,
    required this.textOnPressed,
    required this.onChanged,
  });

  final VoidCallback textOnPressed;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final palette = BrandPalette.of(context);
    final link = palette.link;
    final style = AppTextStyles(context).semiBold13;

    return Row(
      children: [
        Customcheckbox(onChanged: onChanged),
        const SizedBox(width: 12),
        Expanded(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: InkWell(
              onTap: textOnPressed,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: LocaleKeys.agreeTerms,
                        style: style.copyWith(color: palette.textMuted),
                      ),
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: LocaleKeys.termsConditions,
                        style: style.copyWith(
                          color: link,
                          decoration: TextDecoration.underline,
                          decorationColor: link,
                        ),
                      ),
                      const TextSpan(text: ' '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Icon(
                          Icons.open_in_new_rounded,
                          size: 16,
                          color: link,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
