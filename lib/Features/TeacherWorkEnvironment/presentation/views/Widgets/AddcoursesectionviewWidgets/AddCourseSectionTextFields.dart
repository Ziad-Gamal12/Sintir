import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';

class CourseSectionTextFields extends StatelessWidget {
  const CourseSectionTextFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          hintText: "يرجى كتابه اسم المحاضرة هنا ...",
          obscureText: false,
          controller: Variables.AddCoursesectionNameController,
          textInputType: TextInputType.text,
          onSaved: (value) {
            context.read<OptionNavigationRequirementsEntity>().section.title =
                value!;
          },
          validator: (value) {
            if (value!.isEmpty) {
              return "ادخل اسم المحاضرة";
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        CustomTextField(
            hintText: "يرجى كتابه وصف المحاضرة هنا ...",
            obscureText: false,
            controller: Variables.AddCoursesesectionDescriptionController,
            textInputType: TextInputType.text,
            maxLines: 5,
            validator: (value) {
              if (value!.isEmpty) {
                return "ادخل وصف المحاضرة";
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
