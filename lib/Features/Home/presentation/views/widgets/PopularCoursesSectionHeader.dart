import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomListORGridTextHeader.dart';
import 'package:sintir/constant.dart';

class PopularCoursesSectionHeader extends StatelessWidget {
  const PopularCoursesSectionHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListORGridTextHeader(
        text: "الأكثر مشاهدة",
        trailing: InkWell(
          child: Text(
            "المزيد",
            style:
                AppTextStyles(context).semiBold14.copyWith(color: KMainColor),
          ),
          onTap: () {},
        ));
  }
}
