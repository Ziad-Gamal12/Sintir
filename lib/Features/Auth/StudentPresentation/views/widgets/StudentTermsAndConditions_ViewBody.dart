// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class StudentTermsAndConditions_ViewBody extends StatelessWidget {
  const StudentTermsAndConditions_ViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(LocaleKeys.studentTermsIntroTitle,
              style: AppTextStyles(context).bold19),
          const SizedBox(height: 8),
          Text(
            LocaleKeys.studentTermsIntroText,
          ),
          const SizedBox(height: 16),
          Text(LocaleKeys.studentTermsUsageTitle,
              style: AppTextStyles(context).bold19),
          const SizedBox(height: 8),
          Text(
            LocaleKeys.studentTermsUsageText,
          ),
          const SizedBox(height: 16),
          Text(LocaleKeys.studentTermsPaymentsTitle,
              style: AppTextStyles(context).bold19),
          const SizedBox(height: 8),
          Text(
            LocaleKeys.studentTermsPaymentsText,
          ),
          const SizedBox(height: 16),
          Text(LocaleKeys.studentTermsPrivacyTitle,
              style: AppTextStyles(context).bold19),
          const SizedBox(height: 8),
          Text(
            LocaleKeys.studentTermsPrivacyText,
          ),
          const SizedBox(height: 16),
          Text(LocaleKeys.studentTermsChangesTitle,
              style: AppTextStyles(context).bold19),
          const SizedBox(height: 8),
          Text(
            LocaleKeys.studentTermsChangesText,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
