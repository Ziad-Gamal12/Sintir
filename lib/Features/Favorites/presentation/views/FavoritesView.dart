import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Favorites/presentation/views/widgets/FavoritesviewBody.dart';
import 'package:sintir/locale_keys.dart';

// ignore: must_be_immutable
class Favoritesview extends StatelessWidget {
  Favoritesview({super.key, this.isPopUp = true});
  static const routeName = "/Favoritesview";
  bool? isPopUp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBartitle: LocaleKeys.favorites,
        isPopUp: isPopUp,
      ),
      body: const FavoritesviewBody(),
    );
  }
}
