import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';

class SearchCoursesErrorWidget extends StatelessWidget {
  final String errorMessage;
  const SearchCoursesErrorWidget({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: CustomErrorWidget(errormessage: errorMessage),
      ),
    );
  }
}
