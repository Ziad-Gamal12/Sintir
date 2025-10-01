import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class Testresultdetailsrow extends StatelessWidget {
  const Testresultdetailsrow(
      {super.key,
      required this.headline,
      required this.value,
      required this.color,
      required this.cardColor});
  final String headline, value;
  final Color cardColor;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                FontAwesomeIcons.circleInfo,
                color: color,
                size: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  headline,
                  style:
                      AppTextStyles(context).semiBold16.copyWith(color: color),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: AppTextStyles(context).bold32.copyWith(color: color),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
