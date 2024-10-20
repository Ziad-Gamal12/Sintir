// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/widgets/StudentTermsAndConditions_ViewBody.dart';
import 'package:svg_flutter/svg.dart';

class StudenttermsandconditionsView extends StatelessWidget {
  const StudenttermsandconditionsView({super.key});

  static const String routeName = '/StudenttermsandconditionsView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: SvgPicture.asset(
              Assets.assetsImagesArrowLeftBack,
              height: 30,
              width: 30,
            )),
        title: Text(
          "الشروط والأحكام",
          style: AppTextStyles.bold19Auto.copyWith(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: const StudentTermsAndConditions_ViewBody(),
    );
  }
}
