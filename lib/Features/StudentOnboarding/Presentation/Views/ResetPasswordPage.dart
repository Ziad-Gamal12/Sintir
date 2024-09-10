import 'package:flutter/material.dart';
import 'package:sintir/Features/StudentOnboarding/Presentation/Views/widgets/ResetPasswordBody.dart';

class ResetPasswordPage extends StatelessWidget {
  static const String routeName = "/ResetPasswordPage";
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResetPasswordBody(),
    );
  }
}
