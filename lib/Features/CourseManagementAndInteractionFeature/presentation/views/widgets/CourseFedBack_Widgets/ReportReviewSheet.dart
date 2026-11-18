// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/repos/ReviewModerationRepo/ReviewModerationRepo.dart';
import 'package:sintir/Core/repos/ReviewModerationRepo/ReviewModerationRepoImpl.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

typedef ReportSubmit =
    Future<String?> Function(ReviewReportReason reason, String details);

class ReportReviewSheet extends StatefulWidget {
  const ReportReviewSheet({super.key, required this.onSubmit});

  final ReportSubmit onSubmit;

  static Future<bool> show(
    BuildContext context, {
    required ReportSubmit onSubmit,
  }) async {
    final sent = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => ReportReviewSheet(onSubmit: onSubmit),
    );
    return sent ?? false;
  }

  static String labelFor(ReviewReportReason reason) {
    switch (reason) {
      case ReviewReportReason.offensive:
        return LocaleKeys.reviewReportReasonOffensive;
      case ReviewReportReason.harassment:
        return LocaleKeys.reviewReportReasonHarassment;
      case ReviewReportReason.spam:
        return LocaleKeys.reviewReportReasonSpam;
      case ReviewReportReason.personalInfo:
        return LocaleKeys.reviewReportReasonPersonalInfo;
      case ReviewReportReason.irrelevant:
        return LocaleKeys.reviewReportReasonIrrelevant;
      case ReviewReportReason.other:
        return LocaleKeys.reviewReportReasonOther;
    }
  }

  @override
  State<ReportReviewSheet> createState() => _ReportReviewSheetState();
}

class _ReportReviewSheetState extends State<ReportReviewSheet> {
  static const Color danger = Color(0xFFC62828);
  final details = TextEditingController();
  ReviewReportReason? reason;
  bool sending = false;
  String? error;

  @override
  void dispose() {
    details.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final selected = reason;
    if (selected == null) return;
    setState(() {
      sending = true;
      error = null;
    });
    final failure = await widget.onSubmit(selected, details.text);
    if (!mounted) return;
    if (failure == null) {
      Navigator.of(context).pop(true);
      return;
    }
    setState(() {
      sending = false;
      error = failure;
    });
  }

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyles(context);
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(LocaleKeys.reviewReportTitle, style: styles.bold16),
            const SizedBox(height: 6),
            Text(
              LocaleKeys.reviewReportBody,
              style: styles.regular13.copyWith(
                color: Theme.of(context).textTheme.bodySmall?.color,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 8),
            RadioGroup<ReviewReportReason>(
              groupValue: reason,
              onChanged: (value) {
                if (!sending) setState(() => reason = value);
              },
              child: Column(
                children: [
                  for (final option in ReviewReportReason.values)
                    RadioListTile<ReviewReportReason>(
                      key: ValueKey('review-report-${option.wireValue}'),
                      contentPadding: EdgeInsets.zero,
                      value: option,
                      activeColor: danger,
                      title: Text(
                        ReportReviewSheet.labelFor(option),
                        style: styles.regular14,
                      ),
                    ),
                ],
              ),
            ),
            TextField(
              controller: details,
              enabled: !sending,
              minLines: 2,
              maxLines: 4,
              maxLength: ReviewModerationRepoImpl.maxDetailsLength,
              decoration: InputDecoration(
                hintText: LocaleKeys.reviewReportDetailsHint,
                errorText: error,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 8),
            FilledButton.icon(
              key: const ValueKey('review-report-send'),
              style: FilledButton.styleFrom(
                backgroundColor: danger,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: reason == null || sending ? null : _send,
              icon: sending
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.flag_outlined, color: Colors.white),
              label: Text(
                LocaleKeys.reviewReportSend,
                style: styles.semiBold14.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
