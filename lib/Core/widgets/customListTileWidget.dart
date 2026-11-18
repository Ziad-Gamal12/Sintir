import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:svg_flutter/svg_flutter.dart';

class Customlisttilewidget extends StatelessWidget {
  const Customlisttilewidget({
    super.key,
    required this.title,
    this.subtitle,
    required this.image,
    this.trailing,
  });
  final String title, image;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final style = AppTextStyles(context);
    final titleColor = scheme.onSurface;
    final subtitleColor = scheme.onSurface.withValues(alpha: 0.6);

    return ListTile(
      minLeadingWidth: 24,
      titleAlignment: ListTileTitleAlignment.center,
      horizontalTitleGap: 10,
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: style.semiBold16.copyWith(color: titleColor),
      ),
      leading: SizedBox(
        width: 40,
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: SvgPicture.asset(
            image,
            color: titleColor,
            fit: BoxFit.fill,
            height: 30,
            width: 30,
          ),
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: style.regular13.copyWith(color: subtitleColor),
            )
          : null,
      trailing: trailing,
    );
  }
}
