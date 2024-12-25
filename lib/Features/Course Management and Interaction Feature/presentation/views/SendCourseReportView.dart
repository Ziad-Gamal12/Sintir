import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/SendReport_Widgets/SendcoursereportviewBody.dart';

class Sendcoursereportview extends StatelessWidget {
  const Sendcoursereportview({
    super.key,
  });
  static const routeName = "/sendcoursereportview";
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(appBartitle: "ابلاغ"),
      body: Sendcoursereportviewbody(),
    );
  }
}
