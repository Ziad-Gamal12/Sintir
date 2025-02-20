// ignore_for_file: file_names, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/services/Shared_preferences.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/StudenetAuth/domain/entities/studentEntity.dart';
import 'package:sintir/Features/StudentProfile/presentation/views/studentProfileView.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Entities/teacherEntity.dart';
import 'package:sintir/Features/TeacherProfile/presentation/views/TeacherProfileView.dart';
import 'package:sintir/constant.dart';

class HomeViewBodyAppBar extends StatelessWidget {
  HomeViewBodyAppBar({super.key, this.student, this.teacher});
  teacherEntity? teacher;
  Studententity? student;
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
                imageUrl: getProfilePic(),
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
          text: getUserName(),
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

  String getProfilePic() {
    if (student != null) {
      return student!.imageUrl;
    } else if (teacher != null) {
      return teacher!.profilePicurl!;
    } else {
      return "https://cdn-icons-png.flaticon.com/128/847/847969.png";
    }
  }

  String getUserName() {
    if (student != null) {
      return student!.firstName;
    } else if (teacher != null) {
      return teacher!.firstName;
    } else {
      return "غير معروف";
    }
  }
}
