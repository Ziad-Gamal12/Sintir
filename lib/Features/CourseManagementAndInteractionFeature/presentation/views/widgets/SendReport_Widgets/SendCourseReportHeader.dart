import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class SendCourseReportHeader extends StatelessWidget {
  const SendCourseReportHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyles = AppTextStyles(context);
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.sendCourseReportTitle,
          style: textStyles.bold20.copyWith(color: textTheme.bodyLarge?.color),
        ),
        SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.security, size: 16, color: Color(0xff006645)),
            SizedBox(width: 6),
            Text(
              LocaleKeys.sendCourseReportPrivacyNotice,
              style: textStyles.regular14
                  .copyWith(color: textTheme.bodyLarge?.color),
            ),
          ],
        )
      ],
    );
  }
}
