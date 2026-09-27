import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CourseDetailPoster extends StatelessWidget {
  const CourseDetailPoster({super.key, required this.course});
  final CourseEntity course;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = AppTextStyles(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: AspectRatio(
          aspectRatio: 16 / 8.2,
          child: Stack(fit: StackFit.expand, children: [
            if (course.posterUrl != null && course.posterUrl!.isNotEmpty)
              Image.network(course.posterUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _placeholder(theme))
            else
              _placeholder(theme),
            const DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Color(0xCC000000)]))),
            Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: .9),
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.circle,
                          size: 8, color: Colors.greenAccent),
                      const SizedBox(width: 6),
                      Text(_localizedState(context),
                          style:
                              textStyles.bold12.copyWith(color: Colors.white))
                    ],
                  ),
                )),
            Positioned(
                left: 14,
                right: 14,
                bottom: 12,
                child: Row(children: [
                  _InfoPill(
                      icon: Icons.groups_2_outlined,
                      text: '${course.studentsCount} ${LocaleKeys.students}'),
                  const Spacer(),
                  _InfoPill(
                      icon: Icons.payments_outlined,
                      text: '${course.price} ${LocaleKeys.currencyEgpSymbol}'),
                ])),
          ])),
    );
  }

  String _localizedState(BuildContext context) {
    return switch (course.state) {
      'Published' => LocaleKeys.courseStatePublished,
      'Pending' => LocaleKeys.courseStatePending,
      'DeletedByTeacher' => LocaleKeys.courseStateArchived,
      _ => course.state,
    };
  }

  Widget _placeholder(ThemeData theme) => ColoredBox(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Center(
          child: Icon(Icons.menu_book_rounded,
              size: 56, color: theme.colorScheme.primary)));
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withValues(alpha: .9),
            borderRadius: BorderRadius.circular(24)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 16, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 5),
          Text(text,
              style: AppTextStyles(context)
                  .semiBold12
                  .copyWith(color: Theme.of(context).colorScheme.onSurface))
        ]),
      );
}
