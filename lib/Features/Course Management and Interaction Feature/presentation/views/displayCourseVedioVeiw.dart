import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVideoviewnavigationsrequirmentsentity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/DisplayCourseVedioView_Widgets/DisplaycoursevedioveiwBody.dart';

class Displaycoursevedioveiw extends StatelessWidget {
  const Displaycoursevedioveiw({
    super.key,
    required this.coursevideoviewnavigationsrequirmentsentity,
  });
  static const routeName = '/Displaycoursevedioveiw';
  final Coursevideoviewnavigationsrequirmentsentity
      coursevideoviewnavigationsrequirmentsentity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Variables.DisplaycoursevedioveiwScaffoldKey,
      appBar: CustomAppBar(
          appBartitle: coursevideoviewnavigationsrequirmentsentity.video.title),
      body: Provider.value(
        value: coursevideoviewnavigationsrequirmentsentity.video,
        child: const DisplaycoursevedioveiwBody(),
      ),
    );
  }
}
