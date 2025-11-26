import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Search/Domain/Repos/SearchRepo.dart';
import 'package:sintir/Features/Search/Presentation/Managers/cubit/search_cubit.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/SearchViewBody.dart';
import 'package:sintir/locale_keys.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});
  static const routeName = "/SearchView";

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => SearchCubit(
        searchRepo: getIt.get<SearchRepo>(),
      ),
      child: Scaffold(
        appBar: CustomAppBar(
          appBartitle: LocaleKeys.search,
          isPopUp: false,
        ),
        body: const SearchViewBody(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
