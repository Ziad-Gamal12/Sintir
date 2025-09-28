import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/constant.dart';

class WorkEnvironmentNavigationButton extends StatelessWidget {
  const WorkEnvironmentNavigationButton({super.key, required this.role});
  final String role;
  @override
  Widget build(BuildContext context) {
    if (role == BackendEndpoints.teacherRole) {
      return Custombutton(
          text: "الذهاب لبيئة العمل",
          color: KMainColor,
          textColor: Colors.white,
          onPressed: () {});
    } else {
      return const SizedBox();
    }
  }
}
