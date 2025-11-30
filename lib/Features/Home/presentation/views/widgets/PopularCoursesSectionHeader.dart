import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomListORGridTextHeader.dart';
import 'package:sintir/Features/Home/presentation/views/MorePopularCoursesView.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class PopularCoursesSectionHeader extends StatelessWidget {
  const PopularCoursesSectionHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListORGridTextHeader(
        text: LocaleKeys.mostViewed,
        trailing: InkWell(
          child: Text(
            LocaleKeys.seeMore,
            style:
                AppTextStyles(context).semiBold14.copyWith(color: KMainColor),
          ),
          onTap: () {
            GoRouter.of(context).push(MorePopularCoursesView.routeName);
          },
        ));
  }
}
