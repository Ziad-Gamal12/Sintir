import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/MyResults/Domain/Repo/MyResultsRepo.dart';
import 'package:sintir/Features/MyResults/Presentation/Manager/cubit/my_results_cubit.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/MyResultsViewBody.dart';

class MyResultsView extends StatelessWidget {
  const MyResultsView({super.key});
  static const routeName = '/MyResultsView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBartitle: "نتائجي"),
      body: BlocProvider(
          create: (context) => MyResultsCubit(
                myResultsRepo: getIt.get<MyResultsRepo>(),
              ),
          child: const MyResultsViewBody()),
    );
  }
}
