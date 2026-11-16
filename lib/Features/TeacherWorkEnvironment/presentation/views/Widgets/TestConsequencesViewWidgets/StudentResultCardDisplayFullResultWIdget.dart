import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/ReviewTestResultView.dart';
import 'package:sintir/locale_keys.dart';

/// Restored public widget for displaying the tonal "View result" button.
/// Maintains full backward compatibility with both original constructor signatures
/// (accepting [testResultEntity]) and optional [onTap] callbacks.
class StudentResultCardDisplayFullResultWidget extends StatelessWidget {
  const StudentResultCardDisplayFullResultWidget({
    super.key,
    this.testResultEntity,
    this.onTap,
  });

  final TestResultEntity? testResultEntity;
  final VoidCallback? onTap;

  void _handleTap(BuildContext context) {
    if (onTap != null) {
      onTap!();
    } else if (testResultEntity != null) {
      GoRouter.of(
        context,
      ).push(Reviewtestresultview.routeName, extra: testResultEntity);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles(context);
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    final contentColor = theme.brightness == Brightness.dark
        ? Color.lerp(primary, Colors.white, .3)!
        : primary;

    final child = Container(
      constraints: const BoxConstraints(minHeight: 44),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.visibility_rounded, color: contentColor, size: 20),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              LocaleKeys.viewResult,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: style.semiBold14.copyWith(color: contentColor),
            ),
          ),
        ],
      ),
    );

    if (onTap != null || testResultEntity != null) {
      return InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _handleTap(context),
        child: child,
      );
    }

    return child;
  }
}

/// Backward compatibility alias for the original PascalCase/Capital-I file & class name
typedef StudentResultCardDisplayFullResultWIdget =
    StudentResultCardDisplayFullResultWidget;

/// Backward compatibility alias for the temporary refactored class name
typedef StudentResultCardAction = StudentResultCardDisplayFullResultWidget;
