import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/MyTransactions/Domain/Repos/MyTransactionsRep.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Manager/my_transactions_cubit/my_transactions_cubit.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/MyTransactionsViewBody.dart';
import 'package:sintir/locale_keys.dart';

class MyTransactionsView extends StatelessWidget {
  const MyTransactionsView({super.key});
  static const routeName = '/MyTransactionsView';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyTransactionsCubit(
        myTransactionsRep: getIt<MyTransactionsRepo>(),
      ),
      child: Scaffold(
        appBar: CustomAppBar(appBartitle: LocaleKeys.myPayments),
        body: const MyTransactionsViewBody(),
      ),
    );
  }
}
