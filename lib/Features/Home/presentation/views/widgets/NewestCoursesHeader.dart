import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomListORGridTextHeader.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class NewestCoursesHeader extends StatelessWidget {
  const NewestCoursesHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListORGridTextHeader(
        text: LocaleKeys.latestCourses,
        trailing: InkWell(
          child: Text(
            LocaleKeys.seeMore,
            style:
                AppTextStyles(context).semiBold14.copyWith(color: KMainColor),
          ),
          onTap: () {},
        ));
  }
}
