import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseFedBack_Widgets/Coursefedbackviewbody.dart';

class Coursefedbackview extends StatelessWidget {
  const Coursefedbackview({super.key, required this.fedBacks});
  static const routeName = '/Coursefedbackview';
  final List<CoursefedbackItemEntity> fedBacks;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBartitle: "اراء الطلاب"),
      body: Coursefedbackviewbody(
        fedBacks: fedBacks,
      ),
    );
  }
}
