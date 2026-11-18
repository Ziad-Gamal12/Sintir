// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Profile/Domain/Repos/AccountDeletionRepo.dart';
import 'package:sintir/Features/Profile/Presentation/Manager/delete_account_cubit/delete_account_cubit.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/DeleteAccountViewWidgets/DeleteAccountViewBody.dart';
import 'package:sintir/locale_keys.dart';

class DeleteAccountView extends StatelessWidget {
  const DeleteAccountView({super.key});
  static const routeName = '/delete-account';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DeleteAccountCubit(repo: getIt<AccountDeletionRepo>()),
      child: Scaffold(
        appBar: CustomAppBar(appBartitle: LocaleKeys.accountDeleteTitle),
        body: const SafeArea(top: false, child: DeleteAccountViewBody()),
      ),
    );
  }
}
