import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/DisplaycoursevedioveiwBody.dart';

class Displaycoursevedioveiw extends StatelessWidget {
  const Displaycoursevedioveiw({super.key});
  static const routeName = '/Displaycoursevedioveiw';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Variables.DisplaycoursevedioveiwScaffoldKey,
      appBar: const CustomAppBar(appBartitle: "برومو - دورة حياة المنتج"),
      body: DisplaycoursevedioveiwBody(),
    );
  }
}
