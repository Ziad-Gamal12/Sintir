// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentTheme.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeacherWorkspaceSurface.dart';

class TeacherWorkspaceKpiTile extends StatelessWidget {
  const TeacherWorkspaceKpiTile({
    super.key,
    required this.label,
    required this.value,
    required this.caption,
    this.leading,
  });

  final String label;
  final String value;
  final Widget caption;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyles(context);
    final tokens = WorkEnvironmentThemeExtension.of(context);
    final leading = this.leading;
    return TeacherWorkspaceSurface(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: styles.regular13.copyWith(color: tokens.mutedText),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              if (leading != null) ...[leading, const SizedBox(width: 4)],
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    value,
                    maxLines: 1,
                    style: styles.bold24.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          caption,
        ],
      ),
    );
  }
}

class TeacherWorkspaceKpiCaption extends StatelessWidget {
  const TeacherWorkspaceKpiCaption({
    super.key,
    required this.text,
    this.icon,
    this.color,
  });

  final String text;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final color =
        this.color ?? WorkEnvironmentThemeExtension.of(context).mutedText;
    final icon = this.icon;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null) ...[
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 4),
        ],
        Expanded(
          child: Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles(context).regular12.copyWith(color: color),
          ),
        ),
      ],
    );
  }
}
