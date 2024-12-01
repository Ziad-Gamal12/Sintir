import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/customListTileWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/displayCourseVedioVeiw.dart';

class CustomSectionListViewVedioItem extends StatelessWidget {
  const CustomSectionListViewVedioItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(Displaycoursevedioveiw.routeName);
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          alignment: AlignmentDirectional.center,
          width: double.infinity,
          height: 55,
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8)),
          child: Customlisttilewidget(
            title: "برومو - دورة حياة المنتج",
            image: Assets.assetsImagesVedioIcon,
            trailing: Text(
              "8 دقائق",
              style: AppTextStyles.regular11
                  .copyWith(color: const Color(0xff818181)),
            ),
          )),
    );
  }
}
