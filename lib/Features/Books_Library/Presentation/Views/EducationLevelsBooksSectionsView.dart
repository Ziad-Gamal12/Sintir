import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Books_Library/Presentation/Views/widgets/EducationLevelsBooksSectionsView_Body.dart';

class EducationLevelsBooksSectionsView extends StatelessWidget {
  const EducationLevelsBooksSectionsView({super.key});
  static const routeName = '/EducationLevelsBooksSectionsView';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(appBartitle: "معرض الكتب"),
      body: SafeArea(child: EducationLevelsBooksSectionsViewBody()),
    );
  }
}
