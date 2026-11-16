import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/VideoNoteEntity.dart';

class CustomVideoNote extends StatelessWidget {
  const CustomVideoNote({super.key, required this.note});
  final VideoNoteEntity note;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final styles = AppTextStyles(context);
    final locale = Localizations.localeOf(context).toString();
    final user = note.user;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.alphaBlend(
          scheme.onSurface.withValues(alpha: 0.04),
          scheme.surface,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.onSurface.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox.square(
                dimension: 40,
                child: ClipOval(
                  child: CustomCachedNetworkImage(imageUrl: user.profilePicurl),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${user.firstName} ${user.lastName}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: styles.semiBold16,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      DateFormat.yMMMd(locale).add_jm().format(note.dateTime),
                      style: styles.regular13.copyWith(
                        color: scheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsetsDirectional.only(start: 12),
            decoration: BoxDecoration(
              border: BorderDirectional(
                start: BorderSide(color: scheme.primary, width: 3),
              ),
            ),
            child: Text(
              note.note,
              style: styles.regular14.copyWith(
                height: 1.6,
                color: scheme.onSurface.withValues(alpha: 0.87),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
