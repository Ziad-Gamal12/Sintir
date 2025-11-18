import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/AddcoursesectionOptionItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/AddCourseSectionExamView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/AddCourseSectionFileView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/AddCourseSectionVedioView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddcoursesectionviewWidgets/AddCourseSectionContentItem.dart';

class AddCourseSectionItemContentOptions extends StatelessWidget {
  const AddCourseSectionItemContentOptions(
      {super.key, required this.optionRequirementsEntity});
  final OptionNavigationRequirementsEntity optionRequirementsEntity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: Addcoursesectionoptionitem.toList().asMap().entries.map((e) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: () {
                if (e.key == 1) {
                  GoRouter.of(context).push(AddcourseSectionExamview.routeName,
                      extra: optionRequirementsEntity);
                } else if (e.key == 0) {
                  GoRouter.of(context).push(
                    Addcoursesectionvedioview.routeName,
                    extra: optionRequirementsEntity,
                  );
                } else if (e.key == 2) {
                  GoRouter.of(context).push(
                    Addcoursesectionfileview.routeName,
                    extra: optionRequirementsEntity,
                  );
                }
              },
              child: AddCourseSectionContentItem(
                item: e.value,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
