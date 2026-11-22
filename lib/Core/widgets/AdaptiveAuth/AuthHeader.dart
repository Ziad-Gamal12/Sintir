// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';
import 'package:svg_flutter/svg.dart';

/// Illustration + headline + subtitle shown above an auth form.
/// The headline inherits [TextAlign] from here, so build it without its own
/// `textAlign` (see [SintirWelcomeTitle]).
class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    this.illustration,
    this.illustrationMaxHeight = 180,
    this.headline,
    this.subtitle,
    this.centered = true,
  });

  final String? illustration;
  final double illustrationMaxHeight;
  final Widget? headline;
  final String? subtitle;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final align = centered ? TextAlign.center : TextAlign.start;

    return Column(
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        if (illustration != null) ...[
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: illustrationMaxHeight),
            child: SvgPicture.asset(illustration!, fit: BoxFit.contain),
          ),
          const SizedBox(height: 20),
        ],
        if (headline != null)
          DefaultTextStyle.merge(textAlign: align, child: headline!),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            textAlign: align,
            style: AppTextStyles(context).regular16,
          ),
        ],
      ],
    );
  }
}

/// "Welcome back to Sintir" title used by both sign-in screens.
class SintirWelcomeTitle extends StatelessWidget {
  const SintirWelcomeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles(context).semiBold24;
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: LocaleKeys.welcomeBack, style: style),
          // Leading space: the old trailing space ended up on the wrong side in RTL.
          TextSpan(text: ' Sintir', style: style.copyWith(color: KMainColor)),
        ],
      ),
    );
  }
}

/// Small pill naming the account type ("طالب" / "معلم") above the form.
class AuthRoleBadge extends StatelessWidget {
  const AuthRoleBadge({super.key, required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: KMainColor.withValues(alpha: .10),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 6,
        children: [
          Icon(icon, size: 16, color: KMainColor),
          Text(
            label,
            style: AppTextStyles(context).bold13.copyWith(color: KMainColor),
          ),
        ],
      ),
    );
  }
}
