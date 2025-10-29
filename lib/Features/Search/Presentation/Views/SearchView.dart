import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Search/Domain/Repos/SearchRepo.dart';
import 'package:sintir/Features/Search/Presentation/Managers/cubit/search_cubit.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/SearchViewBody.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});
  static const routeName = "/SearchView";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(
        searchRepo: getIt.get<SearchRepo>(),
      ),
      child: const Scaffold(
        appBar: CustomAppBar(appBartitle: "البحث"),
        body: SearchViewBody(),
      ),
    );
  }
}
