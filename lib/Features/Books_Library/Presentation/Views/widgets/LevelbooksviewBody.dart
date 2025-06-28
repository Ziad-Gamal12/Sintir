// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomSearchTextField.dart';
import 'package:sintir/Features/Books_Library/Presentation/Views/widgets/BooksListView.dart';
import 'package:sintir/Features/Books_Library/Presentation/Views/widgets/LevelBooksListViewHeader.dart';
import 'package:sintir/constant.dart';

class LevelbooksviewBody extends StatelessWidget {
  LevelbooksviewBody({super.key});
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                CustomSearchTextField(
                  onSearchChanged: () {},
                  controller: controller,
                ),
                const SizedBox(
                  height: 46,
                ),
                Levelbookslistviewheader(),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          const Bookslistview()
        ],
      ),
    );
  }
}
