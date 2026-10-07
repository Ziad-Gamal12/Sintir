import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/controllers/add_video_form_controller.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/utils/add_video_dimens.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/widgets/shared/required_label.dart';
import 'package:sintir/locale_keys.dart';

class VideoTitleInputField extends StatelessWidget {
  const VideoTitleInputField({
    super.key,
    required this.controller,
    required this.enabled,
  });

  final TextEditingController controller;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final colors = Theme.of(context).colorScheme;
    final styles = AppTextStyles(context);
    final mutedStyle =
        styles.regular12.copyWith(color: colors.onSurfaceVariant);
    final Color borderColor =
        isDarkMode ? Colors.white10 : const Color(0xFFE4E6E8);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: RequiredLabel(text: LocaleKeys.videoTitleLabel)),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller,
              builder: (_, value, __) => Text(
                '${value.text.length} / ${AddVideoFormController.maxTitleLength}',
                textDirection: TextDirection.ltr,
                style: mutedStyle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          enabled: enabled,
          maxLength: AddVideoFormController.maxTitleLength,
          textInputAction: TextInputAction.done,
          style: styles.regular14,
          validator: (value) => (value?.trim().isNotEmpty ?? false)
              ? null
              : LocaleKeys.videoTitleRequired,
          decoration: InputDecoration(
            counterText: '',
            hintText: LocaleKeys.videoTitleHint,
            hintStyle: styles.regular14.copyWith(
              color: colors.onSurfaceVariant.withValues(alpha: .7),
            ),
            suffixIcon: const Icon(Icons.edit_note),
            filled: true,
            fillColor: colors.surfaceContainerHighest.withValues(alpha: .45),
            contentPadding:
                const EdgeInsetsDirectional.fromSTEB(16, 14, 16, 14),
            border: _outline(borderColor),
            enabledBorder: _outline(borderColor),
            disabledBorder: _outline(borderColor),
            focusedBorder: _outline(colors.primary),
            errorBorder: _outline(colors.error),
            focusedErrorBorder: _outline(colors.error),
          ),
        ),
        const SizedBox(height: 4),
        Text(LocaleKeys.videoTitleHelper, style: mutedStyle),
      ],
    );
  }
}

OutlineInputBorder _outline(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(AddVideoDimens.radius),
      borderSide: BorderSide(color: color, width: 1.5),
    );
