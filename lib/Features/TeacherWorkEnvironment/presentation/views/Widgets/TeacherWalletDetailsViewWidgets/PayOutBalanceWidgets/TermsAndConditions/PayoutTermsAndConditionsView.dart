import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/PayOutBalanceWidgets/TermsAndConditions/PayoutTermsAndConditionsViewBody.dart';
import 'package:sintir/locale_keys.dart';

class PayoutTermsAndConditionsView extends StatelessWidget {
  const PayoutTermsAndConditionsView({super.key});
  static const routeName = '/PayoutTermsAndConditionsView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBartitle: LocaleKeys.termsConditions),
      body: const PayoutTermsAndConditionsViewBody(),
    );
  }
}
