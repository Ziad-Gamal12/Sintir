import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class AboutUSDescription extends StatelessWidget {
  const AboutUSDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isDark
            ? Colors.white.withOpacity(0.03)
            : Colors.black.withOpacity(0.02),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Text(
          LocaleKeys.aboutUsDescription,
          style: AppTextStyles(context).semiBold14.copyWith(
                fontSize: 17,
                height: 1.75,
                letterSpacing: 0.2,
                color: isDark
                    ? Colors.white.withOpacity(0.85)
                    : Colors.black.withOpacity(0.75),
              ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
