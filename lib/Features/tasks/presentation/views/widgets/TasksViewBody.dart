import 'package:flutter/material.dart';
import 'package:sintir/Features/tasks/presentation/views/widgets/tasksListView.dart';
import 'package:sintir/Features/tasks/presentation/views/widgets/tasksListViewHeader.dart';
import 'package:sintir/constant.dart';

class TasksViewBody extends StatelessWidget {
  const TasksViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: KHorizontalPadding),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            SliverToBoxAdapter(
              child: Taskslistviewheader(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            TasksListView()
          ],
        ));
  }
}
