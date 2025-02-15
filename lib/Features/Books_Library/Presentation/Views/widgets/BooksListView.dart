import 'package:flutter/material.dart';
import 'package:sintir/Features/Books_Library/Presentation/Views/widgets/BooksListViewItem.dart';

class Bookslistview extends StatelessWidget {
  const Bookslistview({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(itemBuilder: (context, index) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: SizedBox(
          child: AspectRatio(
              aspectRatio: 90 / 53,
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
