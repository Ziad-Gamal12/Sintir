import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Features/Books_Library/Presentation/Views/LevelBooksView.dart';
import 'package:sintir/Features/Books_Library/Presentation/Views/widgets/EducaitonLevelGridViewItem.dart';
import 'package:sintir/constant.dart';

class Educationlevelgridview extends StatelessWidget {
  const Educationlevelgridview({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.symmetric(
            horizontal: KHorizontalPadding, vertical: 20),
        itemCount: 12,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20),
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                GoRouter.of(context).push(Levelbooksview.routeName);
              },
              child: const Educaitonlevelgridviewitem());
        });
  }
}
