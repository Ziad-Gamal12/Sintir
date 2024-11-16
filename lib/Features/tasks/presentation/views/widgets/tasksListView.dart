import 'package:flutter/material.dart';
import 'package:sintir/Features/tasks/presentation/views/widgets/customTasksList_item.dart';

class TasksListView extends StatelessWidget {
  const TasksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: CustomtaskslistItem(
                title: "تحضير الدرس الاول للصف الاول  الثانوى",
                subtitle: "11/5/2025"),
          );
        });
  }
}
