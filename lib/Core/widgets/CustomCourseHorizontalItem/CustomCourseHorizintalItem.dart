import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCourseHorizontalItem/CustomCourseHorizontalItemPosterUrl.dart';
import 'package:sintir/Core/widgets/CustomCourseHorizontalItem/CustomCourseHorizontalItemPrice.dart';
import 'package:sintir/locale_keys.dart';

class CustomCourseHorizontalItem extends StatefulWidget {
  const CustomCourseHorizontalItem({super.key, required this.course});
  final CourseEntity course;

  @override
  State<CustomCourseHorizontalItem> createState() =>
      _CustomCourseHorizontalItemState();
}

class _CustomCourseHorizontalItemState extends State<CustomCourseHorizontalItem>
    with SingleTickerProviderStateMixin {
  double scale = 1.0;

  void _onTapDown(_) => setState(() => scale = 0.97);
  void _onTapUp(_) => setState(() => scale = 1.0);

  String _postedAgo(DateTime date) {
    final diff = DateTime.now().difference(date);

    if (diff.inDays >= 30)
      return "${diff.inDays ~/ 30} ${LocaleKeys.postedMonth}";
    if (diff.inDays >= 1) return "${diff.inDays} ${LocaleKeys.postedDay}";
    if (diff.inHours >= 1) return "${diff.inHours} ${LocaleKeys.postedHour}";
    return "${diff.inMinutes} ${LocaleKeys.postedMinute}";
  }

  @override
  Widget build(BuildContext context) {
    final course = widget.course;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedScale(
      scale: scale,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(.4)
                  : Colors.grey.shade400.withOpacity(.25),
              blurRadius: 14,
              spreadRadius: 1,
              offset: const Offset(0, 5),
            ),
            BoxShadow(
              color:
                  isDark ? Colors.grey.shade800 : Colors.white.withOpacity(0.9),
              blurRadius: 8,
              offset: const Offset(-3, -3),
            ),
          ],
          border: Border.all(
              color: isDark ? Colors.grey.shade700 : Colors.grey.shade200),
        ),
        child: InkWell(
          onTapDown: _onTapDown,
          onTapCancel: () => setState(() => scale = 1.0),
          onTapUp: _onTapUp,
          borderRadius: BorderRadius.circular(18),
          child: Row(
            children: [
              // Course Image
              CustomCourseHorizontalItemPosterUrl(poster: course.posterUrl!),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      course.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles(context).semiBold16.copyWith(
                          height: 1.3, color: isDark ? Colors.white : null),
                    ),

                    const SizedBox(height: 6),

                    // Description
                    Text(
                      course.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles(context).regular14.copyWith(
                            color: isDark
                                ? Colors.grey.shade300
                                : Colors.grey.shade600,
                            height: 1.4,
                          ),
                    ),

                    const SizedBox(height: 6),

                    // Chips Row (level - subject - language)
                    Flexible(
                      child: SingleChildScrollView(
                        child: Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: [
                            _buildChip(
                                Icons.school_rounded, course.level, isDark),
                            _buildChip(Icons.menu_book_rounded, course.subject,
                                isDark),
                            _buildChip(Icons.language_rounded, course.language,
                                isDark),
                            _buildChip(
                              Icons.timer,
                              "${LocaleKeys.createdDate} ${_postedAgo(course.postedDate)}",
                              isDark,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 6),

                    // Price
                    CustomCourseHorizontalItemPrice(
                      price: course.price.toDouble(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(IconData icon, String text, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF3A3A3A) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              size: 15,
              color: isDark ? Colors.grey.shade300 : Colors.grey.shade700),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12.5,
              color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
