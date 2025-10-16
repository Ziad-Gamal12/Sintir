import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentResultCard.dart';

class TestResultsSliverListView extends StatelessWidget {
  const TestResultsSliverListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child:
                AspectRatio(aspectRatio: 2 / 1.1, child: StudentResultCard()),
          );
        });
  }
}
