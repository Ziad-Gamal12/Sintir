// ignore_for_file: file_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/Customonboardingpageviewentity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:svg_flutter/svg.dart';

class CustomOnboardingPageViewItem extends StatelessWidget {
  final Customonboardingpageviewentity entity;

  const CustomOnboardingPageViewItem({
    super.key,
    required this.entity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .3,
            child: SvgPicture.asset(
              entity.image,
              fit: BoxFit.scaleDown,
            )),
        const Customsizedbox(width: 0, height: 40),
        entity.title,
        const Customsizedbox(width: 0, height: 20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 37),
          child: Text(entity.description,
              textAlign: TextAlign.center,
              style: AppTextStyles.regular13
                  .copyWith(color: const Color(0xff4E5556))),
        ),
      ],
    );
  }
}
