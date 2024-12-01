import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/widgets/customListTileWidget.dart';

import '../../utils/imageAssets.dart';

class CourseBottomSheetHeader extends StatelessWidget {
  const CourseBottomSheetHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IntrinsicWidth(
          child: Customlisttilewidget(
              title: "Creatives X",
              subtitle: "English instructor",
              image: Assets.assetsImagesUserAvatar),
        ),
        const Spacer(),
        IconButton(onPressed: () {}, icon: const Icon(FontAwesomeIcons.xmark))
      ],
    );
  }
}
