import 'package:flutter/material.dart';
import 'package:sintir/Features/tasks/presentation/views/widgets/addtask_Section.dart';
import 'package:sintir/Features/tasks/presentation/views/widgets/tasksListView.dart';
import 'package:sintir/Features/tasks/presentation/views/widgets/tasksListViewHeader.dart';
import 'package:sintir/constant.dart';

class TodolistviewBody extends StatelessWidget {
  const TodolistviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: KHorizontalPadding),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  AddtaskSection(),
                  SizedBox(
                    height: 30,
                  ),
                  Taskslistviewheader(),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            TasksListView()
          ],
        ));
  }
}
