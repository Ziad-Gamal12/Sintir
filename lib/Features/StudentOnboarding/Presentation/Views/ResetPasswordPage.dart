import 'package:flutter/material.dart';

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
