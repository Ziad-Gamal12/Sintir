import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';

class CourseBottomSheetCourseDetails extends StatelessWidget {
  const CourseBottomSheetCourseDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(TextSpan(children: [
          TextSpan(
              text: "Creatives X Event Vol.2",
              style: AppTextStyles.semiBold20.copyWith(color: Colors.black)),
          const TextSpan(
            text: " ",
          ),
          TextSpan(
              text: "(75 فديو)",
              style: AppTextStyles.regular11
                  .copyWith(color: const Color(0xff818181)))
        ])),
        const SizedBox(
          height: 10,
        ),
        Text(
          "في كريتيڤز إكس بنحقق معادلة صعبة، معادلة إنك تستمتع و في نفس الوقت تستفيد. تستفيد من مواضيع مختلفة للمتحدثين، أو علاقات عمل تقدر تعملها أو يوم لطيف تقضيه مع أصحابك و غيره كتير. الاستفادة في مجالات زي : الجرافيك و الموشن ديزاين، الدوبلاج والفويس أوفر، اللغة الإنجليزية، الذكاء الإصطناعي، وغيره كتير.",
          style: AppTextStyles.regular10.copyWith(color: Colors.black),
        ),
        const SizedBox(
          height: 20,
        ),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: "المبلغ :    ",
                style: AppTextStyles.semiBold20.copyWith(color: Colors.black)),
            TextSpan(
                text: " 120\$ (شهرى)",
                style:
                    AppTextStyles.bold20Auto.copyWith(color: KSecondaryColor))
          ]),
        ),
      ],
    );
  }
}
