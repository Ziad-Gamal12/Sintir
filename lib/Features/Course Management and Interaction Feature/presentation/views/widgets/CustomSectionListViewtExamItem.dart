import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/widgets/customListTileWidget.dart';

class Customsectionlistviewtexamitem extends StatelessWidget {
  const Customsectionlistviewtexamitem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: AlignmentDirectional.center,
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8)),
        child: Customlisttilewidget(
          title: "برومو - دورة حياة المنتج",
          image: Assets.assetsImagesExamIcon,
        ));
  }
}
