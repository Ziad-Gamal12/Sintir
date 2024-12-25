import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/DisplayVediRequiresEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/DisplayCourseVedioView_Widgets/DisplaycoursevedioveiwBody.dart';

class Displaycoursevedioveiw extends StatelessWidget {
  const Displaycoursevedioveiw({
    super.key,
    required this.displayVedioRequiresEntity,
  });
  static const routeName = '/Displaycoursevedioveiw';
  final Displayvedirequiresentity displayVedioRequiresEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Variables.DisplaycoursevedioveiwScaffoldKey,
      appBar: CustomAppBar(
          appBartitle: displayVedioRequiresEntity.vedioEntity.title),
      body: DisplaycoursevedioveiwBody(
        vedio: displayVedioRequiresEntity.vedioEntity,
        courseSectionsList: displayVedioRequiresEntity.sections,
      ),
    );
  }
}
