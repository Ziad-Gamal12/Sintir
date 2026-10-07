import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/utils/video_file_limits.dart';
import 'package:sintir/locale_keys.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/widgets/shared/required_label.dart';

class VideoFileLabelRow extends StatelessWidget {
  const VideoFileLabelRow({super.key});

  @override
  Widget build(BuildContext context) {
    final mutedStyle = AppTextStyles(context)
        .regular12
        .copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: RequiredLabel(text: LocaleKeys.videoFileLabel)),
        const SizedBox(width: 8),
        // No forced text direction: mixed Arabic/Latin text must follow the
        // layout direction, otherwise the bidi order gets scrambled.
        Flexible(
          child: Text(
            LocaleKeys.videoConstraints(maxVideoSizeMegabytes.toString()),
            textAlign: TextAlign.end,
            style: mutedStyle,
          ),
        ),
      ],
    );
  }
}
