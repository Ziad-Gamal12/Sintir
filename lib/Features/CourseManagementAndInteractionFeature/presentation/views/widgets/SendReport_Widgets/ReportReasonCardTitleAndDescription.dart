import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class ReportReasonCardTitleAndDescription extends StatelessWidget {
  const ReportReasonCardTitleAndDescription(
      {super.key, required this.title, required this.description});
  final String title, description;
  @override
  Widget build(BuildContext context) {
    final textStyles = AppTextStyles(context);
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:
              textStyles.semiBold14.copyWith(color: textTheme.bodyLarge?.color),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: double.infinity,
          child: Text(
            description,
            style: textStyles.regular12
                .copyWith(color: textTheme.bodyLarge?.color),
          ),
        ),
      ],
    );
  }
}
