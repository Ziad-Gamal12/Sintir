import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCard.dart';
import 'package:svg_flutter/svg.dart';

class CustomVideoNote extends StatelessWidget {
  const CustomVideoNote({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(40),
              child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: SvgPicture.asset(Assets.assetsImagesUserAvatar)),
            ),
            title: const Text(
              "محمد ابراهيم",
              style: AppTextStyles.semiBold16,
            ),
            subtitle: const Text(
              "12/4/2025",
              style: AppTextStyles.regular13,
            )),
        const SizedBox(
          height: 5,
        ),
        const Text(
          "اواجه صعوبيه فى فهم هذا الدرس اتمنى المساعده فى الفهم و شرحه مره اخرى بطريقة مبسطه مه الحل",
          style: AppTextStyles.regular14,
        )
      ],
    ));
  }
}
