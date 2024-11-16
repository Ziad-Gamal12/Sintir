import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/tasks/presentation/views/widgets/TodolistviewBody.dart';

class Todolistview extends StatelessWidget {
  const Todolistview({super.key});
  static const routeName = '/todolistview';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        appBartitle: "المهام ",
      ),
      body: TodolistviewBody(),
    );
  }
}
