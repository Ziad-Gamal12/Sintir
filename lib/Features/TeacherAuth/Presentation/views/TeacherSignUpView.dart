import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/widgets/TeacherSignUpViewBody.dart';

class TeacherSignUpView extends StatelessWidget {
  const TeacherSignUpView({super.key});
  static const String routeName = "/TeacherSignUpView";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        title: Text(
          "انشاء حساب",
          style: AppTextStyles.bold19Auto.copyWith(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: const TeacherSignUpViewBody(),
    );
  }
}
