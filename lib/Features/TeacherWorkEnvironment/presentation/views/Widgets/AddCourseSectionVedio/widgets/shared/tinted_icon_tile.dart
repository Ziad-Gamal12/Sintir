import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/utils/add_video_dimens.dart';

class TintedIconTile extends StatelessWidget {
  const TintedIconTile({
    super.key,
    required this.icon,
    this.color,
    this.size = 48,
    this.iconSize = 24,
    this.isCircle = false,
  });

  final IconData icon;
  final Color? color;
  final double size;
  final double iconSize;
  final bool isCircle;

  @override
  Widget build(BuildContext context) {
    final accent = color ?? Theme.of(context).colorScheme.primary;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: accent.withValues(alpha: .13),
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius:
            isCircle ? null : BorderRadius.circular(AddVideoDimens.radius),
      ),
      child: Icon(icon, color: accent, size: iconSize),
    );
  }
}
