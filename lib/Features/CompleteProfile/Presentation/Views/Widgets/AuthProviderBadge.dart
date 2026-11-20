import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/CompleteProfile/Domain/Enums/SiginInMethod.dart';
import 'package:svg_flutter/svg_flutter.dart';

class AuthProviderBadge extends StatelessWidget {
  const AuthProviderBadge({super.key, required this.method});
  final SiginInMethod? method;

  @override
  Widget build(BuildContext context) {
    if (method == null) return const SizedBox.shrink();

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(
            color: isDarkMode
                ? const Color(0xff344158)
                : const Color(0xffE2E7F0),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(method!.svgIconPath, height: 16, width: 16),
            const SizedBox(width: 8),
            Text(
              method!.signedInWithText,
              style: AppTextStyles(context).semiBold12,
            ),
          ],
        ),
      ),
    );
  }
}
