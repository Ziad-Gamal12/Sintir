import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/UserPersonalDetailsViewWidgets/UserPersonalDetailsViewBody.dart';

class UserPersonalDetailsView extends StatelessWidget {
  const UserPersonalDetailsView({super.key});
  static const String routeName = "/UserPersonalDetailsView";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBartitle: "الملف الشخصي",
      ),
      body:const UserPersonalDetailsViewBody(), 
    );
  }
}
