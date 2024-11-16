import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';

class AddtaskSection extends StatelessWidget {
  const AddtaskSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
          color: const Color(0xffE5E5EA),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ]),
      child: Row(
        children: [
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "قم بأضافة مهمتك الجديدة من",
                style: AppTextStyles.regular14.copyWith(color: Colors.black)),
            const TextSpan(
              text: " ",
            ),
            TextSpan(
                text: "هنا",
                style: AppTextStyles.bold16Auto.copyWith(color: KMainColor))
          ])),
          const Spacer(),
          CircularPercentIndicator(
            radius: 40,
            progressColor: KMainColor,
            backgroundColor: Colors.grey,
            percent: .75,
            lineWidth: 10,
            animation: true,
            animationDuration: 500,
            center: Text(
              "75%",
              style: AppTextStyles.bold16Auto.copyWith(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
