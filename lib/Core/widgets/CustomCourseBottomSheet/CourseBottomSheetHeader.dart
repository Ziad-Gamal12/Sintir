// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/entities/ContentCreaterEntity.dart';
import 'package:sintir/Core/widgets/customListTileWidget.dart';

import '../../utils/imageAssets.dart';

class CourseBottomSheetHeader extends StatelessWidget {
  const CourseBottomSheetHeader({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    Contentcreaterentity courseContentCreater = context
        .read<Bottomsheetnavigationrequirmentsentity>()
        .course
        .contentcreaterentity!;
    return Row(
      children: [
        IntrinsicWidth(
          child: Customlisttilewidget(
              title: courseContentCreater.name,
              subtitle: courseContentCreater.title,
              image: Assets.assetsImagesUserAvatar),
        ),
        const Spacer(),
        IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: const Icon(FontAwesomeIcons.xmark))
      ],
    );
  }
}
