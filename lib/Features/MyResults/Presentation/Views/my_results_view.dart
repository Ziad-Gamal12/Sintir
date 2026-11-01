import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/MyResults/Domain/Repo/my_results_repo.dart';
import 'package:sintir/Features/MyResults/Presentation/Manager/cubit/my_results_cubit.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/my_results_view_body.dart';
import 'package:sintir/locale_keys.dart';

class MyResultsView extends StatelessWidget {
  const MyResultsView({super.key});
  static const routeName = '/MyResultsView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBartitle: LocaleKeys.myResultsAppbar),
      body: SafeArea(
        top: false,
        child: BlocProvider(
            create: (context) => MyResultsCubit(
                  myResultsRepo: getIt.get<MyResultsRepo>(),
                ),
            child: const MyResultsViewBody()),
      ),
    );
  }
}
