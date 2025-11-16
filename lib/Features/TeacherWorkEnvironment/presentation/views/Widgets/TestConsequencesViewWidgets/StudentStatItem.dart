import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentStatItemIcon.dart';

class StudentStatItem extends StatelessWidget {
  const StudentStatItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.backgroundColor,
  });

  final String icon;
  final String title;
  final String value;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            backgroundColor.withOpacity(0.85),
            Colors.white.withOpacity(0.4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(0.35),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 0.8,
        ),
      ),
      child: Row(
        children: [
          StudentStatItemIcon(icon: icon),
          const SizedBox(width: 10),

          // Text details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: style.regular11.copyWith(
                    color: Colors.grey.shade600,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: style.semiBold16.copyWith(
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 350.ms)
        .moveY(begin: 10, curve: Curves.easeOut);
  }
}
