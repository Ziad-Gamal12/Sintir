import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomIDWidget.dart';
import 'package:sintir/Core/widgets/CustomSettingsIcon.dart';
import 'package:sintir/Core/widgets/CustomSupportWidget.dart';
import 'package:svg_flutter/svg.dart';

class StudentprofileInfo extends StatelessWidget {
  const StudentprofileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 40,
          child: SvgPicture.asset(Assets.assetsImagesUserAvatar),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: "زياد جمال",
                  style:
                      AppTextStyles.semiBold14.copyWith(color: Colors.black)),
              const TextSpan(
                text: " ",
              ),
              TextSpan(
                  text: "(ذكر)",
                  style: AppTextStyles.regular10
                      .copyWith(color: const Color(0xff818181)))
            ])),
            const SizedBox(
              height: 2,
            ),
            Text(
              "11/9/2008",
              style: AppTextStyles.regular10
                  .copyWith(color: const Color(0xff818181)),
            ),
            const SizedBox(
              height: 2,
            ),
            const Customidwidget(id: "120565478934")
          ],
        ),
        const Spacer(),
        const Column(
          children: [
            Customsettingsicon(),
            SizedBox(
              height: 12,
            ),
            Customsupportwidget()
          ],
        )
      ],
    );
  }
}
