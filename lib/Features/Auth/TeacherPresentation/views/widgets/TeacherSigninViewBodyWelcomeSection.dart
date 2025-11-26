import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';
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
            aspectRatio: 2 / 1,
            child:
                SvgPicture.asset(Assets.assetsImagesSVGImagesLoginWelcomeImage),
          ),
        ),
        const SizedBox(height: 16),
        Text.rich(
          TextSpan(children: [
            TextSpan(
              text: LocaleKeys.welcomeBack,
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
          height: 8,
        ),
        Text(
          LocaleKeys.loginToContinue,
          style: AppTextStyles(context).regular16,
        ),
      ],
    );
  }
}
