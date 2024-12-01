// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';
import 'package:svg_flutter/svg_flutter.dart';

class HomeViewBodyAppBar extends StatelessWidget {
  const HomeViewBodyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        child: SvgPicture.asset(Assets.assetsImagesUserAvatar),
      ),
      title: Text.rich(TextSpan(children: [
        TextSpan(
          text: "مرحبا بعودتك , ",
          style: AppTextStyles.bold20Auto.copyWith(color: Colors.black),
        ),
        TextSpan(
          text: "زياد",
          style: AppTextStyles.bold20Auto.copyWith(color: KSecondaryColor),
        ),
      ])),
      trailing: IntrinsicWidth(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
              },
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
}
