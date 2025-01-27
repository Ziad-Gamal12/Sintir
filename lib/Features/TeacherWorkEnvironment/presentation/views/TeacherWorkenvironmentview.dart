import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewBody.dart';

class TeacherWorkenvironmentview extends StatelessWidget {
  const TeacherWorkenvironmentview({super.key});
  static const routeName = '/TeacherWorkenvironmentview';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(appBartitle: "بيئة العمل"),
      body: TeacherWorkenvironmentviewBody(),
    );
  }
}
