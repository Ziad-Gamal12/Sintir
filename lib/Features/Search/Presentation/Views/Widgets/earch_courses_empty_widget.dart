import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';

class SearchCoursesEmptyWidget extends StatelessWidget {
  const SearchCoursesEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: CustomEmptyWidget(text: "لا يوجد دورات"),
      ),
    );
  }
}
