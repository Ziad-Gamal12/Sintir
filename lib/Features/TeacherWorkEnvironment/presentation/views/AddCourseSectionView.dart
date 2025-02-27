import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddcoursesectionviewWidgets/AddcoursesectionviewBody.dart';

class Addcoursesectionview extends StatelessWidget {
  const Addcoursesectionview({super.key});
  static const String routeName = '/Addcoursesectionview';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBartitle: "اضافة محاضرة"),
      body: Addcoursesectionviewbody(),
    );
  }
}
