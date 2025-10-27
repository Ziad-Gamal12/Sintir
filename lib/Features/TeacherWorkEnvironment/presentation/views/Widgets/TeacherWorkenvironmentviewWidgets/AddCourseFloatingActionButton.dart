import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/AddCourseView.dart';
import 'package:sintir/constant.dart';

class AddCourseFloatingActionButton extends StatelessWidget {
  const AddCourseFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "اضافة كورس جديد",
      child: FloatingActionButton(
        backgroundColor: KMainColor,
        foregroundColor: Colors.white,
        onPressed: () => GoRouter.of(context).push(Addcourseview.routeName),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
