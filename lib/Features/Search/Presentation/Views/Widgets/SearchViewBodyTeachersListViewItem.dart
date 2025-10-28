import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:svg_flutter/svg.dart';

class SearchViewBodyTeachersListViewItem extends StatelessWidget {
  const SearchViewBodyTeachersListViewItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          child: SvgPicture.asset(
            Assets.assetsIconsSVGIconsUserAvatar,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "محمد حسن",
          style: AppTextStyles(context).regular14,
        )
      ],
    );
  }
}
