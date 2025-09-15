// ignore_for_file: file_names, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/services/Shared_preferences.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/StudentProfile/presentation/views/studentProfileView.dart';
import 'package:sintir/Features/TeacherProfile/presentation/views/TeacherProfileView.dart';
import 'package:sintir/constant.dart';

class HomeViewBodyAppBar extends StatelessWidget {
  const HomeViewBodyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: SizedBox(
        width: 60,
        child: InkWell(
            onTap: () {
              profileNavigation(context);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(80),
              child: CachedNetworkImage(
                imageUrl: getUserData().profilePicurl,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            )),
      ),
      title: Text.rich(TextSpan(children: [
        TextSpan(
          text: "مرحبا بعودتك , ",
          style: AppTextStyles.bold20Auto.copyWith(color: Colors.black),
        ),
        TextSpan(
          text: getUserData().firstName,
          style: AppTextStyles.bold20Auto.copyWith(color: KSecondaryColor),
        ),
      ])),
      trailing: SizedBox(
        width: 88,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {},
              child: Image.asset(
                Assets.assetsImagesNotificationIcon,
                height: 25,
                width: 25,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            IconButton(
                onPressed: () {
                  Variables.HomeViewScaffoldKey.currentState!.openEndDrawer();
                },
                icon: const Icon(
                  FontAwesomeIcons.bars,
                  size: 24,
                ))
          ],
        ),
      ),
    );
  }

  profileNavigation(BuildContext context) {
    String userKind = shared_preferences_Services.stringGetter(
        key: BackendEndpoints.userKind);
    if (userKind == "teacher") {
      GoRouter.of(context).push(Teacherprofileview.routeName);
    } else {
      GoRouter.of(context).push(Studentprofileview.routeName);
    }
  }
}
