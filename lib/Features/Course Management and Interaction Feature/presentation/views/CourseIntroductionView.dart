// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseIntroduction_Widgets/CourseIntroductionViewBody.dart';

class CourseIntroductionView extends StatelessWidget {
  const CourseIntroductionView(
      {super.key, required this.bottomsheetnavigationrequirmentsentity});
  static const routeName = "/CourseIntroductionView";
  final Bottomsheetnavigationrequirmentsentity
      bottomsheetnavigationrequirmentsentity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          appBartitle: bottomsheetnavigationrequirmentsentity.course.title),
      body: Provider.value(
        value: bottomsheetnavigationrequirmentsentity,
        child: const CourseIntroductionViewBody(),
      ),
    );
  }
}
