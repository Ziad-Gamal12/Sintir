import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCourseHorizontalItem/CustomCourseHorizontalItemPosterUrl.dart';
import 'package:sintir/Core/widgets/CustomCourseHorizontalItem/CustomCourseHorizontalItemPrice.dart';

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

    if (diff.inDays >= 30) return "${diff.inDays ~/ 30} شهر";
    if (diff.inDays >= 1) return "${diff.inDays} يوم";
    if (diff.inHours >= 1) return "${diff.inHours} ساعة";
    return "${diff.inMinutes} دقيقة";
  }

  @override
  Widget build(BuildContext context) {
    final course = widget.course;

    return AnimatedScale(
      scale: scale,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400.withOpacity(.25),
              blurRadius: 14,
              spreadRadius: 1,
              offset: const Offset(0, 5),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.9),
              blurRadius: 8,
              offset: const Offset(-3, -3),
            ),
          ],
          border: Border.all(color: Colors.grey.shade200),
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
                      style: AppTextStyles(context)
                          .semiBold16
                          .copyWith(height: 1.3),
                    ),

                    const SizedBox(height: 6),

                    // Description
                    Text(
                      course.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles(context)
                          .regular14
                          .copyWith(color: Colors.grey.shade600, height: 1.4),
                    ),

                    const SizedBox(height: 6),

                    // Chips Row (level - subject - language)
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        _buildChip(Icons.school_rounded, course.level),
                        _buildChip(Icons.menu_book_rounded, course.subject),
                        _buildChip(Icons.language_rounded, course.language),
                        _buildChip(
                            Icons.timer, "منذ ${_postedAgo(course.postedDate)}")
                      ],
                    ),

                    const Spacer(),

                    // Price
                    CustomCourseHorizontalItemPrice(
                        price: course.price.toDouble())
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: Colors.grey.shade700),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(fontSize: 12.5, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}
