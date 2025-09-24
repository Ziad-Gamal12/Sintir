import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Favorites/presentation/views/widgets/FavoritesviewBody.dart';

class Favoritesview extends StatelessWidget {
  const Favoritesview({super.key});
  static const routeName = "/Favoritesview";
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(appBartitle: "المفضله"),
      body: FavoritesviewBody(),
    );
  }
}
