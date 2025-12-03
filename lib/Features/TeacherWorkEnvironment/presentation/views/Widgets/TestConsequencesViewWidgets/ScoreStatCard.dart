import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class ScoreStatCard extends StatelessWidget {
  const ScoreStatCard({
    super.key,
    required this.label,
    required this.value,
    required this.total,
    required this.color,
  });

  final String label;
  final String value;
  final String total;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color cardColor = theme.cardColor;
    final Color borderColor = theme.dividerColor;
    final Color primaryTextColor = theme.textTheme.bodyLarge!.color!;

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("$total/",
                  style: AppTextStyles(context)
                      .semiBold16
                      .copyWith(color: primaryTextColor)),
              Text(
                value,
                style: AppTextStyles(context).semiBold16.copyWith(color: color),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles(context)
                .semiBold14
                .copyWith(color: primaryTextColor),
          ),
        ],
      ),
    );
  }
}
