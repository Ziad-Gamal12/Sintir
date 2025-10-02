import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';
import 'package:svg_flutter/svg.dart';

class TeacherSigninViewBodyWelcomeSection extends StatelessWidget {
  const TeacherSigninViewBodyWelcomeSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: AspectRatio(
            aspectRatio: 3 / 2,
            child:
                SvgPicture.asset(Assets.assetsImagesSVGImagesLoginWelcomeImage),
          ),
        ),
        const SizedBox(height: 20),
        Text.rich(
          TextSpan(children: [
            TextSpan(
              text: "أهلا بعودتك لـ ",
              style: AppTextStyles(context).semiBold24,
            ),
            TextSpan(
              text: "Sintir ",
              style:
                  AppTextStyles(context).semiBold24.copyWith(color: KMainColor),
            ),
          ]),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "سجل دخولك لكي تستطيع استخدام التطبيق",
          style: AppTextStyles(context).regular16,
        ),
      ],
    );
  }
}
