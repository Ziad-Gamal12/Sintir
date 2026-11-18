// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class ReviewsSectionTitle extends StatelessWidget {
  const ReviewsSectionTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      child: Text(
        LocaleKeys.whatStudentsSay,
        key: const ValueKey('reviews-section-title'),
        style: AppTextStyles(context).semiBold16.copyWith(
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
    );
  }
}
