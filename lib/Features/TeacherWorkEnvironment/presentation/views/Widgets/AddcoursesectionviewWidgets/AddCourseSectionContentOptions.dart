import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/AddcoursesectionOptionItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/AddCourseSectionFileView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/AddCourseSectionSQLView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/AddCourseSectionVedioView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddcoursesectionviewWidgets/AddCourseSectionContentItem.dart';

class AddCourseSectionContentOptions extends StatelessWidget {
  AddCourseSectionContentOptions(
      {super.key, required this.optionRequirementsEntity, this.onSave});
  final Optionnavigationrequirementsentity optionRequirementsEntity;
  VoidCallback? onSave;

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
                onSave;
                if (e.key == 1) {
                  GoRouter.of(context).push(Addcoursesectionsqlview.routeName,
                      extra: optionRequirementsEntity);
                } else if (e.key == 0) {
                  GoRouter.of(context).push(
                    Addcoursesectionvedioview.routeName,
                    extra: optionRequirementsEntity,
                  );
                } else {
                  GoRouter.of(context).push(
                    Addcoursesectionfileview.routeName,
                    extra: optionRequirementsEntity,
                  );
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
