import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class AboutUsTitle extends StatelessWidget {
  const AboutUsTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Text(
          LocaleKeys.profileAbout,
          style: AppTextStyles(context).semiBold24.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.2,
                color: isDark ? Colors.white : Colors.black,
              ),
        ),

        const SizedBox(height: 10),

        // ---------- MODERN ACCENT LINE ----------
        Container(
          height: 5,
          width: 95,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: const LinearGradient(
              colors: [
                Color(0xff7B61FF),
                Color(0xff5CE1E6),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
