import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/tasks/presentation/views/widgets/TasksViewBody.dart';
import 'package:sintir/constant.dart';

class TasksView extends StatelessWidget {
  const TasksView({super.key});
  static const routeName = '/todolistview';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CircleAvatar(
        backgroundColor: KMainColor,
        radius: 40,
        child: Icon(Icons.add, color: Colors.white),
      ),
      appBar: CustomAppBar(
        appBartitle: "المهام",
      ),
      body: TasksViewBody(),
    );
  }
}
