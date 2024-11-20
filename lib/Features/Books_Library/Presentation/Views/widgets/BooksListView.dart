import 'package:flutter/material.dart';
import 'package:sintir/Features/Books_Library/Presentation/Views/widgets/BooksListViewItem.dart';

class Bookslistview extends StatelessWidget {
  const Bookslistview({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * .3,
          width: MediaQuery.sizeOf(context).width,
          child: const AspectRatio(
              aspectRatio: 130 / 190,
              child: Column(
                children: [
                  Bookslistviewitem(),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                ],
              )),
        ),
      );
    });
  }
}
