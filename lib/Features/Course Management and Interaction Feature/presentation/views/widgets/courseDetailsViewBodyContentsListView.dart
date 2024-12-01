import 'package:flutter/material.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomContentListViewitem.dart';

class Coursedetailsviewbodyvedioslistview extends StatelessWidget {
  const Coursedetailsviewbodyvedioslistview({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: CustomContentListViewitem(),
        );
      },
    );
  }
}
