// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseFeedbackReplyEntity.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

typedef ReplySubmit = Future<String?> Function(String text);

class ReviewReplySheet extends StatefulWidget {
  const ReviewReplySheet({
    super.key,
    required this.onSubmit,
    this.initialText = '',
  });

  final ReplySubmit onSubmit;
  final String initialText;

  static Future<bool> show(
    BuildContext context, {
    required ReplySubmit onSubmit,
    String initialText = '',
  }) async {
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) =>
          ReviewReplySheet(onSubmit: onSubmit, initialText: initialText),
    );
    return saved ?? false;
  }

  @override
  State<ReviewReplySheet> createState() => _ReviewReplySheetState();
}

class _ReviewReplySheetState extends State<ReviewReplySheet> {
  late final TextEditingController controller = TextEditingController(
    text: widget.initialText,
  );
  bool saving = false;
  String? error;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() {
      saving = true;
      error = null;
    });
    final failure = await widget.onSubmit(controller.text);
    if (!mounted) return;
    if (failure == null) {
      Navigator.of(context).pop(true);
      return;
    }
    setState(() {
      saving = false;
      error = failure;
    });
  }

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyles(context);
    final editing = widget.initialText.isNotEmpty;
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            editing ? LocaleKeys.reviewReplyEditTitle : LocaleKeys.reviewReplyTitle,
            style: styles.bold16,
          ),
          const SizedBox(height: 6),
          Text(
            LocaleKeys.reviewReplyHint,
            style: styles.regular13.copyWith(
              color: Theme.of(context).textTheme.bodySmall?.color,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, _) {
              final empty = value.text.trim().isEmpty;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    key: const ValueKey('review-reply-field'),
                    controller: controller,
                    autofocus: true,
                    enabled: !saving,
                    minLines: 3,
                    maxLines: 6,
                    maxLength: CourseFeedbackReplyEntity.maxLength,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      hintText: LocaleKeys.reviewReplyPlaceholder,
                      errorText: error,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  FilledButton(
                    key: const ValueKey('review-reply-save'),
                    style: FilledButton.styleFrom(
                      backgroundColor: KMainColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: empty || saving ? null : _save,
                    child: saving
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            LocaleKeys.reviewReplyPublish,
                            style: styles.semiBold14.copyWith(
                              color: Colors.white,
                            ),
                          ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
