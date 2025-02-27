import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/AddcoursesectionOptionItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/AddCourseSectionSQLView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddcoursesectionviewWidgets/AddCourseSectionContentItem.dart';

class AddCourseSectionContentOptions extends StatelessWidget {
  const AddCourseSectionContentOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: Addcoursesectionoptionitem.toList().asMap().entries.map((e) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: InkWell(
              onTap: () {
                if (e.key == 1) {
                  GoRouter.of(context).push(Addcoursesectionsqlview.routeName);
                }
              },
              child: Addcoursesectioncontentitem(
                item: e.value,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
