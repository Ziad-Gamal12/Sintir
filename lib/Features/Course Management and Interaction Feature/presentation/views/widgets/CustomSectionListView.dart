import 'package:flutter/material.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomSectionListViewVedioItem.dart';

class CustomSectionListView extends StatelessWidget {
  const CustomSectionListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, item) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: CustomSectionListViewVedioItem(),
        );
      },
    );
  }
}
