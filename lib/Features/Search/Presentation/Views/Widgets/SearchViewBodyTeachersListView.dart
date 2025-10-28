import 'package:flutter/material.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/SearchViewBodyTeachersListViewItem.dart';

class SearchViewBodyTeachersListView extends StatelessWidget {
  const SearchViewBodyTeachersListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .1,
      child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: SearchViewBodyTeachersListViewItem(),
            );
          }),
    );
  }
}
