import 'package:flutter/material.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';

class ReportSheetActionsTheme extends StatelessWidget {
  const ReportSheetActionsTheme(
      {super.key, required this.status, required this.child});
  final ReportStatus status;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final shape =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));
    const minimumSize = Size.fromHeight(56);
    final label = (theme.textTheme.labelLarge ?? const TextStyle())
        .copyWith(fontSize: 15, fontWeight: FontWeight.w700);

    final onPrimary =
        ThemeData.estimateBrightnessForColor(scheme.primary) == Brightness.dark
            ? Colors.white
            : Colors.black;

    final isOpen = status == ReportStatus.open;
    final outlinedColor = isOpen ? scheme.error : scheme.onSurface;
    final outlinedBorder = isOpen
        ? scheme.error.withValues(alpha: .55)
        : scheme.onSurface.withValues(alpha: .24);

    return Theme(
      data: theme.copyWith(
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            minimumSize: minimumSize,
            shape: shape,
            backgroundColor: scheme.primary,
            foregroundColor: onPrimary,
            textStyle: label,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            minimumSize: minimumSize,
            shape: shape,
            foregroundColor: outlinedColor,
            side: BorderSide(color: outlinedBorder),
            textStyle: label,
          ),
        ),
      ),
      child: child,
    );
  }
}
