import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/AddcoursesectionOptionItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/AddCourseSectionSQLView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/AddCourseSectionVedioView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddcoursesectionviewWidgets/AddCourseSectionContentItem.dart';

class AddCourseSectionContentOptions extends StatelessWidget {
  const AddCourseSectionContentOptions({
    super.key,
    required this.courseEntity,
  });
  final CourseEntity courseEntity;
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
                if (Variables.AddCourseSectionFormKey.currentState!
                    .validate()) {
                  if (e.key == 1) {
                    GoRouter.of(context).push(Addcoursesectionsqlview.routeName,
                        extra: courseEntity);
                  } else if (e.key == 0) {
                    GoRouter.of(context).push(
                      Addcoursesectionvedioview.routeName,
                    );
                  }
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
