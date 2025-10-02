// ignore_for_file: file_names, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Profile/Presentation/Views/ProfileView.dart';
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
              GoRouter.of(context).push(ProfileView.routeName);
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
          style: AppTextStyles(context).bold20.copyWith(color: Colors.black),
        ),
        TextSpan(
          text: getUserData().firstName,
          style: AppTextStyles(context).bold20.copyWith(color: KSecondaryColor),
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
                Assets.assetsIconsNotificationIcon,
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
}
