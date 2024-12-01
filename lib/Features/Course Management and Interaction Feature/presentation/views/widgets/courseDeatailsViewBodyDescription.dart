import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class Coursedeatailsviewbodydescription extends StatelessWidget {
  const Coursedeatailsviewbodydescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "الوصف",
          style: AppTextStyles.bold24.copyWith(color: Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "في كريتيڤز إكس بنحقق معادلة صعبة، معادلة إنك تستمتع و في نفس الوقت تستفيد. تستفيد من مواضيع مختلفة للمتحدثين، أو علاقات عمل تقدر تعملها أو يوم لطيف تقضيه مع أصحابك و غيره كتير. الاستفادة في مجالات زي : الجرافيك و الموشن ديزاين، الدوبلاج والفويس أوفر، اللغة الإنجليزية، الذكاء الإصطناعي، وغيره كتير.",
          style:
              AppTextStyles.regular10.copyWith(color: const Color(0xff818181)),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
