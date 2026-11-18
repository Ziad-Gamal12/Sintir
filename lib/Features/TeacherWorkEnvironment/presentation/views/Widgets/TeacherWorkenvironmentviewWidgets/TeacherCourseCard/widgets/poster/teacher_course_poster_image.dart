import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseCard/widgets/poster/teacher_course_poster_placeholder.dart';

/// Course poster, decoded at the size it is actually painted.
class TeacherCoursePosterImage extends StatelessWidget {
  const TeacherCoursePosterImage({super.key, required this.posterUrl});

  final String? posterUrl;

  /// Decode widths are rounded up to this step so small layout changes
  /// (e.g. resizing a desktop window) reuse the same cached bitmap.
  static const int _cacheWidthStep = 100;

  @override
  Widget build(BuildContext context) {
    final url = posterUrl;
    if (url == null) {
      return const TeacherCoursePosterPlaceholder(icon: Icons.school_outlined);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          memCacheWidth: _cacheWidthFor(context, constraints.maxWidth),
          fadeInDuration: const Duration(milliseconds: 250),
          placeholder: (_, _) =>
              const TeacherCoursePosterPlaceholder(icon: Icons.image_outlined),
          errorWidget: (_, _, _) => const TeacherCoursePosterPlaceholder(
            icon: Icons.broken_image_outlined,
          ),
        );
      },
    );
  }

  int? _cacheWidthFor(BuildContext context, double logicalWidth) {
    if (!logicalWidth.isFinite || logicalWidth <= 0) return null;
    final physical = logicalWidth * MediaQuery.devicePixelRatioOf(context);
    return (physical / _cacheWidthStep).ceil() * _cacheWidthStep;
  }
}
