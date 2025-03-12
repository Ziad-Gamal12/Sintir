import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/DisplayVediRequiresEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/displayCourseVedioVeiw.dart';

class Coursevedioitementity {
  String title, vedioUrl;
  int durationTime;
  File? file;
  String? type;
  String preffixImage = Assets.assetsImagesVedioIcon;
  ontap(
      {required BuildContext context,
      required Displayvedirequiresentity requires}) {
    GoRouter.of(context)
        .push(Displaycoursevedioveiw.routeName, extra: requires);
  }

  Coursevedioitementity(
      {required this.title,
      required this.vedioUrl,
      required this.durationTime,
      this.file,
      this.type});
}
