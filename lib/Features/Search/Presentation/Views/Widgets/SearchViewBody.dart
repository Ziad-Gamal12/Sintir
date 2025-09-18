import 'package:flutter/material.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/SearchViewBodySearchAndFilterSection.dart';
import 'package:sintir/constant.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(
          horizontal: KHorizontalPadding, vertical: KVerticalPadding),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SearchViewBodySearchAndFilterSection(controller: controller),
          )
        ],
      ),
    );
  }
}
