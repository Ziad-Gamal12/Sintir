import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/UserPersonalDetailsViewWidgets/UserPersonalDetailsViewBody.dart';
import 'package:sintir/locale_keys.dart';

class UserPersonalDetailsView extends StatelessWidget {
  const UserPersonalDetailsView({super.key});
  static const String routeName = "/UserPersonalDetailsView";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBartitle: LocaleKeys.profilePersonalData,
      ),
      body: const UserPersonalDetailsViewBody(),
    );
  }
}
