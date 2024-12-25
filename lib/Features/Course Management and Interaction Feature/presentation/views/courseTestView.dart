import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CoursetestviewBody.dart';

class Coursetestview extends StatelessWidget {
  const Coursetestview({super.key, required this.coursetestentity});
  static const routename = "/Coursetestview";
  final Coursetestentity coursetestentity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBartitle: "أسئلة متعلقة بالدرس"),
      body: CoursetestviewBody(
        coursetestentity: coursetestentity,
      ),
    );
  }
}
