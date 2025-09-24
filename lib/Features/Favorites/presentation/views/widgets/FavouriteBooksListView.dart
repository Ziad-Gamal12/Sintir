import 'package:flutter/material.dart';
import 'package:sintir/Features/Favorites/presentation/views/widgets/CsutomFavoriteBookListViewItem.dart';

class Favouritebookslistview extends StatelessWidget {
  const Favouritebookslistview({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .27,
      child: ListView.builder(
          padding: const EdgeInsets.only(right: 11),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: AspectRatio(
                  aspectRatio: 115 / 170,
                  child: Csutomfavoritebooklistviewitem()),
            );
          }),
    );
  }
}
