import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/SearchViewBody.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});
  static const routeName = "/SearchView";
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(appBartitle: "البحث"),
      body: SearchViewBody(),
    );
  }
}
