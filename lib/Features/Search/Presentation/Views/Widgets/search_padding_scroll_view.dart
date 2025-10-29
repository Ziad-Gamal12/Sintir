import 'package:flutter/material.dart';
import 'package:sintir/constant.dart';

class SearchPaddingScrollView extends StatelessWidget {
  const SearchPaddingScrollView({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: KHorizontalPadding,
        vertical: KVerticalPadding,
      ),
      child: CustomScrollView(
        slivers: [
          for (final child in children) SliverToBoxAdapter(child: child),
        ],
      ),
    );
  }
}
