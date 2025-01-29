import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/AddCourseFirstContentView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseInputs.dart';
import 'package:sintir/constant.dart';

class Addcourseviewbody extends StatelessWidget {
  const Addcourseviewbody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
      child: ListView(
        children: [
          const AddCourseInputs(),
          const SizedBox(
            height: 20,
          ),
          Custombutton(
              text: "التالى",
              color: KSecondaryColor,
              textColor: Colors.white,
              onPressed: () {
                GoRouter.of(context).push(Addcoursefirstcontentview.routeName);
              })
        ],
      ),
    );
  }
}
