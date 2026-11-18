// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentTheme.dart';

class TeacherWorkspaceSurface extends StatelessWidget {
  const TeacherWorkspaceSurface({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  static const double radius = 16;

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final tokens = WorkEnvironmentThemeExtension.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: tokens.cardBackground,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: tokens.cardBorder),
        boxShadow: [
          BoxShadow(
            color: tokens.cardShadow,
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}
