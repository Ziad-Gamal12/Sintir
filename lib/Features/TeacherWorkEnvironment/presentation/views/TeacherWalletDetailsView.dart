import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWalletDetailsViewBody.dart';

class TeacherWalletDetailsView extends StatelessWidget {
  const TeacherWalletDetailsView({
    super.key,
  });
  static const routeName = '/TeacherWalletDetailsView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBartitle: "تفاصيل المحفظة"),
      body: const TeacherWalletDetailsViewBody(),
    );
  }
}
