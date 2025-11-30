import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/locale_keys.dart';

class CourseSectionTextFields extends StatelessWidget {
  const CourseSectionTextFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          hintText: LocaleKeys.enterLectureNameHere,
          obscureText: false,
          textInputType: TextInputType.text,
          onSaved: (value) {
            context.read<OptionNavigationRequirementsEntity>().section.title =
                value!;
          },
          validator: (value) {
            if (value!.isEmpty) {
              return LocaleKeys.enterLectureName;
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        CustomTextField(
            hintText: LocaleKeys.enterLectureDescriptionHere,
            obscureText: false,
            textInputType: TextInputType.text,
            maxLines: 5,
            validator: (value) {
              if (value!.isEmpty) {
                return LocaleKeys.enterLectureDescription;
              }
              return null;
            },
            onSaved: (value) {
              context
                  .read<OptionNavigationRequirementsEntity>()
                  .section
                  .subtitle = value!;
            }),
      ],
    );
  }
}
