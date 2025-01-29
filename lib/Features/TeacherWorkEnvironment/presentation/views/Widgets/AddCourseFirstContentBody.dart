import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseFirstContentHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseFirstContentOptionsList.dart';
import 'package:sintir/constant.dart';

class AddCourseFirstContentBody extends StatelessWidget {
  const AddCourseFirstContentBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const AddCourseFirstContentHeader(),
          const SizedBox(
            height: 20,
          ),
          const Expanded(child: Addcoursefirstcontentoptionslist()),
          const Spacer(),
          Custombutton(
              text: "تقديم طلب",
              color: KSecondaryColor,
              textColor: Colors.white,
              onPressed: () {}),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
