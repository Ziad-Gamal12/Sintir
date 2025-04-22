import 'package:flutter/material.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseFedBack_Widgets/CourseFedBacksListView_item.dart';

class Coursefedbackslistview extends StatelessWidget {
  const Coursefedbackslistview({super.key, required this.courseFedBacks});
  final List courseFedBacks;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: courseFedBacks.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: CoursefedbackslistviewItem(item: courseFedBacks[index]),
          );
        });
  }
}
