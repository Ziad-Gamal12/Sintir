import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/ProfileViewBody.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  static const String routeName = "/ProfileView";
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        appBartitle: "الملف الشخصي",
      ),
      body: ProfileViewBody(),
    );
  }
}
